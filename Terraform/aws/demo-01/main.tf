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

variable "AMIS" {
  type = map(string)
  default = {
    ca-central-1 = "ami-0431766daf444644c"
    us-east-1 = "ami-02fb3fbca2bb793f1"
    us-west-1 = "ami-0345db60aa8e3fa3d"
  }
}
