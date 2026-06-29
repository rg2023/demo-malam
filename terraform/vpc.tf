module "vpc" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc?ref=v56.2.0"
  project_id = var.project_id
  name       = "${var.vpc_name}-${terraform.workspace}"
  subnets = [
    {
      ip_cidr_range = "10.0.0.0/16"
      name          = "${var.subnet_name}-${terraform.workspace}"
      region        = var.region
      secondary_ip_ranges = {
        pods     = { ip_cidr_range = "172.16.0.0/16" }
        services = { ip_cidr_range = "192.168.0.0/24" }
      }
    }
  ]
}

