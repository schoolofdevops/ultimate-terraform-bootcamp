provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "ami-ef140f90"
  instance_type = "t2.micro"
  key_name = "initcron"
  
  tags {
    Name = "terraform-second-machine"
  }
}

data "aws_vpc" "demo_vpc" {
  id = "vpc-05ef5bbd5cf61b8a8"
}

resource "aws_subnet" "subnet_01" {
  vpc_id = "${data.aws_vpc.demo_vpc.id}"
  cidr_block = "${var.subnet_cidr}"

  tags {
    Name = "demoapp-subnet"
  }
}
