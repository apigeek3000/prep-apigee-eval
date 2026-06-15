resource "google_compute_network" "default" {
  count = var.create_default_vpc ? 1 : 0

  project                 = var.project_id
  name                    = "default"
  auto_create_subnetworks = true

  depends_on = [google_project_service.compute]
}

resource "google_compute_firewall" "default_allow_internal" {
  count = var.create_default_vpc ? 1 : 0

  project       = var.project_id
  name          = "default-allow-internal"
  network       = google_compute_network.default[0].name
  priority      = 65534
  source_ranges = ["10.128.0.0/9"]

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "default_allow_ssh" {
  count = var.create_default_vpc ? 1 : 0

  project       = var.project_id
  name          = "default-allow-ssh"
  network       = google_compute_network.default[0].name
  priority      = 65534
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "default_allow_rdp" {
  count = var.create_default_vpc ? 1 : 0

  project       = var.project_id
  name          = "default-allow-rdp"
  network       = google_compute_network.default[0].name
  priority      = 65534
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
}

resource "google_compute_firewall" "default_allow_icmp" {
  count = var.create_default_vpc ? 1 : 0

  project       = var.project_id
  name          = "default-allow-icmp"
  network       = google_compute_network.default[0].name
  priority      = 65534
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }
}
