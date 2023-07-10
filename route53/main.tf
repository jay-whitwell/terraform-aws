resource "aws_route53_zone" "primary" {
  name = "yobbos.link"
}

resource "aws_route53_record" "live" {
  allow_overwrite = true
  name            = "yobbos.link"
  ttl             = 3600
  type            = "NS"
  zone_id         = aws_route53_zone.primary.zone_id

  records = aws_route53_zone.primary.name_servers
}

resource "aws_route53_record" "test" {
  name = aws_route53_zone.primary.name
  ttl = 3600
  type = "A"
  zone_id = aws_route53_zone.primary.zone_id

  records = [var.instance_public_ip]
}
