# RESOURCE 1 — The actual S3 bucket
# This is the storage container where your website files live
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name  # Bucket name — must be globally unique across all of AWS

  # Tags are labels — they help you identify and organize resources in AWS console
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Project     = var.project_name
  }
}

# RESOURCE 2 — Block all public access to the bucket
# Your bucket should NOT be publicly accessible directly
# Only CloudFront should be able to read from it — more secure
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id  # References the bucket created above

  block_public_acls       = true  # Block public ACL grants
  block_public_policy     = true  # Block public bucket policies
  ignore_public_acls      = true  # Ignore any existing public ACLs
  restrict_public_buckets = true  # Restrict public bucket access
}

# RESOURCE 3 — Enable versioning
# Versioning keeps a history of every file uploaded
# If you accidentally overwrite index.html, you can restore the previous version
resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Enabled"
  }
}

# RESOURCE 4 — Configure the bucket as a static website
# This tells S3 which file to serve as the homepage and which for errors
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"  # Serve this when someone visits the root URL
  }

  error_document {
    key = "error.html"  # Serve this for 404 errors
  }
}

# RESOURCE 5 — Bucket policy
# A policy is a set of rules defining WHO can do WHAT to your bucket
# This policy says: only allow CloudFront to read (GetObject) files
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  # jsonencode converts HCL map to JSON — AWS policies are written in JSON
  policy = jsonencode({
    Version = "2012-10-17"  # AWS policy language version — always use this date
    Statement = [
      {
        Sid    = "AllowCloudFrontAccess"  # Statement ID — just a label
        Effect = "Allow"                   # Allow or Deny
        Principal = {
          Service = "cloudfront.amazonaws.com"  # Who this applies to — CloudFront service
        }
        Action   = "s3:GetObject"               # What they can do — read files only
        Resource = "${aws_s3_bucket.website.arn}/*"  # Which files — all files in bucket
        Condition = {
          StringEquals = {
            # Extra security — only THIS specific CloudFront distribution can access
            # Prevents other CloudFront distributions from accessing your bucket
            "AWS:SourceArn" = var.cloudfront_distribution_arn
          }
        }
      }
    ]
  })
}