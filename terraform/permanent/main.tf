module "route53" {
  source                   = "./route53"
  s3_bucket_hosted_zone_id = module.s3.yobbos_link_hosted_zone_id
  apex_bucket              = module.s3.yobbos_apex_bucket
}

module "s3" {
  source = "./s3"
}

