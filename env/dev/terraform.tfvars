region = "us-east-1"

vpc_cidr = "10.10.0.0/16"
public_subnet_cidr = "10.10.1.0/24"
private_subnet_cidr = "10.10.2.0/24"
key_name = "linux_key1"

ami = "ami-0c02fb55956c7d316"
instance_type = "t2.micro"

common_tags = {
  Environment = "dev"
  Project     = "modular-vpc"
  Owner       = "nikhil"
}

