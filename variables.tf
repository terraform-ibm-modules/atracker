variable "resource_group" {
  type        = string
  description = "Name of resource group"
}

variable "target_crn" {
  type        = string
  description = "The crn of the Activity Tracking instance"
}

variable "api_key" {
  type        = string
  description = "The IBM Cloud api token"
}

variable "prefix" {
  type        = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default     = ""
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

variable "location" {
  description = "Geographic location of the route (e.g. us-south, us-east"
  type        = string
}

variable "bucket_name" {
  type        = string
  description = "Name of the bucket"
  default     = ""
}