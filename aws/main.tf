provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "ami-ef140f90"
  instance_type = "t1.micro"
  key_name = "initcron"
  
  tags {
    Name = "terraform-second-machine"
  }
}
