provider "google" {
  project = "schoolofdevops-01"
  region  = "us-central1"
}

resource "google_compute_instance" "instance_01" {
  name         = "webserver"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  
  network_interface {
    network = "default"
    access_config {
      nat_ip = ""
    }
  }  
}
