moved {
  from = aws_s3_bucket.yobbos-link
  to   = aws_s3_bucket.yobbos_link
}

resource "aws_s3_bucket" "yobbos_link" {
  bucket = "yobbos.link"
}

resource "aws_s3_bucket_versioning" "yobbos_link" {
  bucket = aws_s3_bucket.yobbos_link.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "yobbos_link" {
  bucket = aws_s3_bucket.yobbos_link.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket" "www_yobbos_link" {
  bucket = "www.yobbos.link"
}

resource "aws_s3_bucket_versioning" "www_yobbos_link" {
  bucket = aws_s3_bucket.www_yobbos_link.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "www_yobbos_link" {
  bucket = aws_s3_bucket.www_yobbos_link.id

  redirect_all_requests_to {
    host_name = aws_s3_bucket.yobbos_link.bucket_domain_name
    protocol  = "http"
  }
}
