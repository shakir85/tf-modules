<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.1-rc6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 3.0.1-rc6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_lxc.lxc_container](https://registry.terraform.io/providers/telmate/proxmox/3.0.1-rc6/docs/resources/lxc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_network_interface"></a> [container\_network\_interface](#input\_container\_network\_interface) | LXC container network interface name. Default value: `eth0`. | `string` | `"eth0"` | no |
| <a name="input_disk_name"></a> [disk\_name](#input\_disk\_name) | Proxmox storage pool (disk name) where the VM's disk should be stored. | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size in Terrabyte (T), Gigabytes (G), Megabyte (M), or Kilobyte (K). For example, `8G` | `string` | n/a | yes |
| <a name="input_host_bridge_network"></a> [host\_bridge\_network](#input\_host\_bridge\_network) | Default node's network device bridge. Default value: `vmbr0`. | `string` | `"vmbr0"` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | LXC hostname. | `string` | n/a | yes |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | For setting static DHCP IP, add an IPv4 with CIDR notation. For example 10.20.30.40/24. Default value `dhcp`. | `string` | `"dhcp"` | no |
| <a name="input_lxc_template_file"></a> [lxc\_template\_file](#input\_lxc\_template\_file) | Name of the LXC container template file. For example: ubuntu-20.04-standard\_20.04-1\_amd64.tar.gz | `string` | n/a | yes |
| <a name="input_lxc_template_path"></a> [lxc\_template\_path](#input\_lxc\_template\_path) | Storage name where the LXC template is located. For example, `local` or `local-lvm`. | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Container login password. | `string` | n/a | yes |
| <a name="input_proxmox_node_name"></a> [proxmox\_node\_name](#input\_proxmox\_node\_name) | Proxmox node name where the container will be deployed. In a single-node environment, it's typically: `pve` | `string` | n/a | yes |
| <a name="input_swap"></a> [swap](#input\_swap) | A number that sets the amount of swap memory available to the container. Default is `0`. | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags of the container in a single string and semicolon-delimited (e.g. `terraform;test`).. | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->