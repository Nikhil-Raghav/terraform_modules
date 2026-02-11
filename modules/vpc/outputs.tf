output "vpc_id" {
    value = aws_vpc.modular_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.modular_public.id
}


output "private_subnet_id" {
  value = aws_subnet.modular_private.id
}