###
# Depending on how you handle privledge escalation you will need to either uncomment line for role_arn
# or lines shared_credentials_file, and profile
# State files do now allow for variables.  So everything needs to be explicit.
###
terraform {
  
  backend "s3" {
    region                 = "us-east-1"
    bucket                 = "gov-prod-public-state"
    key                    = "patching/gov-prod-public-state"
    encrypt                = true
   #role_arn               = "arn:aws:iam::012345678912:role/SomeAdminRole"
   #profile                 = "someone_doing_stuff"
  }
}

