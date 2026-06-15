variable "project_id" {
  description = "The ID of the project to prepare for the Apigee eval organization."
  type        = string
}

variable "create_default_vpc" {
  description = "Whether to create the default-equivalent VPC. Set to false if a network named 'default' already exists in the project."
  type        = bool
  default     = true
}
