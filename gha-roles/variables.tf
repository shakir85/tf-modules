variable "runner_service_account_name" {
  description = "The name of the ServiceAccount in the CI/CD namespace."
  type        = string
}

variable "runner_service_account_namespace" {
  description = "Namespace where the runner's ServiceAccount resides."
  type        = string
}

variable "target_namespaces" {
  description = "Namespaces where runner needs access to."
  type        = list(string)
}

variable "role_name" {
  description = "Name of the Role to create in the target namespace. Ideally, this should match the GHA runner name for clarity."
  type        = string
}

variable "shared_labels" {
  description = "Shared labels."
  type        = map(string)
  default = {
    "app.kubernetes.io/managed-by" = "terraform"
  }
}
