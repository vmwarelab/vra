provider "aws" {
  region     = "ca-central-1"
}

resource "aws_instance" "Ubuntu_20_04" {
  ami           = "ami-0431766daf444644c"
  instance_type = "t2.micro"
}
