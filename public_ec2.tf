resource "aws_instance" "public-servers" {
  count                       = 3
  ami                         = var.imagename
  instance_type               = var.instance_type
  key_name                    = var.keyname
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "${var.vpc_name}- Public-Server-${count.index + 1}"
    Env        = var.env
    Owner      = "Anu"
    CostCenter = "ABCD"
  }
  user_data  = <<-EOF
   #!/bin/bash
   sudo apt get update
   sudo apt-get install -y nginx jq net-tools
   echo "<h1>${var.vpc_name}-PublicServer-${count.index + 1}</h1>" | sudo tee /var/www/html/index.nginx-debian.html
 EOF
  depends_on = [aws_internet_gateway.default]
}

