output "name_servers" {
  value = "${aws_route53_zone.site_zone.name_servers}"
}
