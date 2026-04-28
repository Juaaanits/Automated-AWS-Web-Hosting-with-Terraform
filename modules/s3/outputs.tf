# Outputs are like RETURN VALUES from a module
# Other modules can reference these — e.g. CloudFront needs the bucket domain name

output "bucket_name" {
  value = aws_s3_bucket.website.bucket  # The actual bucket name AWS assigned
}

output "bucket_arn" {
  value = aws_s3_bucket.website.arn  # ARN = Amazon Resource Name — unique ID for the bucket
}

output "bucket_regional_domain_name" {
  # This is what CloudFront uses as the origin — where to fetch files from
  value = aws_s3_bucket.website.bucket_regional_domain_name
}

output "website_endpoint" {
  # The direct S3 website URL — useful for testing before CloudFront is set up
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "codepipeline_connection_arn" {
  value = aws_codestarconnections_connection.github.arn
}