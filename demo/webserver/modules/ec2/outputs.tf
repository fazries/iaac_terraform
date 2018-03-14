// Output the ID of the EC2 instance created
output "ec2_instance_id"    {value = "${aws_instance.ec2_instance.*.id}"}
//output "instance_id"        { value = "${aws_instance.ec2_instance.*.instance_id}"}
output "private_ip_address" { value = "${aws_instance.ec2_instance.*.private_ip}" }
output "public_ip_address"  { value = "${aws_instance.ec2_instance.*.public_ip}"  }
output "private_dns"        { value = "${aws_instance.ec2_instance.*.private_dns}"}
output "public_dns"         { value = "${aws_instance.ec2_instance.*.public_dns}" }

