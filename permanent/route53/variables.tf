variable "s3_bucket_hosted_zone_id" {
  description = "The hosted zone ID from the S3 bucket"
  type        = string
}

variable "apex_bucket" {
  description = "The apex bucket to use in the record"
  type        = string
}
