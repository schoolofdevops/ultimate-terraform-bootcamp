resource "google_compute_network" "utb" {
  name                    = "utb"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-01"
  ip_cidr_range = "10.100.1.0/24"
  network       = "utb"
}
