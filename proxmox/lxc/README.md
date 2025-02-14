<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.1 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.70.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.5.1 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.70.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_container.lxc_container](https://registry.terraform.io/providers/bpg/proxmox/0.70.0/docs/resources/virtual_environment_container) | resource |
| [random_password.lxc_container_password](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/password) | resource |
| [local_file.ssh_public_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | The number of CPU cores | `number` | `1` | no |
| <a name="input_description"></a> [description](#input\_description) | Container description | `string` | `"Manage by Terraform"` | no |
| <a name="input_disk_id"></a> [disk\_id](#input\_disk\_id) | Storage disk identifier (name) | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The size of the root filesystem in gigabytes (defaults to 4). When set to 0 a directory or zfs/btrfs subvolume will be created. Requires datastore\_id to be set. | `string` | `"4"` | no |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Whether this interface's firewall rules should be used | `bool` | `true` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname to assign to the container | `string` | n/a | yes |
| <a name="input_ip_config"></a> [ip\_config](#input\_ip\_config) | The IP configuration (default to dhcp) | `string` | `"dhcp"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The dedicated memory in megabytes | `number` | `1024` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | A network interface | `string` | `"eth0"` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | The name of the node to assign the container to | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | OS type: Alpine, Ubunt ...etc | `string` | `"unmanaged"` | no |
| <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path) | Path to the local public key to be added to the default user's `.ssh/authorized_keys` file. | `string` | n/a | yes |
| <a name="input_template_file_id"></a> [template\_file\_id](#input\_template\_file\_id) | The identifier for an OS template file. The ID format is <datastore\_id>:<content\_type>/<file\_name>, for example local:iso/jammy-server-cloudimg-amd64.tar.gz. | `string` | n/a | yes |
| <a name="input_unprivileged"></a> [unprivileged](#input\_unprivileged) | Whether the container runs as unprivileged on the host | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->