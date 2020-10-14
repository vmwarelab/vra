provider "aws" {
  region     = var.AWS_REGION
}

resource "aws_instance" "example" {
  ami           = var.AMIS
  instance_type = "t2.micro"
}

variable "AWS_REGION" {
  default = "ca-central-1"
}

variable "AMIS" {
  default = "ami-0431766daf444644c"
  }
terraform {
  backend "s3" {
    bucket = "terraform-state-vmwlab"
    key = "terraform/demo-01"
  }
}
