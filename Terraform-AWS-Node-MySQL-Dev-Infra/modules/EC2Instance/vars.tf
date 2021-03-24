# AWS Config details
# Remove them before you checkin the code to your source control system. 
variable "aws_access_key" { default = "..." } 
variable "aws_secret_key" { default = "..." } 

# Define AWS Region
variable "aws_region" {default = "us-east-1" }

# Define AWS Instance
variable "aws_instance" {default = "t2.micro"}

# Define AMI to be used
variable "AMI" {
    type = map
    
    default = {
        us-east-1 = "ami-03368e982f317ae48"
    }
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}

variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default = "10.1.0.0/24"
}
variable "availabilityzone" {
  type        = string
  default     = "us-east-1a"
}



variable "environment_tag" {
  description = "Environment tag"
  default = "NodeDevServer"
}



variable "ssh_port" {
  description = "The port the EC2 Instance should listen on for SSH requests."
  type        = number
  default     = 22
}

variable "ssh_user" {
  description = "SSH user name to use for remote exec connections,"
  type        = string
  default     = "ec2-user"
}

variable "key_file" {
  description = "key path"
  default = "D:\\mykey\\mykey.pem"
}



