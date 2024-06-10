mock_provider "btp" {}

variables {
  globalaccount = "test"
}

run "provide_valid_costcenter" {
  command = plan

  variables {
    costcenter = "8523652147"
  }

  assert {
    condition     = var.costcenter == "8523652147"
    error_message = "Costcenter is not set correctly"
  }
}

run "provide_invalid_costcenter_with_letters" {
  command = plan

  variables {
    costcenter = "abc-123"
  }

  expect_failures = [
    var.costcenter
  ]
}  