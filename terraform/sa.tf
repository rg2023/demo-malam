module "gke-sa" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/iam-service-account?ref=v56.2.0"
  project_id = var.project_id
  name       = var.service_account
  # authoritative roles granted *on* the service accounts to other identities
  # iam = {
  #   "roles/iam.serviceAccountUser" = ["group:${var.group_email}"]
  # }
  # non-authoritative roles granted *to* the service accounts on other resources
  iam_project_roles = {
    "${var.project_id}" = [
      "roles/logging.logWriter",
      "roles/monitoring.metricWriter",
    ]
  }
}
