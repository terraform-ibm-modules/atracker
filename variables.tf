variable "resource_group" {
  type        = string
  description = "Name of resource group"
}

# Atracker target
variable "atracker_target_name" {
  description = "Name of the atracker target.  Default will be atracker-target-<region>"
  type        = string
  default     = null
}

variable "atracker_target_type" {
  description = "Target type for atracker"
  type        = string
  default     = "cloud_object_storage"
}

# Atracker route
variable "atracker_route_name" {
  description = "Name of the atracker route.  Default will be atracker-route-<region>"
  type        = string
  default     = null
}

variable "receive_global_events" {
  description = "Indicates whether or not all global events should be forwarded to this region."
  type        = bool
  default     = true
}
