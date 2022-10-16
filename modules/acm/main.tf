resource "aws_acm_certificate" "acm_cert" {
  provider                  = aws
  domain_name               = var.root_domain
  subject_alternative_names = ["*.${var.root_domain}"]
  validation_method         = "DNS"
}

resource "aws_route53_record" "acm_cert" {
  # Count=2, because we need to valdiate both "example.com" and "*.example.com".
  count   = 2
  name    = lookup(aws_acm_certificate.acm_cert.domain_validation_options[count.index], "resource_record_name")
  type    = lookup(aws_acm_certificate.acm_cert.domain_validation_options[count.index], "resource_record_type")
  zone_id = var.zone_id
  records = ["${lookup(aws_acm_certificate.acm_cert.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "acm_cert" {
  certificate_arn         = aws_acm_certificate.acm_cert.arn
  validation_record_fqdns = ["${aws_route53_record.acm_cert.*.fqdn}"]
}
