provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-fa150e85" #ubuntu 16.04 ami
  instance_type = "t1.micro"

  tags {
    Name = "my-first-terraform-instance"
  }
}
