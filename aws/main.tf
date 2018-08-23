provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-04169656fea786776"
  instance_type = "t2.micro"
  key_name      = "schoolofdevops"
  subnet_id     = "${aws_subnet.subnet_01.id}"
  
  tags {
    Name = "terraform-vars"
  }
}

data "aws_vpc" "demo_vpc" {
  id = "vpc-0a4308580583335b1"
}

resource "aws_subnet" "subnet_01" {
  vpc_id = "${data.aws_vpc.demo_vpc.id}"
  cidr_block = "${var.subnet_cidr}"

  tags {
    Name = "demoapp-subnet"
  }
}
