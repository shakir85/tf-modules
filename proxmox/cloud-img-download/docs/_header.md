## Usage

This is an example for using the `proxmox/cloud-img-download` module and the required variables. Get the release ID from the [releases page](https://github.com/shakir85/proxmox-tf-modules/releases).

```hcl
module "<NAME>" {
 source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/cloud-img-download?ref=<RELEADE_ID>"
 proxmox_node_name   = ""
 cloud_image_url     = ""
storage_pool         = ""
}
```

## Image Names Explaination

The `locals` block in the module is a work around a Proxmox limitation related to saving cloud images with `.qcow2` extension. This `locals` block extracts the file name from the provided URL, and the subsequent resource appends `.img` to it. As a result, the final image file will always have the `.img` extension. For example, a `.qcow2` file will be stored as `foo.qcow2.img`, while an existing `.img` file will be renamed to `foo.img.img`. For more details, refer to the [provider's documentation](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file#file_name).
