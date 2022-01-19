# IBM Cloud Atracker - Terraform Module
<br/>

This module is used to create observabillty service with activity tracking on IBM Cloud Platform with storage solution.

Atracker module provision:
- Atracker

# Compatibility
<br/>
This module is meant to use with Terraform 0.13 (and higher)

# Usage
<br/>

Examples found in [examples folder](https://github.ibm.com/slz-v2-poc/terraform-atracker-module/tree/master/Examples).

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
