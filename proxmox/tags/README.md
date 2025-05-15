<!-- BEGIN_TF_DOCS -->
## Usage

This module provides a standardized set of tags for VMs in a Proxmox environment.
It allows defining consistent tags based on environment, cluster, Kubernetes flavor, OS, and role.
The `env` and `os` tags are set to be required by default since these are common attribute of
any compute resource on Proxmox.

Example usage:

```hcl
module "tags" {
  source      = "git::https://github.com/<YOUR_REPO>/modules/tags?ref=<RELEASE_ID>"
  environment = "prod"
  cluster     = "main"
  flavor      = "k3s"
  os          = "debian12"
  role        = "worker"
}

resource "proxmox_vm_qemu" "vm" {
  name = "k8s-worker-01"
  tags = [for key, value in module.tags.tags : "${key}:${value}"]
}
```

## Inputs

- `environment` - (string) Environment in which the VM is deployed. Default: `"prod"`.
- `cluster` - (string) Cluster name the VM is part of. Default: `""`.
- `flavor` - (string) Kubernetes flavor (e.g., k3s, kubeadm). Default: `""`.
- `os` - (string) Operating system of the VM (e.g., debian12, ubuntu). Default: `"debian12"`.
- `role` - (string) Role of the VM within the cluster or system. Default: `""`.

## Outputs

- `tags` - A map of the generated tags in the format `key:value`, excluding empty values.

## Notes

- Empty values are excluded from the `tags` output to avoid unnecessary or redundant tags.
- Use `null` to remove a tag rather than an empty string.

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5.7)

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Required Inputs

The following input variables are required:

### <a name="input_environment"></a> [environment](#input\_environment)

Description: Environment in which the VM is deployed (e.g., prod, test, devops).

Type: `string`

### <a name="input_os"></a> [os](#input\_os)

Description: Operating system of the VM (e.g., debian12, ubuntu).

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_cluster"></a> [cluster](#input\_cluster)

Description: Cluster the VM is part of (e.g., main, utils, test). Leave empty if not applicable.

Type: `string`

Default: `""`

### <a name="input_flavor"></a> [flavor](#input\_flavor)

Description: Kubernetes flavor (e.g., k3s, kubeadm). Leave empty if not applicable.

Type: `string`

Default: `""`

### <a name="input_role"></a> [role](#input\_role)

Description: Role of the VM within the cluster or system (e.g., control, worker, monitoring).

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### <a name="output_tags"></a> [tags](#output\_tags)

Description: Consolidated set of tags for the VM, excluding empty values.
<!-- END_TF_DOCS -->