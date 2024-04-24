terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.54.0"
    }
  }
}

data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key_path
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
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
    file_id      = proxmox_virtual_environment_download_file.cloud_image_file.id
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
        address = var.ipv4_address
        # 'gateway' must be omitted because it's optional, and
        # it doesn't work when `address = "ducp"`
        # gateway = ""
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
        ${var.username}:${var.user_password}
    runcmd:
      - timedatectl set-timezone ${var.timezone}
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}

// The following is a workaround for a limitation in Proxmox, which doesn't support
// writing cloud images with a `.qcow2` extension. This locals block extracts
// the file name from the URL. The subsequent resource appends `.img` to it.
// The result will always be an image file name with the `.img` extension, for example,
// `foo.qcow2.img`. If you download an actual `.img` file, it will be stored as `foo.img.img`.
// For more info, refer to the provider's docs:
//  https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file#file_name
locals {
  url      = var.cloud_image_url
  url_list = split("/", var.cloud_image_url)
  filename = element(local.url_list, length(local.url_list) - 1)
}

resource "proxmox_virtual_environment_download_file" "cloud_image_file" {
  content_type = var.download_file_content_type
  datastore_id = var.disk_name
  node_name    = var.proxmox_node_name
  url          = var.cloud_image_url
  file_name    = "${local.filename}.img"
}
