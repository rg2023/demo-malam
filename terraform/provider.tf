terraform {
  backend "gcs" {
    bucket                      = "demo-malam"
    # impersonate_service_account = "sa-iac@project-a44aae81-833b-4037-891.iam.gserviceaccount.com"
    prefix                      = "state"
  }
}
provider "google" {
#   impersonate_service_account = "sa-iac@project-a44aae81-833b-4037-891.iam.gserviceaccount.com"
}
provider "google-beta" {
#   impersonate_service_account = "sa-iac@project-a44aae81-833b-4037-891.iam.gserviceaccount.com"
}



