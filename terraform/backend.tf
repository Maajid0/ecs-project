terraform {
  backend "s3" {
    bucket  = "terraform-state-tm-maajid"
    key     = "terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
    use_lockfile = true
  }
}