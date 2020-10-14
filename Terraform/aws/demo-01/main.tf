provider "aws" {
  region     = var.AWS_REGION
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
}

variable "AWS_REGION" {
  default = "ca-central-1"
}
