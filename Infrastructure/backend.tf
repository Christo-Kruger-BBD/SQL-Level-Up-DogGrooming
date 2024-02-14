terraform {
  experiments = [provider_sensitive_attrs]
  backend "s3" {
    bucket = "doggroomingbucket"
    key = "dog-grooming/terraform.tfstate"  # Specify the path/key for your state file
    region = "eu-west-1"
    profile = "AdministratorAccess-263883060207"
    
  }
}