module "cluster" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gke-cluster-standard?ref=v56.2.0"
  project_id = var.project_id
  name       = "${var.cluster_name}-${terraform.workspace}"
  location   = var.region
  deletion_protection = false
  access_config = {
    ip_access = {
      authorized_ranges = {
        internal-vms = "10.0.0.0/16"
        my-machine = "34.34.105.203/32"
      }
    }
    dns_access = {
      allow_external_traffic = true
    }
     private_nodes = true
  }
  vpc_config = {
    network    =  module.vpc.self_link
    subnetwork = module.vpc.subnets["${var.region}/${var.subnet_name}-${terraform.workspace}"].self_link
    secondary_range_names = {
      pods     = "pods"
      services = "services"
    }
  }
  max_pods_per_node = 32
  labels = {
    environment = "dev"
  }
}

module "node_pool" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gke-nodepool?ref=v56.2.0"
  project_id = var.project_id
  cluster_name =   module.cluster.name
  location     = var.region
  name         = "${var.node_pool_name}-${terraform.workspace}"
  tags         = ["gke-node"] 
  node_config = {
    machine_type = "e2-medium" 
    disk_type    = "pd-standard"
    autoscaling = {
      max_node_count = 2
      min_node_count = 1
  }
  }
  service_account = {
    email        = module.gke-sa.email
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
  depends_on = [
    google_service_account_iam_member.gke_sa_user
  ]

}