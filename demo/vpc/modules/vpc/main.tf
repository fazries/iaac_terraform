# Create VPC
resource "aws_vpc" "main" {
  cidr_block       = "${var.cidr_block}"
  instance_tenancy = "default"

  tags {
    Name = "${var.vpc_name}"
  }
}

# Create Subnet under new VPC
resource "aws_subnet" "main" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet_cidr_block}"

  tags {
    Name = "${var.subnet_name}"	
  }
}

# Create internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "igw-${var.vpc_name}"
  }
}

# Create Route table and reroute outgoing traffic
resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "rtable-${var.vpc_name}"
  }
}

# Create Route table association for new subnet
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.r.id}"
}


# variable vpc
variable "vpc_name"   { type = "string" }
variable "cidr_block" { type = "string" default = "10.0.0.0/16" }

# variable subnet
variable "subnet_name"       { type = "string" }
variable "subnet_cidr_block" { type = "string" default = "10.0.1.0/24" }
