resource "aws_security_group" "default" {
  name_prefix = var.project
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "startup" {
  template = "${file("${path.module}/templates/startup.sh.tpl")}"
}

resource "aws_key_pair" "ssh-keys" {
  key_name   = "${var.project}-ssh-keys"
  public_key = "${file("./templates/id_ed25519.pub")}"
}

resource "aws_instance" "bastion" {
  ami           = "ami-024e6efaf93d85776" # Ubuntu 22.04
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.ssh-keys.id}"

  subnet_id              = aws_subnet.public-subnet-c.id
  vpc_security_group_ids = [aws_security_group.default.id]
  user_data              = "${data.template_file.startup.rendered}"
}

output "bastion-public-ip" {
  value = "${aws_instance.bastion.public_ip}"
}