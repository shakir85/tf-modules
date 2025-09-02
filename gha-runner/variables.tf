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

variable "repo" {
  description = "The name of the target repository where the GHA runner will be integrated"
  type        = string
}

variable "org" {
  description = "The GitHub organization or user that owns the target repository"
  type        = string
}
