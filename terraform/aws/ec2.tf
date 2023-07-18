data "template_file" "startup" {
  template = file("./templates/startup.sh.tpl")
}

resource "aws_key_pair" "ssh-keys" {
  key_name   = "${var.project}-ssh-keys"
  public_key = file("./templates/public-key.pub")
}

resource "aws_instance" "ssh_host" {
  ami           = "ami-024e6efaf93d85776" # Ubuntu 22.04
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh-keys.key_name

  subnet_id              = aws_subnet.public-subnet-c.id
  vpc_security_group_ids = [aws_security_group.default.id]
  user_data              = data.template_file.startup.rendered
}

output "ssh_host" {
  value = aws_instance.ssh_host.public_ip
}