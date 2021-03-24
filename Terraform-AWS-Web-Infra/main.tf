#What provider and it's credentials.
provider "aws" { 
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.aws_region

 } 

#Create the webserver and connect to the same.
resource "aws_instance" "webserver" {
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
        host     = aws_instance.webserver.public_ip
        agent = true
    
  }
  
  #Once an EC2 instance is created, run these commands. 
  #These commands will change according to the ami you are creating
  provisioner "remote-exec" {
    
    inline = [
      "sudo yum -y update",
      "sudo amazon-linux-extras install -y epel",
      "sudo yum install -y ${var.http_server}",
       "sudo systemctl start ${var.http_server}",
       "sudo systemctl status ${var.http_server}"
    ]
       
  }
    tags = {
        Name  = var.environment_tag
    }
}



 
