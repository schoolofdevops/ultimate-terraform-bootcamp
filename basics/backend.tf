# Backend Definition
terraform {
  backend "gcs" {
    bucket  = "utb-terraform"
    prefix  = "terraform/devstate"
    project = "831165999464"
  }
}
