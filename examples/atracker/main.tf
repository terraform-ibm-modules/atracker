#####################################################
# atracker
#####################################################

provider "ibm" {
}

data "ibm_resource_group" "cos_group" {
  name = var.resource_group
}

module "cos" {
  source  = "terraform-ibm-modules/cos/ibm//modules/instance"
  version = "1.4.1"

  service_name      = var.prefix != null ? "${var.prefix}-${var.service_name}" : var.service_name
  plan              = var.plan
  region            = var.region
  resource_group_id = data.ibm_resource_group.cos_group.id
  parameters        = var.parameters

  bind_resource_key = var.bind_resource_key
  resource_key_name = var.resource_key_name
  key_parameters    = var.key_parameters
  role              = var.role
}

module "cos_bucket" {
  source  = "terraform-ibm-modules/cos/ibm//modules/bucket"
  version = "1.4.1"

  bucket_name     = var.prefix != null ? "${var.prefix}-${var.bucket_name}" : var.bucket_name
  cos_instance_id = module.cos.cos_instance_id
  location        = var.location
  storage_class   = var.storage_class
  force_delete    = var.force_delete
  endpoint_type   = var.endpoint_type
  kms_key_crn     = var.kms_key_crn
  expire_rules    = var.expire_rules
}

module "atracker" {
  source = "terraform-ibm-modules/atracker/ibm//modules/atracker"

  resource_group    = var.resource_group
  bind_resource_key = var.bind_resource_key
  resource_key_name = var.resource_key_name
  bucket_name       = var.bucket_name
  location          = var.location
  target_crn        = module.cos.cos_instance_id
  api_key           = module.cos.cos_key_credentials.apikey
}
