output "vpc_id" {
  value = aws_vpc.default.id
}

output "public-subnet-1" {
  value = aws_subnet.public-subnets.0.id
}

output "public-subnet-2" {
  value = aws_subnet.public-subnets.1.id
}

output "public-subnet-3" {
  value = aws_subnet.public-subnets.2.id
}

output "all-public-subnets" {
  value = aws_subnet.public-subnets.*.id
}

output "all-private-subnets" {
  value = aws_subnet.private-subnets.*.id
}
