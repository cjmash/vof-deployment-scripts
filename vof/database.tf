resource "random_id" "db-name" {
  byte_length = 8
}

resource "random_id" "vof-db-user" {
  byte_length = 8
}

resource "random_id" "vof-db-user-password" {
  byte_length = 16
}

resource "google_sql_database_instance" "vof-database-instance" {
  region = "${var.region}"
  database_version = "POSTGRES_9_6"
  name = "${var.env_name}-vof-database-instance-${replace(lower(random_id.db-name.b64), "_", "-")}"
  project = "${var.project_id}"

  settings {
    tier = "${var.db_instance_tier}"
    availability_type = "REGIONAL"
    disk_autoresize = true
    ip_configuration = {
      ipv4_enabled = true
  
      authorized_networks  {
        name = "lagos 1"
        value = "41.75.89.154"
      }
      authorized_networks  {
        name = "lagos 2"
        value = "41.215.245.162"
      }
      authorized_networks  {
        name = "Nairobi"
        value = "105.21.32.62"
      }
      authorized_networks  {
        name = "home"
        value = "108.41.204.165"
      }
      authorized_networks  {
        name = "Latent View 1"
        value = "14.140.245.142"
      }
      authorized_networks  {
        name = "Latent View 2"
        value = "182.74.31.70"
      }
      authorized_networks  {
        name = "staging env"
        value = "35.190.62.2"
      }
    
    }

    backup_configuration {
      binary_log_enabled = true
      enabled = true
      start_time = "${var.db_backup_start_time}"
    }
  }
}

resource "google_sql_database" "vof-database" {
  name = "${var.env_name}-vof-database"
  instance = "${google_sql_database_instance.vof-database-instance.name}"
  charset = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_sql_user" "vof-database-user" {
  name = "${random_id.vof-db-user.b64}"
  password = "${random_id.vof-db-user-password.b64}"
  instance = "${google_sql_database_instance.vof-database-instance.name}"
  host = ""
}
