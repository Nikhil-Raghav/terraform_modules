region = "us-east-1"

vpc_cidr = "10.10.0.0/16"
public_subnet_cidr = "10.10.1.0/24"
private_subnet_cidr = "10.10.2.0/24"


ami = "ami-0c02fb55956c7d316"
instance_type = "t2.micro"
key_name = "linux_key1"
common_tags = {
  Environment = "Production"
  Project     = "modular-vpc"
  Owner       = "nikhil"
}

