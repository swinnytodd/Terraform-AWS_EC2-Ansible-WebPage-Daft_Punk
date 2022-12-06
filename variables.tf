variable "region" {
    description = "AWS-Region"
    type = string
    default = "eu-west-1"
}
 variable "my_server_web_tags" {
    type = map
    default = {
         Name = "Ansible-Test"
    }
 }


variable "instance_type" {
    default = "t2.micro"
}

variable "allow_ports" {
    description = "List of ports"
    type = list
    default = ["80","22", "443", "8080"]

}

