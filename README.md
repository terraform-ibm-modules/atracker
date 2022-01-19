# IBM Cloud Atracker - Terraform Module
<br/>

This module is used to create observabillty service with activity tracking on IBM Cloud Platform with storage solution.

Atracker module provision:
- Atracker

# Compatibility
<br/>
This module is meant to use with Terraform 0.13 (and higher)

# Example Usage
<br/>

Examples found in [examples folder](https://github.ibm.com/slz-v2-poc/terraform-atracker-module/tree/master/Examples).

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

# Atrcker Inputs
<br/>

| Name        | Description      | Type    | Default | Required |
|-------------|------------------|---------|---------|----------|
|atracker_target_name| Name of the atracker target.  Default will be atracker-target-<region> | string | null | no |
|atracker_target_type | Target type for atracker | string | cloud_object_storage | yes |
|atracker_route_name | Name of the atracker route.  Default will be atracker-route-<region> | string| null | no |
|receive_global_events | Name of the atracker route.  Default will be atracker-route-<region> | bool | true | yes

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.13 (or later)
- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

## Install

### Terraform

Be sure you have the correct Terraform version (0.13), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

### Pre-commit hooks

Run the following command to execute the pre-commit hooks defined in .pre-commit-config.yaml file
```
pre-commit run -a
```
You can install pre-coomit tool using

```
pip install pre-commit
```
or
```
pip3 install pre-commit
```
## How to input varaible values through a file

To review the plan for the configuration defined (no resources actually provisioned)
```
terraform plan -var-file=./input.tfvars
```
To execute and start building the configuration defined in the plan (provisions resources)
```
terraform apply -var-file=./input.tfvars
```

To destroy the VPC and all related resources
```
terraform destroy -var-file=./input.tfvars
```

## Note

All optional parameters, by default, will be set to `null` in respective example's varaible.tf file. You can also override these optional parameters.
