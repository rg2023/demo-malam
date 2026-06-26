
module "nat" {
  source         = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-cloudnat?ref=v56.2.0"
  project_id     = var.project_id
  region         = var.region
  name           = "${var.cluster_name}-nat"
  router_network = module.vpc.name
  router_create  = true
  router_name    = "${var.cluster_name}-router"
}



