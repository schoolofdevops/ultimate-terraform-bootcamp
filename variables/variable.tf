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
