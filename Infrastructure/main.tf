module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.0"
}
provider "aws" {
  region = "eu-west-1"
  profile = "AdministratorAccess-263883060207"
}