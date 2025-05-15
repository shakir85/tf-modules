/**
 * ## Usage
 *
 * This module provides a standardized set of tags for VMs in a Proxmox environment.
 * It allows defining consistent tags based on environment, cluster, Kubernetes flavor, OS, and role.
 * The `env` and `os` tags are set to be required by default since these are common attribute of
 * any compute resource on Proxmox.
 *
 * Example usage:
 *
 * ```hcl
 * module "tags" {
 *   source      = "git::https://github.com/<YOUR_REPO>/modules/tags?ref=<RELEASE_ID>"
 *   environment = "prod"
 *   cluster     = "main"
 *   flavor      = "k3s"
 *   os          = "debian12"
 *   role        = "worker"
 * }
 *
 * resource "proxmox_vm_qemu" "vm" {
 *   name = "k8s-worker-01"
 *   tags = [for key, value in module.tags.tags : "${key}:${value}"]
 * }
 * ```
 *
 * ## Inputs
 *
 * - `environment` - (string) Environment in which the VM is deployed. Default: `"prod"`.
 * - `cluster` - (string) Cluster name the VM is part of. Default: `""`.
 * - `flavor` - (string) Kubernetes flavor (e.g., k3s, kubeadm). Default: `""`.
 * - `os` - (string) Operating system of the VM (e.g., debian12, ubuntu). Default: `"debian12"`.
 * - `role` - (string) Role of the VM within the cluster or system. Default: `""`.
 *
 * ## Outputs
 *
 * - `tags` - A map of the generated tags in the format `key:value`, excluding empty values.
 *
 * ## Notes
 *
 * - Empty values are excluded from the `tags` output to avoid unnecessary or redundant tags.
 * - Use `null` to remove a tag rather than an empty string.
 */
terraform {
  required_version = ">= 1.5.7"
}

variable "environment" {
  description = "Environment in which the VM is deployed (e.g., prod, test, devops)."
  type        = string
}

variable "cluster" {
  description = "Cluster the VM is part of (e.g., main, utils, test). Leave empty if not applicable."
  type        = string
  default     = ""
}

variable "flavor" {
  description = "Kubernetes flavor (e.g., k3s, kubeadm). Leave empty if not applicable."
  type        = string
  default     = ""
}

variable "os" {
  description = "Operating system of the VM (e.g., debian12, ubuntu)."
  type        = string
}

variable "role" {
  description = "Role of the VM within the cluster or system (e.g., control, worker, monitoring)."
  type        = string
  default     = ""
}

output "tags" {
  description = "Consolidated set of tags for the VM, excluding empty values."
  value = tomap({
    env     = var.environment
    cluster = var.cluster != "" ? var.cluster : null
    flavor  = var.flavor != "" ? var.flavor : null
    os      = var.os
    role    = var.role != "" ? var.role : null
  })
}
