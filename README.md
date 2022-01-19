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

# Usage
<br/>

To create an infrastructure run the following command

``` terraform apply -var-file="input.tfvars"```

Similarly to remove an infrastructure run the following command

```terraform destroy -var-file="input.tfvars"```

## Detect Secret hook
Used to detect secrets within a code base.

To create a secret baseline file run following command

```detect-secrets scan --update .secrets.baseline```
While running the pre-commit hook, if you encounter an error like

```
WARNING: You are running an outdated version of detect-secrets.
Your version: 0.13.1+ibm.27.dss
Latest version: 0.13.1+ibm.46.dss
See upgrade guide at https://ibm.biz/detect-secrets-how-to-upgrade
```

run below command

```pre-commit autoupdate```
which upgrades all the pre-commit hooks present in .pre-commit.yaml file.