module "gke-sa" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/iam-service-account?ref=v56.2.0"
  project_id = var.project_id
  name       = var.service_account

  iam_project_roles = {
    "${var.project_id}" = [
      "roles/logging.logWriter",
      "roles/monitoring.metricWriter",
    ]
  }
}

resource "google_service_account_iam_member" "gke_sa_user" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${module.gke-sa.email}"
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:sa-iac@project-a44aae81-833b-4037-891.iam.gserviceaccount.com"
}
