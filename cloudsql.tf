resource "google_sql_database_instance" "utb_sql" {
  name             = "${var.sql["name"]}"
  database_version = "${var.sql["version"]}"
  region           = "${var.sql["region"]}"

  settings {
    tier = "${var.sql["tier"]}"
  }
}

resource "google_sql_database" "devopsdb" {
  name     = "${var.sqldb_name}"
  instance = "${google_sql_database_instance.utb_sql.name}"
}

resource "google_sql_user" "root" {
  name     = "${var.sqluser["name"]}"
  instance = "${google_sql_database_instance.utb_sql.name}"
  password = "${var.sqluser["password"]}"
}
