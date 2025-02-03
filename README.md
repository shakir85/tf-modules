# Terraform Modules

This repository contains Terraform modules for managing Proxmox environment. Use these modules to automate various tasks on your Proxmox cluster. I intend to keep it clean and simple, and add more features to it.

## Provider in use

The modules in this repo use the following providers:
- [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest) For VMs, and image files.
- [telmate/proxmox](https://registry.terraform.io/namespaces/Telmate) For LXC containers.

## Modules

Currently, the following modules are available:

- [VM](proxmox/vm/) module, [Example script](./usage/proxmox.vm.md).
- [LXC module](proxmox/lxc/) module, [Example script](./usage/proxmox.lxc.md)
- [Cloud-image](proxmox/get-cloud-image/) download module.
