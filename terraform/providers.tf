provider "google" {
  project = var.project_id

  # Route consumer API calls (e.g. orgpolicy.googleapis.com) through this
  # project for quota/billing. Required when authenticating with user ADC,
  # otherwise these APIs reject the request for a missing quota project.
  billing_project       = var.project_id
  user_project_override = true
}
