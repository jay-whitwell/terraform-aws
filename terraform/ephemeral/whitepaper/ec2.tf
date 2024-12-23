module "ec2" {
  source = "./ec2"
  nic_id = module.vpc.nic_id
}