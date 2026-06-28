# IP סטטי קבוע
resource "google_compute_global_address" "lb_ip" {
  name    = "demoapp-ip"
  project = var.project_id
}

# DNS Zone
resource "google_dns_managed_zone" "demoapp" {
  name        = "demoapp-zone"
  dns_name    = "demoapp.com."
  project     = var.project_id
  visibility  = "public"
}

# DNS Record
resource "google_dns_record_set" "demoapp" {
  name         = "demoapp.com."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.demoapp.name
  project      = var.project_id
  rrdatas      = [google_compute_global_address.lb_ip.address]
}

resource "google_compute_managed_ssl_certificate" "demoapp" {
  name    = "demoapp-cert"
  project = var.project_id
  managed {
    domains = ["demoapp.com"]
  }
}