resource "google_compute_network" "vof-network" {
  name = "${var.env_name}-vof-network"
}

resource "google_compute_subnetwork" "vof-private-subnetwork" {
  name = "${var.env_name}-vof-private-subnetwork"
  region = "${var.region}"
  network = "${google_compute_network.vof-network.self_link}"
  ip_cidr_range = "${var.ip_cidr_range}"
}

resource "google_compute_target_pool" "vof-target-pool" {
  name = "${var.env_name}-target-pool"
  session_affinity = "CLIENT_IP_PROTO"
  health_checks = [
    "${google_compute_http_health_check.vof-app-healthcheck.name}",
  ]
}