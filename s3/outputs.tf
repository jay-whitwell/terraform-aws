output "yobbos_link-_hosted_zone_id" {
  description = "The hosted zone value from the S3 bucket"
  value       = aws_s3_bucket.yobbos_link.hosted_zone_id
}
