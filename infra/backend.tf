terraform {
  backend "s3" {
    bucket = "apgelnar-terraform-states"
    key    = "hlhcasbm"
    region = "eu-west-2"
  }
}
