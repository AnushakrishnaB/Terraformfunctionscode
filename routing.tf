resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "${var.vpc_name}-Public-RT"
    Env  = var.env
  }
}

resource "aws_route_table" "terraform-private" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "${var.vpc_name}-Private-RT"
    Env  = var.env
  }
}

resource "aws_route_table_association" "public-subnets" {
  #count          = 4
  #count          = length(var.public_subnets_cidr)
  count          = length(local.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index) #Splat Syntax
  route_table_id = aws_route_table.terraform-public.id                  #Implicit Dependency: route table will be created first and then association happens.
}

resource "aws_route_table_association" "private-subnets" {
  #count          = 4
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private-subnets.*.id, count.index) #Splat Syntax
  route_table_id = aws_route_table.terraform-private.id
}
