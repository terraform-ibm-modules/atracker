data "ibm_resource_group" "cos_group" {
  name = var.resource_group
}

module "cos" {
  source                 = "terraform-ibm-modules/cos/ibm//modules/instance"
  version                = "1.4.1"

  service_name           = var.prefix != null ? "${var.prefix}-${var.service_name}" : var.service_name
  plan                   = var.plan
  region                 = var.region
  resource_group_id      = data.ibm_resource_group.cos_group.id
  parameters             = var.parameters

  bind_resource_key      = var.bind_resource_key
  resource_key_name      = var.resource_key_name
  key_parameters         = var.key_parameters
  role                   = var.role
}

module "cos_bucket" {
  source               = "terraform-ibm-modules/cos/ibm//modules/bucket"
  version              = "1.4.1"

  bucket_name          = var.prefix != null ? "${var.prefix}-${var.bucket_name}" : var.bucket_name 
  cos_instance_id      = module.cos.cos_instance_id
  location             = var.location
  storage_class        = var.storage_class
  force_delete         = var.force_delete
  endpoint_type        = var.endpoint_type
  kms_key_crn          = var.kms_key_crn
  expire_rules         = var.expire_rules
}

resource "ibm_atracker_target" "atracker_target" {
    cos_endpoint {
        endpoint = "s3.private.${var.location}.cloud-object-storage.appdomain.cloud"
        target_crn = module.cos.cos_instance_id
        bucket = var.prefix != null ? "${var.prefix}-${var.bucket_name}" : var.bucket_name 
        api_key = module.cos.cos_key_credentials.apikey
    }
    name = (var.atracker_target_name != null ? var.atracker_target_name : "atracker-target-${var.location}")
    target_type = var.atracker_target_type
}

resource "ibm_atracker_route" "atracker_route" {
 name = (var.atracker_route_name != null ? var.atracker_route_name : "atracker-route-${var.location}")
 receive_global_events = var.receive_global_events
 rules {
     target_ids = [ ibm_atracker_target.atracker_target.id]
 }
}
