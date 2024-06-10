# Creating EC2 resources

data "aws_ami" "aws_ec2_instance" {
  most_recent = true

  owners = ["self"]

}

resource "aws_instance" "ec2" {
  count                  = length(var.azsubnet_pub)
  ami                    = data.aws_ami.aws_ec2_instance
  instance_type          = var.type
  key_name               = var.key_pair
  subnet_id              = aws_subnet.liengesubpub[count.index].id
  vpc_security_group_ids = [aws_security_group.sg[count.index].id]

  user_data = <<-EOF
        #!/bin/bash
        if curl -sSf http://${aws_instance.ec2[count.index].public_ip}; 
        
        then echo "Apache is running on ${aws_instance.ec2[count.index].public_ip}"
        else 
        echo "Apache is not running on ${aws_instance.ec2[count.index].private_ip}"

        EOF

  tags = {
    Name = var.ec2tags[count.index]
  }


}