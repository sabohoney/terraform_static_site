output "cloud_front_destribution_domain_name" {
  value = "${aws_cloudfront_distribution.site.domain_name}"
}

output "name_servers" {
  value = "${aws_route53_zone.site_zone.name_servers}"
}
