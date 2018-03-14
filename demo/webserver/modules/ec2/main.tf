resource "aws_instance" "ec2_instance" {
    ami                         = "${var.ami_id}"
    count                       = "${var.number_of_instances}"
    instance_type               = "${var.instance_type}"
    key_name                    = "${var.key_name}"
    associate_public_ip_address = "${var.public_ip_address}"
    tags                        = { 
					Name              = "${var.instance_name}-${format("%02d", count.index + 1)}.${var.hosted_zone}"
                                        Application       = "${lookup(var.tags,"apps")}"                     
                                        Environment       = "${lookup(var.tags,"env")}"
				  }
    count                       = "${var.number_of_instances}"
    subnet_id                   = "${element(var.subnet_id, count.index)}"
    vpc_security_group_ids      = ["${var.vpc_security_group}"]
    root_block_device {
    volume_type           = "${var.root_volume_type}"
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = true
  }
}


resource "aws_volume_attachment" "ebs_att" {
  device_name       = "/dev/xvdf"
  volume_id         = "${element(aws_ebs_volume.default.*.id, count.index)}"
  instance_id       = "${element(aws_instance.ec2_instance.*.id, count.index)}"
  
  count             = "${var.number_of_instances}"
}

resource "aws_ebs_volume" "default" {
  availability_zone = "${element(aws_instance.ec2_instance.*.availability_zone, count.index)}"
  size              = "${var.ebs_volume_size}"
  
  count             = "${var.number_of_instances}"
}
