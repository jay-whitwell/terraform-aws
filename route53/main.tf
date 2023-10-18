resource "aws_route53_zone" "primary" {
  name = "yobbos.link"
}

resource "aws_route53_record" "yobbos_ns" {
  allow_overwrite = true
  name            = "yobbos.link"
  ttl             = 3600
  type            = "NS"
  zone_id         = aws_route53_zone.primary.zone_id

  records = aws_route53_zone.primary.name_servers
}

resource "aws_route53_record" "yobbos_a" {
  name    = aws_route53_zone.primary.name
  type    = "A"
  zone_id = aws_route53_zone.primary.zone_id

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53domains_registered_domain" "yobbos" {
  domain_name = "yobbos.link"

  dynamic "name_server" {
    for_each = aws_route53_zone.primary.name_servers
    content {
      name = name_server.value
    }
  }
}