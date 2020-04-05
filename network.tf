#### Related to network

# Elastic IP
# Create Elastic Ip and associate with instance
resource "aws_eip" "ip-test-env" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

//gateways.tf
# Create aws internet gateway for vpc
resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "test-env-gw"
  }
}

//subnets.tf
# Create aws route table to route traffic in
resource "aws_route_table" "route-table-test-env" {
  vpc_id = "${aws_vpc.example.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-env-gw.id}"
  }
  tags {
    Name = "test-env-route-table"
  }
}



resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.my_subnet.id}"
  route_table_id = "${aws_route_table.route-table-test-env.id}"
}

