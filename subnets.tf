#toset - Set collections are unordered and cannot contain duplicate values, so the ordering of the argument elements is lost
#distinct takes a list and returns a new list with any duplicate elements removed.

locals {
  public_subnets_cidr = distinct(var.public_subnets_cidr)
}
resource "aws_subnet" "public-subnets" {
  #count             = 4 # 0 1 2 3
  #count             = length(var.public_subnets_cidr) #if no locals exists use this code.
  count             = length(local.public_subnets_cidr) #using locals
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(local.public_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-PublicSubnet-${count.index + 1}"
    Env  = var.env
  }
}

resource "aws_subnet" "private-subnets" {
  #count             = 4 # 0 1 2 4
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.vpc_name}-PrivateSubnet-${count.index + 1}"
    Env  = var.env
  }
}
