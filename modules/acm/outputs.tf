output "certificate_arn" {
  value = aws_acm_certificate_validation.website.certificate_arn
}

output "certificate_status" {
  value = aws_acm_certificate.website.status
}
