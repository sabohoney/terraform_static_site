# Terraform Module / Setup static web site with S3, CloudFront, Route53, ACM 

This is a repository which contains modules to setup static web site, and examples.

## Example

Here is a example to setup static site using this repository modules.

```
# ---------------
# main.tf
# ---------------

provider "aws" {
  region     = "us-east-1"
}

resource "aws_route53_zone" "site_zone" {
  name = "example.com"
}

module "acm" {
  source = "github.com/lucheholdings/terraform_static_site//acm"
  root_domain = "example.com"
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
}

module "my_site" {
  source = "github.com/lucheholdings/terrafrom_static_site//static_site"
  bucket_name = "site-example.com"
  domain = "example.com"
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  acm_certificate_arn = "${module.acm.certificate_arn}"
}

module "my_site_foo" {
  source = "github.com/lucheholdings/terraform_static_site//static_site"
  bucket_name = "site-foo.example.com"
  domain = "foo.example.com"
  zone_id = "${aws_route53_zone.site_zone.zone_id}"
  acm_certificate_arn = "${module.acm.certificate_arn}"
}
```
