## Cloud Image Downloader Module Usage

This is an example for using the `proxmox/cloud-img-downloader` module. Refer to the [module's documentation](../proxmox/cloud-img-download/README.md) for more details.

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
module "<<RESOURCE_NAME>>" {
  // Required Variables
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/cloud-img-download?ref=<RELEADE_ID>"
  proxmox_node_name   = ""
  cloud_image_url     = ""
  storage_pool        = ""
}
```
