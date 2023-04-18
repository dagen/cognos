# Terraform Backend Details
# https://www.terraform.io/language/settings/backends/configuration

# Important Limitations on backend configuration#
# - A configuration can only provide one backend block#
# - A backend block cannot refer to named values (like input variables, locals, or data source attributes).

# Notes:
# - Terraform will need access to the S3 bucket listed here.  This cannot be a variable and must be hard-coded


terraform {
  backend "s3" {
    bucket = "dagen.tfstate"
    key    = "dagen/terraform"
    region = "us-west-2"
  }
}