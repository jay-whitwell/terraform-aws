module "route53" {
  source                   = "./route53"
  s3_bucket_hosted_zone_id = module.s3.yobbos_link-_hosted_zone_id
}

module "s3" {
  source = "./s3"
}
