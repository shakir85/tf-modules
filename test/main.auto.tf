resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "public_key" {
  content  = tls_private_key.this.public_key_openssh
  filename = "${path.module}/id_rsa.pub"
}
