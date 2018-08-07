resource "google_compute_instance" "instance_01" {
  name         = "utb-1"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
    }
  }

  network_interface {
    subnetwork = "subnet-01"

    access_config {
      nat_ip = ""
    }
  }

  tags = ["utb"]
}
