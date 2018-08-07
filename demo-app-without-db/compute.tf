resource "google_compute_instance" "instance_01" {
  name         = "${var.vm["name"]}"
  machine_type = "${var.vm["type"]}"
  zone         = "${var.vm["zone"]}"

  boot_disk {
    initialize_params {
      image = "${var.vm["image"]}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnet.0.self_link}"

    access_config {
      nat_ip = ""
    }
  }

  metadata {
    sshKeys = "${var.ssh_user}:${file(var.ssh_pubkey)}"
  }

  provisioner "file" {
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file(var.ssh_pvtkey)}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/user-data.sh",
      "/tmp/user-data.sh",
    ]

    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file(var.ssh_pvtkey)}"
    }
  }

  tags = ["utb"]
}
