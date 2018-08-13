resource "google_sql_database_instance" "utb_sql" {
  name             = "${var.sql["name"]}"
  database_version = "${var.sql["version"]}"
  region           = "${var.sql["region"]}"

  settings {
    tier = "${var.sql["tier"]}"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks = {
        name = "${google_compute_instance.instance_01.name}"
        value = "${google_compute_instance.instance_01.network_interface.0.access_config.0.assigned_nat_ip}" 
      }
    }
  }
}

resource "google_sql_database" "devopsdb" {
  name     = "${var.sqldb_name}"
  instance = "${google_sql_database_instance.utb_sql.name}"
}

resource "google_sql_user" "root" {
  name     = "${var.sqluser["name"]}"
  instance = "${google_sql_database_instance.utb_sql.name}"
  host     = "%"
  password = "${var.sqluser["password"]}"
}

resource "null_resource" "populate_db_01" {
  provisioner "local-exec" {
    command = "ssh vibe@${google_compute_instance.instance_01.network_interface.0.access_config.0.assigned_nat_ip} 'sudo sed -i -e 's/DBHOST/${google_sql_database_instance.utb_sql.ip_address.0.ip_address}/g' /var/www/html/config.ini'"
  }
}

resource "null_resource" "populate_db_02" {
  provisioner "local-exec" {
    command = "ssh vibe@${google_compute_instance.instance_01.network_interface.0.access_config.0.assigned_nat_ip} 'sudo sed -i -e 's/SQLUSER/${var.sqluser["name"]}/g' /var/www/html/config.ini'"
  }

}
resource "null_resource" "populate_db_03" {
  provisioner "local-exec" {
    command = "ssh vibe@${google_compute_instance.instance_01.network_interface.0.access_config.0.assigned_nat_ip} 'sudo sed -i -e 's/SQLPASSWORD/${var.sqluser["password"]}/g' /var/www/html/config.ini'"
  }
}

resource "null_resource" "populate_db_04" {
  provisioner "local-exec" {
    command = "ssh vibe@${google_compute_instance.instance_01.network_interface.0.access_config.0.assigned_nat_ip} 'sudo sed -i -e 's/SQLDBNAME/${var.sqldb_name}/g' /var/www/html/config.ini'"
  }
}

resource "null_resource" "populate_db_05" {
  provisioner "local-exec" {
    command = "ssh vibe@${google_compute_instance.instance_01.network_interface.0.access_config.0.assigned_nat_ip} 'sudo service apache2 restart'"
  }
}
