terraform {
  required_version = "~> 1.5.7"
  backend "local" {
    path = "./smoke.tfstate"
  }

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.5.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://10.10.50.20:8006/"
  insecure  = true
  api_token = var.api_token
}

provider "random" {}

resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "public_key" {
  content  = tls_private_key.this.public_key_openssh
  filename = "${path.module}/id_rsa.pub"
}

module "smoke_test" {
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=BRANCH_PLACEHOLDER"
  proxmox_node_name   = "pve1"
  disk_name           = "sdc"
  ssh_public_key_path = "${path.module}/id_rsa.pub"
  username            = random_pet.name.id
  hostname            = "smoke-test-${random_pet.name.id}"
  timezone            = "Etc/UTC"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  disk_size           = "20"
  memory              = 1028
}
