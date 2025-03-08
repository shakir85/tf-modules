![GitHub Release](https://img.shields.io/github/v/release/shakir85/Terraform-Modules) [![TF Docs](https://github.com/shakir85/Terraform-Modules/actions/workflows/docs.yml/badge.svg)](https://github.com/shakir85/Terraform-Modules/actions/workflows/docs.yml) [![TF Lint](https://github.com/shakir85/Terraform-Modules/actions/workflows/lint.yml/badge.svg)](https://github.com/shakir85/Terraform-Modules/actions/workflows/lint.yml) ![License](https://img.shields.io/github/license/shakir85/Terraform-Modules) ![Issues](https://img.shields.io/github/issues/shakir85/Terraform-Modules)

## Overview

This repository contains reusable Terraform modules for managing Proxmox infrastructure.

*Modules in this repo are still in pre-1.0.0 version, so anything can change at any time.*

## Usage

- [Virtual Machine module](./proxmox/vm/README.md).
- [LXC Container module](./proxmox/lxc/README.md).
- [Cloud Image Download to a PVE node](./proxmox/cloud-img-download/README.md).

## Provider in use

- [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest).

## Providers Setting

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
  username = "USER@REALM"
  password = ""
  
  # Because self-signed TLS certificate is in use
  insecure = true

  ssh {
    agent       = false
    private_key = file("/path/to/id_rsa")
    username    = ""
    node {
      name    = ""
      address = "" # IPv4 without CIDR
    }
  }
}

# Define the following variables
variable "id_rsa_pub" {

}

variable "pve_user" {

}

variable "pve_pwd" {

}

variable "id_rsa" {

}
```
