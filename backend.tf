# Backend Definition
terraform {
  backend "gcs" {
    bucket  = "utb-tfstate"
    prefix  = "terraform/devstate"
    project = "schoolofdevops-01"
  }
}
