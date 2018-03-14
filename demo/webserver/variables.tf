# variable module ec2
variable "instance_name" {
  description = "Used to populate the Name tag. This is done in main.tf"
}

variable "number_of_instances" {
  description = "number of instances to make"
  default = 1
}

variable "root_volume_type"  { type = "string" }
variable "root_volume_size"  { type = "string" }
variable "ebs_volume_size"   { type = "string" default = 1 }
variable "create_ebs"        { type = "string" }
variable "instance_type"     { }
variable "key_name"          { }
variable "tags"              { type = "map" }

# variable module vpc
variable "region"        { default = "ap-southeast-1" }
variable "vpc_name"      { }
variable "subnet_name"   { }

# variable module ami
variable "os_version"    { }

# variable module security group rules
variable "ingress_port"    { type = "list" }
variable "cidr_blocks"     { type = "list" }

# variable module route53
variable "hosted_zone"   { }
