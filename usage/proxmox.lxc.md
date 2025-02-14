## Proxmox LXC Module Usage

This is an example for using the `proxmox/cloud-img-downloader` module. Refer to the [module's documentation](../proxmox/lxc/README.md) for more details.

File: `providers.tf`
```hcl
terraform {
  required_version = ">= 1.5.7"
  backend "" {
  }

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
  }
}

provider "proxmox" {
  endpoint = "https://PVE_IP_HERE:8006/"
  username = "USER@REALM" // typically root@pam
  password = ""
  # because self-signed TLS certificate is in use
  insecure = true

  ssh {
    agent       = false
    private_key = file("${var.id_rsa}")
    username    = ""
    node {
      name    = "" // typically pve
      address = "" // IPv4 without CIDR
    }
  }
}
```

File: `vars.tf`
```hcl
// Vars required to authenticate with Proxmox
variable "id_rsa_pub" {

}

variable "pve_user" {

}

variable "pve_pwd" {

}

variable "id_rsa" {

}
```

File: `main.tf`
```hcl
module "<RESOURCE_NAME>" {
  // Required Variables
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/lxc?ref=<RELEADE_ID>"
  node_name             = ""
  disk_id               = ""
  ssh_public_key_path   = ""
  username              = ""
  hostname              = ""
  template_file_id      = ""
  #
  // Optional Variables (default values presented below)
  # description           = "Manage by Terraform"
  # ip_config             = "dhcp"
  # network_interface     = "eth0"
  # os_type               = "unmanaged"
  # disk_size             = "4"
  # memory                = 1024
  # cpu_cores             = 1
  # unprivileged          = true
  # firewall              = true
}
```
