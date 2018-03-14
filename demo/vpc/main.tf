provider "aws" {
  region              = "ap-southeast-1"
}

module "vpc" { 
  source            = "modules/vpc"
  vpc_name          = "demo-vpc" 
  cidr_block        = "10.0.0.0/16"
  subnet_name       = "demo-subnet"
  subnet_cidr_block = "10.0.1.0/24"
}

module "dns" {
 source             = "modules/route53_zone"
 zone_name          = "demo.com"
}
