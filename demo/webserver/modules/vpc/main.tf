# Get VPC ID data based on filter tag:Name
data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
}

# Get Subnet ID data based on filter tag:Name
data "aws_subnet_ids" "default_ids" {
  vpc_id = "${data.aws_vpc.default.id}"
  tags {
    Name = "${var.subnet_name}"
 }
}

data "aws_subnet" "default" {
  count = "${length(data.aws_subnet_ids.default_ids.ids)}"
  id    = "${data.aws_subnet_ids.default_ids.ids[count.index]}"
}

# get vpc id
output "vpc_id" {
    value = "${data.aws_vpc.default.id}"
}

# get subnet id
output "vpc_subnet_ids" {
    value = "${data.aws_subnet_ids.default_ids.ids}"
}

# get cidr block
output "subnet_cidr_blocks" {
    value = ["${data.aws_subnet.default.*.cidr_block}"]
}
