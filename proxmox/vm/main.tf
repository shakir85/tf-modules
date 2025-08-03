data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key_path
}

resource "random_string" "random_cloud_init_id" {
  length  = 4
  special = false
  upper   = false
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
    type    = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  dynamic "disk" {
    for_each = var.use_clone ? [] : [1]
    content {
      # Available attributes:
      # aio               = "io_uring"
      # backup            = true
      # cache             = "none"
      # discard           = "ignore"
      # file_format       = "qcow2"
      # iothread          = false
      # path_in_datastore = "101/vm-101-disk-0.qcow2"
      # replicate         = true
      # ssd               = false
      datastore_id = var.disk_name
      file_id      = "${element(var.cloud_image_info, 0)}:${element(var.cloud_image_info, 1)}"
      interface    = var.disk_interface
      size         = var.disk_size
    }
  }

  dynamic "clone" {
    for_each = var.use_clone ? [1] : []
    content {
      vm_id        = var.template_id
      full         = false
      datastore_id = var.disk_name
    }
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

    user_data_file_id = var.enable_cloud_init ? proxmox_virtual_environment_file.cloud_config[0].id : null

  }

  network_device {
    bridge = var.network_interface
    # Available attributes:
    # disconnected = false
    # enabled      = true
    firewall = var.firewall_is_enabled
    # mac_address  = "BC:24:11:42:95:87"
    # model        = "virtio"
    # mtu          = 0
    # queues       = 0
    # rate_limit   = 0
    # vlan_id      = 0
  }

  serial_device {}
}

# This section creates a cloud-init configuration file for the VM.
resource "proxmox_virtual_environment_file" "cloud_config" {
  count = var.enable_cloud_init ? 1 : 0

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

    file_name = "cloud-init-config-${var.hostname}-${random_string.random_cloud_init_id.result}.yaml"
  }
}

output "print_temp_password" {
  description = "Prints the temporary login password defined by `var.temp_user_password`. Check the variable's default value above. You'll be required to change it on your first login."
  value       = "Your login password is: ${var.temp_user_password}\nYou will be required to change the password on your first login."
}
