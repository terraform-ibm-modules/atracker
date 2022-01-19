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

// COS Module
variable "prefix" {
  description = "Prefix that get appended to the front of resources"
  type        = string
  default     = null
}

variable "service_name" {
  description = "Name of the instance"
  type        = string
  default     = "atracker-cos"
}

variable "plan" {
  description = "plan type"
  type        = string
  default     = "standard"
}

variable "region" {
  description = "Provisioning Region"
  type        = string
  default     = "global"
}

variable "parameters" {
  type        = map(string)
  description = "Arbitrary parameters to pass cos instance"
  default     = null
}

variable "tags" {
  type        = list(string)
  description = "Tags that should be applied to the service"
  default     = null
}

variable "bind_resource_key" {
  description = "Enable this to bind key to cos instance (true/false)"
  type        = bool
  default     = true
}

variable "resource_key_name" {
  description = "Name of the key"
  type        = string
  default     = "atracker-service-key"
}

variable "key_parameters" {
  type        = map(string)
  description = "Arbitrary parameters to pass to resourc key"
  default     = null
}

variable "key_tags" {
  type        = list(string)
  description = "Tags that should be applied to the key"
  default     = null
}

variable "role" {
  description = "Name of the user role (Valid roles are Writer, Reader, Manager, Administrator, Operator, Viewer, Editor.)"
  type        = string
  default     = "Writer"
}


// COS Bucket Module
variable "bucket_name" {
  type        = string
  description = "COS Bucket name"
}

variable "location" {
  description = "single site or region or cross region location info"
  type        = string
}

variable "storage_class" {
  description = " storage class to use for the bucket."
  type        = string
  default     = "standard"
}

variable "endpoint_type" {
  description = "endpoint for the COS bucket"
  type        = string
  default     = "public"
}

variable "kms_key_crn" {
  description = "The crn of the kms root key"
  type        = string
  default     = null
}


variable "force_delete" {
  description = "COS buckets need to be empty before they can be deleted. force_delete option empty the bucket and delete it"
  type        = bool
  default     = true
}

variable "expire_rules" {
  description = "Expiration rule for objects within the bucket"
  type = list(object({
    rule_id = string
    enable  = bool
    days    = string
    prefix  = string
  }))
  default = [{
    rule_id = "default-expiration"
    enable  = true
    days    = 90
    prefix  = ""
  }]
}