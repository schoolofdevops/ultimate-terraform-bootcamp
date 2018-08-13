# Project Varaibles
variable "project" {
  type = "map"

  default = {
    "name" = "ultimate-terraform-bootcamp"
  }
}

# Network Variables
variable "vpc" {
  type = "map"

  default = {
    name = "utb"
    cidr = "10.100.0.0/16"
  }
}

variable "subnet" {
  type = "map"

  default = {
    name = {
      "0" = "subnet-01"
      "1" = "subnet-02"
    }

    cidr = {
      "0" = "10.100.1.0/24"
      "1" = "10.100.52.0/24"
    }
  }
}

variable "firewallname" {
  default = "utb-firewall"
}

# Compute Variables
variable "vm" {
  type = "map"

  default = {
    name  = "utb"
    type  = "n1-standard-1"
    zone  = "us-central1-a"
    image = "ubuntu-os-cloud/ubuntu-1604-lts"
  }
}

variable "ssh_user" {
  default = "vibe"
}

variable "ssh_pubkey" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_pvtkey" {
  default = "~/.ssh/id_rsa"
}

# Database Variables
variable "sql" {
  type = "map"

  default = {
    name    = "ultimate-terraform-cloudsql"
    version = "MYSQL_5_6"
    region  = "us-central"
    tier    = "D0"
  }
}

variable "sqldb_name" {
  default = "devopsdb"
}

variable "sqluser" {
  type = "map"

  default = {
    name     = "root"
    password = "utb456"
  }
}
