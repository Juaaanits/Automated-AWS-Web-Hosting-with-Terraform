output "hosted_zone_id" {
  # Needed by ACM module to create validation records
  value = aws_route53_zone.website.zone_id
}

output "name_servers" {
  # These 4 nameservers go into Hostinger DNS settings
  value = aws_route53_zone.website.name_servers
}