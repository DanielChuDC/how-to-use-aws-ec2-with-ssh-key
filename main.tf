

#--------------------------------------------------------------------------------------------------------
#---- Main Entry
#--------------------------------------------------------------------------------------------------------
#---- Provision Instance here





# ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


# Using local resource
locals {
  common_tags = {
    environment  = "${var.environment}"
    project      = "${var.project}"
    Owner        = "${var.owner}"
  }
  extra_tags  = {
    network = "${var.network1_name}"
    support = "${var.network_support_name}"
  }
}

# create aws instance called web
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.generated_key.key_name}"

  subnet_id                   = "${aws_subnet.my_subnet.id}"

  vpc_security_group_ids= ["${aws_security_group.default.id}"]

  #Instance tags
  tags = "${merge( local.common_tags, local.extra_tags)}"
}

