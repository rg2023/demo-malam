module "firewall" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc-firewall?ref=v56.2.0"
  project_id = var.project_id
  network    = module.vpc.name
  ingress_rules = {
    allow-health-checks = {
      description          = "Allow GCP health checks"
      source_ranges        = ["130.211.0.0/22", "35.191.0.0/16"]
      targets              = ["gke-node"]
      rules = [{ protocol = "tcp" }]
    }
     allow-http = {
      description   = "Allow HTTP traffic"
      source_ranges = ["0.0.0.0/0"]
      targets       = ["gke-node"]
      rules         = [{ protocol = "tcp", ports = ["80"] }]
    }
    allow-https = {
      description   = "Allow HTTPS traffic"
      source_ranges = ["0.0.0.0/0"]
      targets       = ["gke-node"]
      rules         = [{ protocol = "tcp", ports = ["443"] }]
    }
  }
}