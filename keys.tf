resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "SessionDemoKey"
  public_key = tls_private_key.private_key.public_key_openssh

  provisioner "local-exec" {
    command = "Echo '${tls_private_key.private_key.private_key_pem}' > server_key.pem"
  }
}

output "private_key" {
  description = "Do ***NOT** do this for production systems"
  value       = nonsensitive(tls_private_key.private_key.private_key_pem)
}