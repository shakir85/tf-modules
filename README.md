# Terraform Modules

This repository contains Terraform modules for managing Proxmox environment. Use these modules to automate various tasks on your Proxmox cluster. I intend to keep it clean and simple, and add more features to it.

## Provider in use
The modules in this repo use the following providers
- [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest) For VMs, and image files.
- [telmate/proxmox](https://registry.terraform.io/namespaces/Telmate) For LXC containers.

## Modules

Currently, the following modules are available:

- For [VM provisioning](proxmox/vm/).
- For [LXC provisioning](proxmox/lxc/)
- For [Cloud-image downloads](proxmox/get-cloud-image/)
