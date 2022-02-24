provider "aws" {}

resource "aws_instance" "Web_Server" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.Exadel_SecurityGroup.id]
    subnet_id = aws_subnet.Exadel_Public_Subnet.id
    user_data = file("./Files/setup_page.sh")
    key_name = "accesser"

    tags = {
        "Name"  = "Web server"
        "Owner" = "Abdulkodir Yusupov"
        }
}

resource "aws_instance" "Listener_Server" {
    ami       = data.aws_ami.rhel_8_5.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.Exadel_Private_Subnet.id
    vpc_security_group_ids = [aws_security_group.Exadel_SecurityGroup.id]
    key_name = "accesser"
    tags = {
        "Name"  = "Listener server"
        "Owner" = "Abdulkodir Yusupov"
        }
}

# Ubuntu 20.04
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"] # Canonical
}


# RHEL 8.5
data "aws_ami" "rhel_8_5" {
    most_recent = true
    
    filter {
        name   = "name"
        values = ["RHEL-8.5*"]
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["309956199498"] // Red Hat's Account ID
}