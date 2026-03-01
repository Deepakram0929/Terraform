// Alias provider example

provider "aws" {
   alias = "us"
   region = "us-east-1"
}

provider "aws" {
   alias = "mumbai"
   region = "ap-south-1"
}

resource "aws_instance" "one" {
  provider = aws.us
  ami = "ami-0b6c6ebed2801a5cb"
  instance_type = "t2.micro"
}

resource "aws_instance" "two" {
  provider = aws.mumbai
  ami = "ami-019715e0d74f695be"
  instance_type = "t2.micro"
}

// Using locals to create environment specific resources
// Workspace specific resources can be created using terraform.workspace variable in locals block. This will help to create separate resources for each environment (dev, test, prod) without changing the code.
# locals {
#   env = "${terraform.workspace}"
# }

# locals {
#   env = "test"
# }

# resource "aws_vpc" "one" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "${local.env}-vpc"
#   }
# }

# resource "aws_subnet" "two" {
#   vpc_id            = aws_vpc.one.id
#   availability_zone = "us-east-1a"
#   cidr_block        = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${local.env}-subnet"
#   }
# }

# resource "aws_internet_gateway" "three" {
#   vpc_id = aws_vpc.one.id
#   tags = {
#     Name = "${local.env}-igw"
#   }
# }

# resource "aws_route_table" "four" {
#   vpc_id = aws_vpc.one.id
#   route{
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.three.id
#   }
#   tags = {
#     Name = "${local.env}-rt"
#   } 
# }

# resource "aws_route_table_association" "rta" {
#   subnet_id      = aws_subnet.two.id
#   route_table_id = aws_route_table.four.id
# }

# resource "aws_instance" "ec2" {
#   ami           = "ami-0b6c6ebed2801a5cb"
#   instance_type = "t2.micro"
#   # subnet_id     = aws_subnet.two.id
#   # associate_public_ip_address = true
#   # tags = {
#   #   Name = "${local.env} -server"
#   # }
# }
