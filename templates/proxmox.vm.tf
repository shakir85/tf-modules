/*
This is a template for using the proxmox/vm module. 
For credentials, ensure you pass them securely. 
Terraform supports various methods for managing credentials, 
but always avoid adding them in plain text.
*/

// ********** providers.tf **********
terraform {
  required_version = ">= 1.5.7"
  backend "" {
  }

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

provider "proxmox" {
  endpoint = "https://PVE_IP_HERE:8006/"
  username = "USER@REALM" // typically root@pam
  password = ""
  # because self-signed TLS certificate is in use
  insecure = true

  ssh {
    agent       = false
    private_key = file("/path/to/id_rsa")
    username    = ""
    node {
      name    = "" // typically pve
      address = "" // IPv4 without CIDR
    }
  }
}

// ********** root.tf or main.tf **********
// Export the following variables as `TF_VAR_<variableName>`
// in the current running shell session
variable "id_rsa_pub" {

}

variable "pve_user" {

}

variable "pve_pwd" {

}

variable "id_rsa" {

}

module "MODULE_NAME" {
  // Required Variables
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=RELEADE_ID"
  proxmox_node_name   = ""
  disk_name           = ""
  ssh_public_key_path = ""
  username            = ""
  hostname            = ""
  timezone            = ""
  cloud_image_info    = ["STORAGE_POOL", "CLOUD_IMAGE_FILE_NAME"]
  disk_size           = ""
  #
  // Optional Variables (default values presented below)
  # description        = "Managed by Terraform"
  # tags               = ["terraform"]
  # cores              = 1
  # sockets            = 1
  # memory             = 512 # In MBs
  # temp_user_password = "changeme" # You'll need to change this password upon login
  #
  # See provider's docs: bpg/proxmox before change the below optional vars
  # disk_interface    = "scsi0"
  # network_interface = "vmbr0"
  # cpu_type          = "qemu64"
}

// Print any output block from the main module
output "module_outputs" {
  value = module.MODULE_NAME
}
