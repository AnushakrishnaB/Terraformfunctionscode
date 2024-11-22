resource "aws_iam_user" "admin_users_count" {
  count = length(var.users)
  name  = element(var.users, count.index)
  tags = {
    Name = element(var.users, count.index)
    Env  = var.env
  }
}

resource "aws_iam_user" "admin_users_foreach" {
  for_each = toset(var.users2)
  name     = each.value
  tags = {
    Name = each.value
    Env  = var.env
  }
}

#Set collections are unordered and cannot contain duplicate values, so the ordering of the argument elements is lost.
