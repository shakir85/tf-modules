## Proxmox LXC Module Usage

This is a template for using the `proxmox/lxc` module. 
For credentials, ensure you pass them securely and 
avoid adding them in plain text.

File: `providers.tf`

```hcl
terraform {
  required_version = ">= 1.5.7"
  backend "" {
  }

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  // Export the following environment variables to authenticate with proxmox:
  # export PM_API_TOKEN_ID="<username>@pam!<tokenName>"
  # export PM_API_TOKEN_SECRET="xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
  pm_api_url      = "https://PVE_IP_HERE:8006/api2/json"
  pm_tls_insecure = true

  # Enable the following attributes for debugging:
  # pm_debug        = true
  # pm_log_file     = "terraform-plugin-proxmox.log"
  # pm_log_enable   = true
  # pm_log_levels   = {
  #   _default    = "debug"
  #   _capturelog = ""
  # }
}
```

File: `main.tf`
```hcl
module "MODULE_NAME" {
  # Required Variables
  source            = "git::https://github.com/shakir85/terraform_modules.git//proxmox/lxc?ref=RELEADE_ID"
  proxmox_node_name = ""
  hostname          = ""
  lxc_template_file = ""
  lxc_template_path = ""
  password          = ""
  disk_name         = ""
  disk_size         = ""

  # Optinal Variables (default values presented below)
  # tags                        = null
  # swap                        = 0 (disabled)
  # container_network_interface = "eth0"
  # host_bridge_network         = "vmbr0"
  # ip_address                  = "dhcp"
}
```
