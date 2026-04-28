output "cloudfront_url" {
  value = "https://${module.cloudfront.domain_name}"
}

output "cloudfront_distribution_id" {
  value = module.cloudfront.distribution_id
}

output "domain_url" {
  value = "https://${var.domain_name}"
}

output "www_url" {
  value = "https://www.${var.domain_name}"
}

output "name_servers" {
  value = module.route53.name_servers
}

output "certificate_arn" {
  value = module.acm.certificate_arn
}
