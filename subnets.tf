resource "aws_subnet" "public-subnets" {
  #count             = 3 #0 1 2 
  count             = length(var.public-subnets_cidr) #instead of changing the count, use this to simplify
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public-subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.vpc_name}- PublicSubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private-subnets" {
  #count             = 3 #0 1 2 
  count             = length(var.private-subnets_cidr) #instead of changing the count, use this to simplify,just add subnets value at tfvars file
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private-subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.vpc_name}- PrivateSubnet-${count.index + 1}"
  }
}

