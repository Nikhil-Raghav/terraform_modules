data "aws_availability_zones" "available" {}


resource "aws_vpc" "modular_vpc" {
  cidr_block = var.vpc_cidr
    tags = merge(
    var.common_tags,
    { Name = "modular-vpc" }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.modular_vpc.id
}

resource "aws_subnet" "modular_public" {
  vpc_id                  = aws_vpc.modular_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
    tags = merge(
    var.common_tags,
    { Name = "modular-public-subnet" }
  )
}           

resource "aws_subnet" "modular_private" {
  vpc_id            = aws_vpc.modular_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(
    var.common_tags,
    { Name = "modular-private-subnet" }
  )

}

resource "aws_eip" "modular_nat" {
  domain = "vpc"
}


resource "aws_nat_gateway" "modular_nat" {
  allocation_id = aws_eip.modular_nat.id
  subnet_id     = aws_subnet.modular_public.id

    tags = merge(
    var.common_tags,
    { Name = "modular-nat" }
  )
}

resource "aws_route_table" "modular_public_rt" {
  vpc_id = aws_vpc.modular_vpc.id

  tags = merge(
  var.common_tags,
  { Name = "modular-public-rt" }
)
}

resource "aws_route" "modular_public_route" {
  route_table_id         = aws_route_table.modular_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.modular_public.id
  route_table_id = aws_route_table.modular_public_rt.id
}

resource "aws_route_table" "modular_private_rt" {
  vpc_id = aws_vpc.modular_vpc.id

  tags = merge(
  var.common_tags,
  { Name = "modular-private-rt" }
)
}

resource "aws_route" "modular_private_route" {
  route_table_id         = aws_route_table.modular_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.modular_nat.id
}