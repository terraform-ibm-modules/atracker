#####################################################
# Atracker
#####################################################

output "atracker_instance_id" {
  description = "The ID of the atracker"
  value       = concat(ibm_atracker.atracker_target.*.id, [""])[0]
}

#output "atracker_crn" {
#  description = "The CRN of atracker"
#  value       = 
#}

output "atracker_route_id" {
  description = "The ID of the atracker route"
  value       = concat(ibm_atracker_target.atracker_target.*.id, [""])[0]
}

output "atracker_target_crn" {
  description = "The CRN of atracker target"
  value       = concat(ibm_atracker.atracker_target.*.target_crn, [""])[0]
}