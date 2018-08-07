resource "google_compute_network" "utb" {
  name                    = "${var.vpc["name"]}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${lookup(var.subnet["name"], count.index)}"
  ip_cidr_range = "${lookup(var.subnet["cidr"], count.index)}"
  network       = "${google_compute_network.utb.self_link}"
  count         = "2"
}

resource "google_compute_firewall" "firewall" {
  name    = "${var.firewallname}"
  network = "${google_compute_network.utb.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3306"]
  }
}
