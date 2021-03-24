#What provider and it's credintials.
provider "aws" { 
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.aws_region

 } 

#Create the webserver and connect to the same.
resource "aws_instance" "devopsserver" {
    ami = lookup(var.AMI, var.aws_region)
    instance_type = var.aws_instance
    key_name   = "mykey"
    subnet_id = aws_subnet.subnet_public.id
    vpc_security_group_ids = [aws_security_group.sg_ops.id]
    
    connection  {
        type     =  "ssh"
        user     = var.ssh_user
        port     = var.ssh_port
        private_key = file(var.key_file)
        host     = aws_instance.devopsserver.public_ip
        agent = true
    
  }
  provisioner "file" {
    source      = "D:\\Repository\\Terraform-AWS-DevOps-Infra\\Dockerfile"
    destination = "  /home/ec2-user/Dockerfile"
  }

  provisioner "file" {
    source      = "D:\\Repository\\Terraform-AWS-DevOps-Infra\\plugins.txt"
    destination = "  /home/ec2-user/plugins.txt"
  }

  provisioner "file" {
    source      = "D:\\Repository\\Terraform-AWS-DevOps-Infra\\casc.yaml"
    destination = "  /home/ec2-user/casc.yaml"
  }
  provisioner "file" {
    source      = "D:\\Repository\\Terraform-AWS-DevOps-Infra\\user.groovy"
    destination = "  /home/ec2-user/user.groovy"
  }
  
  #Once an EC2 instance is created, run these commands. 
  #These commands will change according to the ami you are creating
  provisioner "remote-exec" {
    
    inline = [
      "sudo yum -y update",
      "sudo amazon-linux-extras install -y docker epel",
      "sudo yum install -y ${var.java_version}-openjdk-devel",
      "sudo yum install -y maven",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "sudo docker run hello-world",
      "sudo docker build -t ${var.image_tag} .",
      "sudo docker run --name jenkins -d --rm -p 8080:8080 ${var.image_tag}",
    ]
       
  }
    tags = {
        Name  = var.environment_tag
    }

    
}





 