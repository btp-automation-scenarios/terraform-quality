###
# Setup of names in accordance to the company's naming conventions
###
locals {
  project_subaccount_name   = "${var.org_name} | ${var.project_name}: CF - ${var.stage}"
  project_subaccount_domain = lower(replace("${var.org_name}-${var.project_name}-${var.stage}", " ", "-"))
}

###
# Creation of subaccount
###
resource "btp_subaccount" "project" {
  name      = local.project_subaccount_name
  subdomain = local.project_subaccount_domain
  region    = lower(var.region)
  labels = {
    "stage"      = ["${var.stage}"],
    "costcenter" = ["${var.costcenter}"]
  }
  usage = "NOT_USED_FOR_PRODUCTION"
}

###
# Assignment of entitlements
###
resource "btp_subaccount_entitlement" "entitlements" {
  for_each = {
    for index, entitlement in var.entitlements :
    index => entitlement
  }

  subaccount_id = btp_subaccount.project.id
  service_name  = each.value.name
  plan_name     = each.value.plan
}
