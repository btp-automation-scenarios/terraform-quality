variables {
  entitlements = []
}

run "test_successful_subaccount_creation" {
  command = apply

  variables {
    costcenter   = "1234567890"
    org_name     = "ECOMMERCE"
    project_name = "proj-0815"
    stage        = "TST"
    region       = "us10"
  }

  assert {
    condition     = resource.btp_subaccount.project.state == "OK"
    error_message = "The subaccount was not created in the expected state."
  }
}
