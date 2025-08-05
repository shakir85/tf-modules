terraform {
  required_version = "~> 1.10.5"
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
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}
