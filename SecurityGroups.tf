resource "aws_security_group" "Exadel_SecurityGroup" {
    name = "Allow TLS"
    description = "Allow TLS inbound traffic"
    vpc_id = aws_vpc.exadel-task-vpc.id

    ingress {
        description = "TLS from VPC"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP from VPC"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        description = "TLS from VPC"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP from VPC"
        from_port        = "-1"
        to_port          = "-1"
        protocol         = "icmp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        "Name" = "allow tls"
    }
}