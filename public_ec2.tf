resource "aws_instance" "public_servers" {
  count = var.env == "PROD" ? 3 : 1
  # ami                         = var.imagename
  ami                         = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index) #Splat Syntax 
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}", "${aws_security_group.allow_access_to_webservers.id}", "${aws_security_group.with_dynamic_blocks.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "${var.vpc_name}-Public-Server-${count.index + 1}"
    Env        = var.env
    Owner      = "Sree"
    CostCenter = "ABCD"
  }
  user_data = <<-EOF
		#!/bin/bash
    sudo apt-get update
		sudo apt-get install -y nginx jq net-tools
		echo "<h1>${var.vpc_name}-Public-Server-${count.index + 1}</h1>" | sudo tee /var/www/html/index.nginx-debian.html
	EOF

  lifecycle {
    create_before_destroy = true # resource created before destroying old server
  }
}



