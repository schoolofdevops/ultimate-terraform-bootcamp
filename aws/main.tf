provider "aws" {
  region = "us-east-1"
}

# ec2 and vpc block

resource "aws_instance" "web" {
  ami                         = "ami-5c150e23" #ubuntu 16.04 ami
  instance_type               = "t2.micro"
  subnet_id                   = "${aws_subnet.subnet_01.id}"
  vpc_security_group_ids      = ["${aws_security_group.web.id}"]
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.local.key_name}"
  user_data                   = "${file("user-data.sh")}"

  tags {
    Name = "my-first-terraform-instance"
  }
}

resource "aws_vpc" "development" {
  cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "subnet_01" {
  vpc_id     = "${aws_vpc.development.id}"
  cidr_block = "192.168.10.0/24"

  tags {
    Name = "pubsub-01"
  }
}

resource "aws_subnet" "subnet_02" {
  vpc_id     = "${aws_vpc.development.id}"
  cidr_block = "192.168.20.0/24"

  tags {
    Name = "pubsub-02"
  }
}

resource "aws_security_group" "web" {
  name   = "terraform-course-sg"
  vpc_id = "${aws_vpc.development.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #denotes all protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = "${aws_vpc.development.id}"

  tags {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "rt_01" {
  vpc_id = "${aws_vpc.development.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev_igw.id}"
  }
}

resource "aws_route_table_association" "dev-rt-asn" {
  subnet_id      = "${aws_subnet.subnet_01.id}"
  route_table_id = "${aws_route_table.rt_01.id}"
}

resource "aws_key_pair" "local" {
  key_name   = "vibe"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4Q2TBuAD7ijkPjp+/Hl/QnrNo4hoZEz/l+UBsfvlDuJk8zfh0ivnQLtoYyXNuJ3/BjTVVIchrGo8CLZdTco//n+YBvMqgW4Wg5F92JNNkR5L5x04ELRUmC3ed1ZqbwrLmujzB33nMJ8Ld5dJjtS55KJa5MwkCaP7lqGicU2NgXe+if2DhCKW/lZyCpkkvRgmB7oEqj6aBWNjp+FMY4v6BtcmmB/+1Ry+GMvmZJO1EjSeUHAWCec3snX7TxJKHf4opwTHxknmhRKkz8+pS8rxyjiBeyncxP9jL9Tx/Zh6qmExCUfuhAWk87sjbb3j0enVs2LtzJOG9eBZ726wD83TJ vibe@vibes-MacBook-Air.local"
}


# rds block
resource "aws_db_instance" "terraform_rds" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  security_group_names = ["${aws_security_group.web.name}"]
  db_subnet_group_name = "${aws_subnet.subnet_01.id}"
  name                 = "demoapp_db"
  username             = "devops"
  password             = "utb45678"
}

resource "aws_security_group" "db" {
  name   = "demoapp-db-sg"
  vpc_id = "${aws_vpc.development.id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.subnet_01.cidr_block}"]
  }
}
