terraform {
  backend "s3" {
    bucket = "terraform-state-cegait"
    key    = "prod/terraform.tfstate"
    region = "us-west-2"
  }
}
