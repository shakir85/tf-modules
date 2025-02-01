terraform {
  required_version = ">= 1.5.7"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

resource "proxmox_lxc" "lxc_container" {
  target_node  = var.proxmox_node_name
  hostname     = var.hostname
  ostemplate   = "${var.lxc_template_path}:vztmpl/${var.lxc_template_file}"
  password     = var.password
  unprivileged = true

  # tags            = var.tags
  # swap            = 0
  # start           = true
  # onboot          = true

  // Terraform will crash without rootfs defined
  rootfs {
    # To allow LXC containers use 'local' pool storage, run this command on the host:
    # pvesm set local --content backup,images,iso,rootdir,snippets,vztmpl
    storage = var.disk_name
    size    = var.disk_size
  }

  network {
    name   = var.container_network_interface
    bridge = var.host_bridge_network
    ip     = var.ip_address
    # gw     = The IPv4 address belonging to the network interface's default gateway.
  }
  
  # Additional LXC features. See provider docs:
  # https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/lxc#lxc-with-advanced-features-enabled
  #
  #   features {
  #     Allow running Docker on LXC.
  #     IMPORTANT! These features will expose the host's syscall, procfs and sysfs to the client.
  #     Know the implications of these actions before proceeding.
  #     See <keyctl|nesting> in https://pve.proxmox.com/wiki/Linux_Container
  #     keyctl  = true
  #     nesting = true
  #     }

}
