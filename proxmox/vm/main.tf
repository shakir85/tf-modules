terraform {
  required_version = ">= 1.5.7"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.54.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
  }
}

data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key_path
}

resource "proxmox_virtual_environment_vm" "vm_resource" {
  name        = var.hostname
  description = var.description
  tags        = var.tags

  node_name = var.proxmox_node_name

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = var.enable_guest_agent
    # timeout = "15m"
    # trim    = false
    # type    = "virtio"
  }

  cpu {
    cores   = var.cores
    sockets = var.sockets
  }

  memory {
    dedicated = var.memory
  }

  disk {
    # Available attributes:
    # aio               = "io_uring"
    # backup            = true
    # cache             = "none"
    # discard           = "ignore"
    # file_format       = "qcow2"
    # iothread          = false
    # path_in_datastore = "101/vm-101-disk-0.qcow2"
    # replicate         = true
    # size              = 8
    # ssd               = false
    datastore_id = var.disk_name
    file_id      = "${element(var.cloud_image_info, 0)}:iso/${element(var.cloud_image_info, 1)}"
    interface    = var.disk_interface
  }

  initialization {
    # Available attributes:
    # datastore_id      = "local-lvm"
    # interface         = "ide2"
    # upgrade           = true
    # user_data_file_id = "sdd:snippets/cloud-config.yaml"
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  network_device {
    bridge = var.network_interface
    # Available attributes:
    # disconnected = false
    # enabled      = true
    # firewall     = false
    # mac_address  = "BC:24:11:42:95:87"
    # model        = "virtio"
    # mtu          = 0
    # queues       = 0
    # rate_limit   = 0
    # vlan_id      = 0
  }

  serial_device {}
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  /*
  * This section sets initial configurations required for the VM.
  * Use Ansible for additional configs/installs.
  */
  content_type = "snippets"
  datastore_id = var.disk_name
  node_name    = var.proxmox_node_name

  source_raw {
    data = <<EOF
    #cloud-config
    hostname: ${var.hostname}
    write_files:
      - path: /etc/hosts
        content: |
          127.0.0.1 ${var.hostname}
    users:
      - default
      - name: ${var.username}
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    chpasswd:
      list: |
        ${var.username}:${var.temp_user_password}
    runcmd:
      - timedatectl set-timezone ${var.timezone}
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}
