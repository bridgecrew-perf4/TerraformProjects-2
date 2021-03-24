

module "EC2Instance" {
  source = "./modules/Ec2Instance"
   
}



module "RDSInstance" {
  source = "./modules/RDSINstance"

}


