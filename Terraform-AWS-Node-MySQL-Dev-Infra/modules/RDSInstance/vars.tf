# AWS Config details
# Remove them before you checkin the code to your source control system. 
variable "aws_access_key" { default = "..." } 
variable "aws_secret_key" { default = "..." } 

# Define AWS Region
variable "aws_region" {default = "us-east-1" }

# Define AWS Instance
variable "aws_instance" {default = "t2.micro"}


variable "username" {
  description = "Master username of the DB"
  default = "sriram"
}

variable "password" {
  description = "Master password of the DB"
  default = "welcometomydb"
}

variable "database_name" {
  description = "Name of the database to be created"
  default = "MyDB"
}


variable "name" {
  description = "Name of the database"
  default     = "test-db"
}

variable "engine_name" {
  description = "Name of the database engine"
  default     = "mysql"
}

variable "family" {
  description = "Family of the database"
  default     = "mysql5.7"
}

variable "port" {
  description = "Port which the database should run on"
  default     = 3306
}

variable "major_engine_version" {
  description = "MAJOR.MINOR version of the DB engine"
  default     = "5.7"
}

variable "engine_version" {
  default     = "5.7.21"
  description = "Version of the database to be launched"
}

variable "allocated_storage" {
  default     = 5
  description = "Disk space to be allocated to the DB instance"
}

variable "license_model" {
  default     = "general-public-license"
  description = "License model of the DB instance"
}

variable "environment_DB_tag" {
  description = "Environment tag"
  default = "DBServer"
}

data "aws_availability_zones" "available" {}

