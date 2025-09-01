variable "create_namespace" {
  description = "Whether to create the namespace for the GHA runners"
  type        = bool
  default     = false
}

variable "kube_namespace" {
  description = "The namespace to deploy the GHA runners into"
  type        = string
}

variable "runner_name" {
  description = "The name of the GHA runner Helm release"
  type        = string
}

variable "rbac_namespaces" {
  description = "The namespaces the GHA runner will have access to"
  type        = list(string)
}

variable "repo" {
  description = "The name of the target repository where the GHA runner will be integrated"
  type        = string
}

variable "org" {
  description = "The GitHub organization or user that owns the target repository"
  type        = string
}

variable "shared_labels" {
  description = "Shared labels"
  type        = map(string)
  default = {
    "app.kubernetes.io/managed-by" = "terraform"
  }
}
