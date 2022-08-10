provider "aws" {
    region  = "us-east-1"
}

variable "ip_addresses" {
    type    = list(string)
}

// Create as many security groups as needed
resource "aws_security_group" "ssh_server" {
    count = ceil(length(var.ip_addresses) / 60)
    name = "ssh_server-${count.index}"
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = chunklist(var.ip_addresses, 60)[count.index]
    }
}
