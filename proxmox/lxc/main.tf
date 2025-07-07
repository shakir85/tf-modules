data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key_path
}

resource "proxmox_virtual_environment_container" "lxc_container" {
  description = var.description

  node_name = var.node_name

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ipv4_config
      }
    }

    user_account {
      keys = [
        trimspace(data.local_file.ssh_public_key.content)
      ]
      password = var.temp_password
    }
  }

  network_interface {
    name = var.nic_name
  }

  disk {
    datastore_id = var.disk_id
    size         = var.disk_size
  }

  operating_system {
    template_file_id = var.template_file_id
    type             = var.os_type
  }

  tags = var.tags

}
