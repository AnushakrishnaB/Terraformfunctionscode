resource "aws_eip" "nat_eip" {
  #EIP for NAT Gateway
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-subnets.0.id

  tags = {
    Name = "${var.vpc_name}-NAT-GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.default]
}
