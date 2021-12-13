#####################################################
# atracker
#####################################################

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
