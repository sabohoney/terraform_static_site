provider "aws" {
  region     = "us-east-1"
}

resource "aws_route53_zone" "site_zone" {
  name = "example.com"
}

module "acm" {
  source  = "github.com/lucheholdings/terraform_static_site//modules/acm"
  root_domain = "example.com"
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
}

module "static_site_root" {
  source  = "github.com/lucheholdings/terrafrom_static_site//modules/static_site"
  bucket_name = "site-example.com"
  domain = "example.com"
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  acm_certificate_arn = "${module.acm.certificate_arn}"
}

module "static_site_foo" {
  source  = "github.com/lucheholdings/terrafrom_static_site//modules/static_site"
  bucket_name = "site-foo.example.com"
  domain = "foo.example.com"
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  acm_certificate_arn = "${module.acm.certificate_arn}"
}

module "static_site_bar" {
  source  = "github.com/lucheholdings/terrafrom_static_site//modules/static_site"
  bucket_name = "site-bar.example.com"
  domain = "bar.example.com"
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  acm_certificate_arn = "${module.acm.certificate_arn}"
}


