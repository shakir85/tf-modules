<!-- BEGIN_TF_DOCS -->
## Resource
Downloads a cloud image or LXC container image which then can be used to provision a new VM/LXC resource.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.1 |
| [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/0.54.0) | 0.54.0 |

## Providers

| Name | Version |
|------|---------|
| [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/0.54.0) | 0.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.cloud_image_file](https://registry.terraform.io/providers/bpg/proxmox/0.54.0/docs/resources/virtual_environment_download_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_image_url"></a> [cloud\_image\_url](#input\_cloud\_image\_url) | URL for downloading the cloud image. | `string` | n/a | yes |
| <a name="input_proxmox_node_name"></a> [proxmox\_node\_name](#input\_proxmox\_node\_name) | Proxmox node name. In a single-node environment, it's typically: `pve`. | `string` | n/a | yes |
| <a name="input_storage_pool"></a> [storage\_pool](#input\_storage\_pool) | Proxmox storage pool (i.e. disk name) where the cloud image will be downloaded. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->