# We'll need a PEM key to access the new host

locals {
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
  key_file   = pathexpand("~/.ssh/${var.ssh_key_name}.pem")
}

locals {
  bash       = "chmod 400 ${local.key_file}"
  powershell = "icacls ${local.key_file} /inheritancelevel:r /grant:r ${var.os_username}:R"
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = var.ssh_key_name # Create an SSH key for the EC2 instance
  public_key = tls_private_key.pk.public_key_openssh
}


resource "local_file" "my_key_file" {
  content     = tls_private_key.pk.private_key_pem
  filename    = local.key_file

  provisioner "local-exec" {
    command = local.is_windows ? local.powershell : local.bash
  } 
}



# EC2 INSTANCE

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  availability_zone = "us-west-2a"  
  instance_type = "t4g.small"
  key_name = aws_key_pair.kp.key_name

  tags = {
    Name = "Cognos"
  }
}