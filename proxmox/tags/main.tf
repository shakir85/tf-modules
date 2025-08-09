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

variable "size" {
  description = "Size of the VM (e.g., small, medium, large)."
  type        = string
  default     = ""
  validation {
    condition     = contains(["small", "medium", "large"], var.size)
    error_message = "Size must be one of: small, medium, or large."
  }
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
