data "ibm_resource_group" "cos_group" {
  name = var.resource_group
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
