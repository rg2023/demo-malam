module "artifact_registry" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/artifact-registry?ref=v56.2.0"
  project_id = var.project_id
  location   = var.region
  name       = var.artifact_registry_name
  format     = { docker = { standard = {} } }
  iam = {
    "roles/artifactregistry.admin" = ["serviceAccount:sa-cicd@project-a44aae81-833b-4037-891.iam.gserviceaccount.com"]
  }
}

