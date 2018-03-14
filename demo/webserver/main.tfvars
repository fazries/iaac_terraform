# aws region
region              = "ap-southeast-1"

# module ami
os_version          = "trusty"

# module vpc
vpc_name            = "demo-vpc"
subnet_name         = "demo-subnet"

# module security group rule
ingress_port        = ["80","22"]
cidr_blocks         = ["0.0.0.0/0"]

# module ec2
instance_type       = "t2.micro"
instance_name       = "frontend"
number_of_instances = 1
root_volume_type    = "gp2"
root_volume_size    = 8
key_name            = "demo-key"
tags                = {
                        "apps"    = "Webserver"
                        "env"     = "Development"
                      }
create_ebs          = false

# module route53
hosted_zone         = "demo.com"
