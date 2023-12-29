provider "aws" {
  region                   = "sa-east-1"
  profile                  = "multicode"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  default_tags {
    tags = {
      owner      = "Multicode"
      email      = "andre.ferreira@multicode.dev.br"
      managed-by = "terraform"
    }
  }
}