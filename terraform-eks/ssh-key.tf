resource "tls_private_key" "eks_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks_key" {
  key_name   = "eks-ssh-key"
  public_key = tls_private_key.eks_ssh_key.public_key_openssh

  tags = {
    Name = "eks-ssh-key"
  }
}

# Save the private key to a local file
resource "local_file" "eks_ssh_private_key" {
  content  = tls_private_key.eks_ssh_key.private_key_pem
  filename = "${path.module}/eks-ssh-key.pem"
}
