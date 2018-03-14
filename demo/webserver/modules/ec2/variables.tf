variable "instance_name" {
    description = "Used to populate the Name tag. This is done in main.tf"
    }
variable "instance_type" { }
variable "subnet_id"     {
    description = "The VPC subnet the instance(s) will go in"
    type        = "list"
    }
variable "ami_id"        { description = "The AMI to use"}

variable "number_of_instances" {
    description = "number of instances to make"
    default = 1
    }

variable "key_name"           { }
variable "public_ip_address"  { }
variable "tags"               { type = "map"  }
variable "hosted_zone"        { }
variable "vpc_security_group" { type = "list"   }
variable "root_volume_type"   { type = "string" default = "gp2" }
variable "root_volume_size"   { type = "string" default = "8"   }
variable "ebs_volume_size"    { type = "string" default = "1" }
variable "create_ebs"         { type = "string" default = "0" }
