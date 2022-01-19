# Module atracker
<br/>

## Example Usage
<br/>

```
provider "ibm" {
}

data "ibm_resource_group" "cos_group" {
  name = var.resource_group
}

resource "ibm_atracker_target" "atracker_target" {
    cos_endpoint {
        endpoint = "s3.private.${var.location}.cloud-object-storage.appdomain.cloud"
        target_crn = module.cos.cos_instance_id
        bucket = var.prefix != null ? "${var.prefix}-${var.bucket_name}" : var.bucket_name
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
}
```

# Inputs
<br/>

| Name        | Description      | Type    | Default | Required |
|-------------|------------------|---------|---------|----------|
|atracker_target_name| Name of the atracker target.  Default will be atracker-target-<region> | string | null | no |
|atracker_target_type | Target type for atracker | string | cloud_object_storage | yes |
|atracker_route_name | Name of the atracker route.  Default will be atracker-route-<region> | string| null | no |
|receive_global_events | Name of the atracker route.  Default will be atracker-route-<region> | bool | true | yes

