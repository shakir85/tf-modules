plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

config {
  disabled_by_default = false
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}
