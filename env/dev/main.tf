module "vpc" {
    source = "../../modules/vpc"
    vpc_cidr = var.vpc_cidr
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    region = var.region
    common_tags         = var.common_tags
}

module "ec2" {
  source = "../../modules/ec2"
  subnet_id     = module.vpc.public_subnet_id
  vpc_id        = module.vpc.vpc_id
  ami           = var.ami
  instance_type = var.instance_type
  key_name =     var.key_name
}