 # Module atracker
<br/>

This module is used to create atracker.

# Example usage
<br/>

```
provider "ibm" {
}

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

module "atracker" {
  source                 = "terraform-ibm-modules/cos/ibm//modules/instance"

  resource_group         = var.resource_group
  bind_resource_key      = var.bind_resource_key
  resource_key_name      = var.resource_key_name
  bucket_name           = var.bucket_name
  location              = var.location
}
```

# Inputs

# atracker
| Name        | Description      | Type    | Default | Required |
|-------------|------------------|---------|---------|----------|
|resource_group| Name of resource group  | string | n/a | yes |
|bind_resource_key | Enable this to bind key to cos instance (true/false) | bool | true | yes |
|resource_key_name | Name of the key | string | atracker-service-key | yes |
|bucket_name | COS Bucket name | string | n/a | yes |
|location | single site or region or cross region location info |string | n/a | yes |

# cos
| Name        | Description      | Type    | Default | Required |
|-------------|------------------|---------|---------|----------|
|bucket_name       |COS Bucket name 		   |  string    | n/a        | yes     |
|location| single site or region or cross region location info           | string        | n/a        | no     |
|storage_class         |storage class to use for the bucket             | string        | standard        | yes     |
|endpoint_type        |endpoint for the COS bucket             | string        | public        | yes     |
|kms_key_crn         |The crn of the kms root key             |string         | null        | no      |
|force_delete | COS buckets need to be empty before they can be deleted. force_delete option empty the bucket and delete it | bool | true | yes |
|expire_rules        |Expiration rule for objects within the bucket             | list(object)     rule_id = string enable  = bool days    = string prefix  = string |  rule_id = "default-expiration" enable  = true  days    = 90 prefix  = ""        | yes     |
|prefix            | Prefix that get appended to the front of resources| string       |  null       |  no    |
|service_name      | Name of the instance  | string | atracker-cos        | yes     |
|plan              | plan type            | string        | standard        | yes      |
|region            | Provisioning Region  | string    | global        | yes     |
|parameters        |Arbitrary parameters to pass cos instance    | map(string)   | null        |  no    |
|tags              | Tags that should be applied to the service | list(string) | null | no |
|bind_resource_key |Enable this to bind key to cos instance (true/false)   |  bool       | true        | no     |
|resource_key_name | Name of the key | string | atracker-service-key | yes|
|key_parameters    |Arbitrary parameters to pass to resourc key |map(string)         |  null       |  no    |
|key_tags          |Tags that should be applied to the key | list(string) | null | no |
|role              | Name of the user role (Valid roles are Writer, Reader, Manager, Administrator, Operator, Viewer, Editor.) |string| Writer | yes  |
|atracker_target_name| Name of the atracker target.  Default will be atracker-target-<region> | string | null | no |
|atracker_target_type | Target type for atracker | string | cloud_object_storage | yes |
|atracker_route_name | Name of the atracker route.  Default will be atracker-route-<region> | string| null | no |
|receive_global_events | Name of the atracker route.  Default will be atracker-route-<region> | bool | true | yes


# Outputs
<br/>

|Name        | Description |
|------------|-------------|
|cos_instance_id |The ID of the cos instance |
|cos_instance_guid | The GUID of the cos instance |
|cos_key_id | The ID of the key |
|cos_bucket_id |The ID of the cos instance |


## NOTE:

* If we want to make use of a particular version of module, then set the argument "version" to respective module version.
