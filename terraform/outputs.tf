output "default_network_self_link" {
  description = "Self link of the created default network, or null when create_default_vpc is false."
  value       = var.create_default_vpc ? google_compute_network.default[0].self_link : null
}

output "enabled_apis" {
  description = "The APIs enabled by this configuration."
  value = [
    google_project_service.compute.service,
    google_project_service.apigee.service,
    google_project_service.orgpolicy.service,
    google_project_service.servicenetworking.service,
  ]
}
