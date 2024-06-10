mock_provider "btp" {}

variables {
  globalaccount = "test"
}

run "validate_project_subaccount_domain" {
  command = plan

  variables {
    org_name     = "B2C"
    project_name = "proj 1234"
    stage        = "DEV"
  }

  assert {
    condition     = local.project_subaccount_domain == "b2c-proj-1234-dev"
    error_message = "Local variable project_subaccount_domain is not transformed correctly."
  }
}
