resource "null_resource" "cluster" {
  count = var.env == "PROD" ? 3 : 1
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("kbsanu.pem")
      #host = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.public_servers.*.public_ip, count.index)
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh",
      "sudo apt update",
      "sudo apt install jq unzip -y",
      "sudo rm -f terraform",
      "curl https://get.docker.com | sudo bash",
      "sudo wget https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip",
      "sudo unzip terraform_1.9.8_linux_amd64.zip ",
      "sudo rm -f terraform_1.9.8_linux_amd64.zip && sudo chmod 777 terraform && sudo mv terraform /usr/local/bin/terraform",
      "terraform version",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("kbsanu.pem")
      #host = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.public_servers.*.public_ip, count.index)
    }
  }
  provisioner "local-exec" {
    command = <<EOH
    echo "${element(aws_instance.public_servers.*.public_ip, count.index)} >> publicip
    EOH
  }
}
