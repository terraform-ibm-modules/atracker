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

| Name        | Description      | Type    | Default | Required |
|-------------|------------------|---------|---------|----------|
|resource_group| Name of resource group  | string | n/a | yes |
|bind_resource_key | Enable this to bind key to cos instance (true/false) | bool | true | yes | 
|resource_key_name | Name of the key | string | atracker-service-key | yes | 
|bucket_name | COS Bucket name | string | n/a | yes |
|location | single site or region or cross region location info |string | n/a | yes |


## NOTE:

* If we want to make use of a particular version of module, then set the argument "version" to respective module version.
