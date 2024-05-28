# Terraform Modules

This repository contains Terraform modules for managing Proxmox environment. Use these modules to automate various tasks on your Proxmox cluster. I intend to keep it clean and simple, and add more features to it.

## Provider in use
The modules in this repo use the [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest) provider. It's one of the widely used and consistent open-source Terraform providers for Proxmox, supporting a wide range of operations. I previously used the Telmate/proxmox provider, but I had a terrible experience with its inconsistent API and arbitrary breaking updates.

## Modules

Currently, the following modules are available:

- For [VM provisioning](proxmox/vm/).
- For [Cloud-image downloads](proxmox/get-cloud-image/)
