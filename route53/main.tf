resource "aws_route53domains_registered_domain" "yobbos" {
  domain_name = "yobbos.link"

  dynamic "name_server" {
    for_each = aws_route53_zone.primary.name_servers
    content {
      name = name_server.value
    }
  }
}

resource "aws_route53_zone" "primary" {
  name = "yobbos.link"
}

resource "aws_route53_record" "yobbos_ns" {
  allow_overwrite = true
  name            = "yobbos.link"
  ttl             = 172800
  type            = "NS"
  zone_id         = aws_route53_zone.primary.zone_id

  records = aws_route53_zone.primary.name_servers
}

resource "aws_route53_record" "yobbos_apex" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = aws_route53_zone.primary.name
  type    = "A"

  alias {
    name                   = "s3-website.eu-west-2.amazonaws.com."
    zone_id                = var.s3_bucket_hosted_zone_id
    evaluate_target_health = false
  }
}
