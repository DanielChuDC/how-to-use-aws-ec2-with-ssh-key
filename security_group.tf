
# Our default security group to access
# the instances over SSH and HTTP


resource "aws_security_group" "default" {
  name        = "eip_example"
  description = "Used in the terraform"

  vpc_id = "${aws_vpc.example.id}"
  # SSH access from anywhere
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  // Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

}


# Define a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
   enable_dns_hostnames = true
  enable_dns_support = true
  tags ={
    Name = "test-env"
  }
}

# Define a subnet vpc
resource "aws_subnet" "my_subnet" {
  vpc_id            = "${aws_vpc.example.id}"
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf-example"
  }
}
