
output "aws_instance.web.*.public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "address" {
  value = "${aws_instance.web.private_ip}"
}

output "elastic ip" {
  value = "${aws_eip.ip-test-env.public_ip}"
}


output "keyfile_name" {
  value = "${var.key_name}"
}
