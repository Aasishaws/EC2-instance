resource "aws_security_group" "allow_all" {

ingress {
      description      = var.ingressdescription_a
      from_port        = var.ingressfromport_a
      to_port          = var.ingresstoport_a
      protocol         = var.ingressprotocol_a
      cidr_blocks      = ["0.0.0.0/0"]
  }
ingress {
      description      = var.ingressdescription_b
      from_port        = var.ingressfromport_b
      to_port          = var.ingresstoport_b
      protocol         = var.ingressprotocol_b
      cidr_blocks      = ["0.0.0.0/0"]
  }
egress {
      description      = var.egressdescription
      from_port        = var.egressfromport
      to_port          = var.egresstoport
      protocol         = var.egressprotocol
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }
 tags = {
    Name = var.sg
  }
}

resource "aws_instance" "master-ec2" {
  ami                    = var.masterec2_ami_id
  instance_type          = var.masterec2_instance_type
  user_data              = file("masterscript.sh")
  key_name               = var.masterkey_name
  vpc_security_group_ids      =  [aws_security_group.allow_all.id]
   tags = {
    Name = var.master_ec2
  }
}
  resource "aws_instance" "slave-ec2" {
  ami                    = var.slaveec2_ami_id
  instance_type          = var.slaveec2_instance_type
  user_data              = file("slavescript.sh")
  key_name               = var.slavekey_name
  vpc_security_group_ids      =  [aws_security_group.allow_all.id]


   tags = {
    Name = var.slave_ec2
  }
}
