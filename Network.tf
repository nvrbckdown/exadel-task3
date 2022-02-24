# VPC
resource "aws_vpc" "exadel-task-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        "Name" = "Exadel task VPC"
    }
}

# Internet Gateway 
resource "aws_internet_gateway" "exadel-task-igw" {
    vpc_id = aws_vpc.exadel-task-vpc.id
    tags = {    
        "Name" = "Exadel task IGW"
    }
}

# Route Tables
resource "aws_default_route_table" "Exadel_RouteTables" {
    default_route_table_id = aws_vpc.exadel-task-vpc.default_route_table_id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.exadel-task-igw.id
    }
    tags = {
        "Name" = "Exadel task RouteTables"
    }
}

# Public Subnet
resource "aws_subnet" "Exadel_Public_Subnet" {
    vpc_id = aws_vpc.exadel-task-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags = {
      "Name" = "Exadel Public Subnet"
    }
}

# Private Subnet
resource "aws_subnet" "Exadel_Private_Subnet" {
    vpc_id = aws_vpc.exadel-task-vpc.id
    cidr_block = "10.0.10.0/24"

    tags = {
      "Name" = "Exadel Private Subnet"
    }
}