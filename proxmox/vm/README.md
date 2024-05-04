<!-- BEGIN_TF_DOCS -->
## Resource
Provisions a VM resource.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.1 |
| [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/0.54.0) | 0.54.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.5.1 |
| [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/0.54.0) | 0.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_file.cloud_config](https://registry.terraform.io/providers/bpg/proxmox/0.54.0/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.vm_resource](https://registry.terraform.io/providers/bpg/proxmox/0.54.0/docs/resources/virtual_environment_vm) | resource |
| [local_file.ssh_public_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_image_info"></a> [cloud\_image\_info](#input\_cloud\_image\_info) | A list of strings as the following: <br>  index 0 for storage pool (disk) name where the cloud image iso, img, qcow... etc is stored.<br>  index 1 for cloud-image file name (it must end with `.img` extension)<br>  For example: `cloud_image_info: ["local-lvm", "debian-12-generic.qcow2.img"]`. | `list(string)` | n/a | yes |
| <a name="input_cores"></a> [cores](#input\_cores) | The number of CPU cores. | `number` | `1` | no |
| <a name="input_description"></a> [description](#input\_description) | VM resource description. | `string` | `"Managed by Terraform"` | no |
| <a name="input_disk_interface"></a> [disk\_interface](#input\_disk\_interface) | Storage disk interface. Default value: `scsi0`. | `string` | `"scsi0"` | no |
| <a name="input_disk_name"></a> [disk\_name](#input\_disk\_name) | Proxmox storage pool (disk name) where the VM's disk should be stored. The disk must support the Snippet storage type as it will be used for other resources. | `string` | n/a | yes |
| <a name="input_enable_guest_agent"></a> [enable\_guest\_agent](#input\_enable\_guest\_agent) | Whether to enable the QEMU guest agent. You must install `qemu-guest-agent` - it could be installed via cloud-init. Read the 'Qemu guest agent' section in bpg/proxmox docs first. | `bool` | `false` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | VM hostname. | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The dedicated memory in megabytes | `number` | `512` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | Default node's network device bridge. Default value: `vmbr0`. | `string` | `"vmbr0"` | no |
| <a name="input_proxmox_node_name"></a> [proxmox\_node\_name](#input\_proxmox\_node\_name) | Proxmox node name. In a single-node environment, it's typically: `pve` | `string` | n/a | yes |
| <a name="input_sockets"></a> [sockets](#input\_sockets) | The number of CPU sockets. | `number` | `1` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | Path to the public SSH key to allow the default user SSH into the VM. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | List of strings for tags. For example: ['terraform', 'ubuntu']. | `list(string)` | <pre>[<br>  "terraform"<br>]</pre> | no |
| <a name="input_temp_user_password"></a> [temp\_user\_password](#input\_temp\_user\_password) | Temporary login password. Upon the first login, a prompt to change the password will be presented. Note that this is not a sudo password. The cloud-init config sets the user without a sudo password. | `string` | `"changeme"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone to be configured via `timedatectl` in cloud-init template. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Default user. This will be a sudo user and have SSH login access. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
