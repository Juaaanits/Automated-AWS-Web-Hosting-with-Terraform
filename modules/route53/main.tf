# Create a hosted zone — this is your domain's home in AWS DNS
# After this is created, AWS gives you 4 nameservers
# You'll update these in Hostinger's DNS settings
resource "aws_route53_zone" "website" {
  name = var.domain_name

  tags = {
    Name        = var.domain_name
    Environment = var.environment
    Project     = var.project_name
  }
}

# A record for root domain — points juanito-ramos-dev.site to CloudFront
resource "aws_route53_record" "website" {
  zone_id = aws_route53_zone.website.zone_id
  name    = var.domain_name
  type    = "A"  # A record maps domain to IP/CloudFront

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

# A record for www subdomain — points www.juanito-ramos-dev.site to CloudFront
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.website.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}