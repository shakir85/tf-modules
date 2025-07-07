<!-- BEGIN_TF_DOCS -->
## Usage

To be updated.

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.5.7)

- <a name="requirement_local"></a> [local](#requirement\_local) (~> 2.5.1)

- <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) (0.79.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.6.3)

## Providers

The following providers are used by this module:

- <a name="provider_local"></a> [local](#provider\_local) (~> 2.5.1)

- <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) (0.79.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [proxmox_virtual_environment_container.lxc_container](https://registry.terraform.io/providers/bpg/proxmox/0.79.0/docs/resources/virtual_environment_container) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_disk_id"></a> [disk\_id](#input\_disk\_id)

Description: Storage disk identifier (name)

Type: `string`

### <a name="input_hostname"></a> [hostname](#input\_hostname)

Description: Hostname to assign to the container

Type: `string`

### <a name="input_node_name"></a> [node\_name](#input\_node\_name)

Description: The name of the node to assign the container to

Type: `string`

### <a name="input_ssh_public_key_path"></a> [ssh\_public\_key\_path](#input\_ssh\_public\_key\_path)

Description: Path to the local public key to be added to the default user's `.ssh/authorized_keys` file.

Type: `string`

### <a name="input_template_file_id"></a> [template\_file\_id](#input\_template\_file\_id)

Description: The identifier for an OS template file. The ID format is <datastore\_id>:<content\_type>/<file\_name>, for example local:iso/jammy-server-cloudimg-amd64.tar.gz.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_description"></a> [description](#input\_description)

Description: Container description

Type: `string`

Default: `"Manage by Terraform"`

### <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size)

Description: The size of the root filesystem in gigabytes (defaults to 4). When set to 0 a directory or zfs/btrfs subvolume will be created. Requires datastore\_id to be set.

Type: `string`

Default: `"4"`

### <a name="input_firewall"></a> [firewall](#input\_firewall)

Description: Whether this interface's firewall rules should be used

Type: `bool`

Default: `false`

### <a name="input_ipv4_config"></a> [ipv4\_config](#input\_ipv4\_config)

Description: The IP configuration, Value should be either `dhcp` or a static IPv4, e.g., `192.168.1.19/24`. (default to dhcp)

Type: `string`

Default: `"dhcp"`

### <a name="input_nic_name"></a> [nic\_name](#input\_nic\_name)

Description: Name of the container's network interface. It will be mapped to the `nic_bridge`

Type: `string`

Default: `"eth0"`

### <a name="input_os_type"></a> [os\_type](#input\_os\_type)

Description: OS type: Alpine, Ubunt ...etc

Type: `string`

Default: `"unmanaged"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: A list of the container tags

Type: `list(string)`

Default:

```json
[
  "lxc"
]
```

### <a name="input_temp_password"></a> [temp\_password](#input\_temp\_password)

Description: Temporary login password

Type: `string`

Default: `"changeme"`

## Outputs

No outputs.
<!-- END_TF_DOCS -->