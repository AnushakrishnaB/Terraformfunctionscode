resource "aws_instance" "private_servers" {
  count                       = var.env == "PROD" ? 3 : 1
  ami                         = var.imagename
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.private-subnets.*.id, count.index) #Splat Syntax
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}", "${aws_security_group.allow_access_to_webservers.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "${var.vpc_name}-Private-Server-${count.index + 1}"
    Env        = var.env
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
  user_data  = <<-EOF
		#!/bin/bash
    sudo apt-get update
		sudo apt-get install -y nginx jq net-tools
		echo "<h1>${var.vpc_name}-Private-Server-${count.index + 1}</h1>" | sudo tee /var/www/html/index.nginx-debian.html
	EOF
  depends_on = [aws_nat_gateway.nat_gw] # Explicit dependency: nat gateway will be created first and then servers will be created.
  lifecycle {
    prevent_destroy = true # doesn't allow to delete the resource
  }
  lifecycle {
    ignore_changes = [tags] # allow portal changes and doesn't impact Infra code to rebuilt
  }

}

