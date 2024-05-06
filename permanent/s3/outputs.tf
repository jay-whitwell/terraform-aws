output "yobbos_link_hosted_zone_id" {
  description = "The hosted zone value from the S3 bucket"
  value       = aws_s3_bucket.yobbos_link.hosted_zone_id
}

output "yobbos_apex_bucket" {
  description = "The apex bucket for the statically hosted website"
  value       = aws_s3_bucket.yobbos_link.bucket
}
