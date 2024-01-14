provider "aws" {
  alias   = "sa"
  region  = "sa-east-1"
  profile = "dkneipp-admin" # Change this to your local AWS profile name
}

provider "aws" {
  alias   = "eu"
  region  = "eu-central-1"
  profile = "dkneipp-admin" # Change this to your local AWS profile name
}
