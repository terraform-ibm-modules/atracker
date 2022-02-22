
######################################################
# atracker
######################################################

output "atracker_route_id" {
  description = "The ID of the atracker route"
  value       = concat(ibm_atracker_target.atracker_target.*.id, [""])[0]
}

output "atracker_target_crn" {
  description = "The CRN of atracker target"
  value       = concat(ibm_atracker_target.atracker_target.*.crn, [""])[0]
}
