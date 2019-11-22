#--------------------------------------------------------------------------------------------------------
#---- SSH key related
#--------------------------------------------------------------------------------------------------------
#---- Define constaints that are appended to ssh file names when the files are copied.
locals {
  pub = ".pub"
  priv = ".priv"
}


# SSH KEY

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096

    provisioner "local-exec" {
    command = "cat > ${var.key_name} <<EOL\n${tls_private_key.ssh.private_key_pem}\nEOL"
  }
  # copy private key to local file named {ssh_key_name}.priv
  provisioner "local-exec" {
    command = "cp ${var.key_name} ${var.key_name}${local.priv}"
  }
  # save public key to {name}.pub
  provisioner "local-exec" {
    command = "cat > ${var.key_name}${local.pub} <<EOL\n${tls_private_key.ssh.public_key_openssh}\nEOL"
  }
  #---- Change privledges of key file
  provisioner "local-exec" {
    command = "chmod 600 ${var.key_name}"
  }
}



resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}
