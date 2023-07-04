resource "aws_route53_zone" "primary" {
  name = "yobbos.link"
}

resource "aws_route53_record" "nameservers" {
  allow_overwrite = true
  name            = "yobbos.link"
  ttl             = 3600
  type            = "NS"
  zone_id         = aws_route53_zone.primary.zone_id

  records = aws_route53_zone.primary.name_servers
}