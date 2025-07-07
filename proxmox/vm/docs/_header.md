## Usage

This is an example for using the `proxmox/vm` module and the required variables. Get the release ID from the [releases page](https://github.com/shakir85/proxmox-tf-modules/releases).

```hcl
module "<NAME>" {
  # Required Variables
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=<RELEADE_ID>"
  proxmox_node_name   = ""
  disk_name           = ""
  ssh_public_key_path = ""
  username            = ""
  hostname            = ""
  timezone            = ""
  cloud_image_info    = ["STORAGE_POOL", "CLOUD_IMAGE_FILE_NAME"]
  disk_size           = ""
  # Optional Variables (default values presented below)
  description        = "Managed by Terraform"
  tags               = ["terraform"]
  cores              = 1
  sockets            = 1
  memory             = 512
  temp_user_password = "changeme" # You'll be asked to change this password upon your first login
  See provider's docs: bpg/proxmox before change the below optional vars
  disk_interface    = "scsi0"
  network_interface = "vmbr0"
  cpu_type          = "qemu64"
}
# Print any output block from the main module
output "module_outputs" {
  value = module.<NAME>
}
```

