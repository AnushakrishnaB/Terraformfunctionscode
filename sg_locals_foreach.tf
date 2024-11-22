locals {
  ingress     = distinct(var.ingress)
  egress      = distinct(var.egress)
  description = lower(var.sg_description)
}

resource "aws_security_group" "with_dynamic_blocks" {
  name        = "with_dynamic_blocks"
  description = "with_dynamic_blocks"
  vpc_id      = aws_vpc.default.id

  dynamic "ingress" {
    for_each = local.ingress
    content {
      description = local.description
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = local.egress
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  lifecycle {
    ignore_changes = [ingress, egress]
  }
}
