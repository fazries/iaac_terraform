provider "aws" {
  region              = "${var.region}"
}

module "ami" {
  source              = "modules/ami"
  os_version          = "${var.os_version}"
}

module "vpc" {
  source              = "modules/vpc"
  vpc_name            = "${var.vpc_name}"
  subnet_name         = "${var.subnet_name}"
}

module "ec2_instance" {
  source              = "modules/ec2"
  ami_id              = "${module.ami.ami_id}"
  subnet_id           = "${module.vpc.vpc_subnet_ids}"
  instance_type       = "${var.instance_type}"
  instance_name       = "${var.instance_name}"
  root_volume_type    = "${var.root_volume_type}"
  root_volume_size    = "${var.root_volume_size}"
  number_of_instances = "${var.number_of_instances}"
  tags                = "${var.tags}"
  key_name            = "${var.key_name}"
  public_ip_address   = true
  vpc_security_group  = ["${module.security_group.sg_id}"]
  hosted_zone         = "${var.hosted_zone}"
}

module "route53" {
  source              = "modules/route53"
  hosted_zone         = "${var.hosted_zone}"
  record_name         = "${var.instance_name}"
  ec2_eip             = ["${module.ec2_instance.private_ip_address}"]
  count               = "${var.number_of_instances}"
}

module "security_group" {
  source              = "modules/security_group"
  name                = "secgroup ${var.instance_name}"
  vpc_id              = "${module.vpc.vpc_id}"
  tags                = "${var.tags}"
}

module "security_group_rules" {
  source             = "modules/security_group_role_cidr"
  security_group_id  = "${module.security_group.sg_id}"
  ingress_port       = "${var.ingress_port}"
  cidr_blocks        = "${var.cidr_blocks}"
}
