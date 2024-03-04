include "root" {
  path = find_in_parent_folders()
}

include "_common" {
  path = "${dirname(find_in_parent_folders())}/_common/terragrunt.hcl"
}