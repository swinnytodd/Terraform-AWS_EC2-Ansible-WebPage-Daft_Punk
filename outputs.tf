output "my_server_ip" {
  value = aws_instance.my_server_web.public_ip
}

output "my_instance_id" {
  value = aws_instance.my_server_web.id
}

output "my_sg_id" {
  value = aws_security_group.ansible.id
}