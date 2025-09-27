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
    enabled = true
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
    # ssd               = false
    datastore_id = var.disk_name
    file_id      = "${element(var.cloud_image_info, 0)}:iso/${element(var.cloud_image_info, 1)}"
    interface    = var.disk_interface
    size         = var.disk_size
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
    firewall    = var.firewall_is_enabled
    mac_address = var.mac_address != null ? var.mac_address : null
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
    data = templatefile("${path.module}/cloud-init.yaml", {
      hostname = var.hostname
      timezone = var.timezone
      ssh_key  = trimspace(data.local_file.ssh_public_key.content)
    })
    file_name = "cloud-init-config-${var.hostname}-${random_string.random_cloud_init_id.result}.yaml"
  }
}
