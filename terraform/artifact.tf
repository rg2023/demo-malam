module "artifact_registry" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/artifact-registry?ref=v56.2.0"
  project_id = var.project_id
  location   = var.region
  name       = "${var.artifact_registry_name}-${terraform.workspace}"
  format     = { docker = { standard = {} } }
  
  iam = {
    "roles/artifactregistry.reader" = ["serviceAccount:${module.gke-sa.email}"]
  }
}