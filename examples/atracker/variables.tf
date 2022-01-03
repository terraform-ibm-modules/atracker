#####################################################
# atracker
#####################################################

variable "resource_group" {
  description = "Enter Name of the resource group"
  type        = string
}

variable "bind_resource_key" {
  description = "Enable this to bind key to cos instance (true/false)"
  type        = bool
  default     = false
}

variable "resource_key_name" {
  description = "Name of the instance key"
  type        = string
  default     = ""
}

variable "bucket_name" {
  type        = string
  description = "COS Bucket name"
}

variable "location" {
  description = "single site or region or cross region location info"
  type        = string
}

