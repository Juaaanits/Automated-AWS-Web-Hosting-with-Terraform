module "route53" {
  source = "../../modules/route53"

  domain_name               = var.domain_name
  environment               = var.environment
  project_name              = var.project_name
  cloudfront_domain_name    = module.cloudfront.domain_name
  cloudfront_hosted_zone_id = module.cloudfront.hosted_zone_id
}

module "acm" {
  source = "../../modules/acm"

  providers = {
    aws.us_east_1 = aws.us_east_1
  }

  domain_name    = var.domain_name
  environment    = var.environment
  project_name   = var.project_name
  hosted_zone_id = module.route53.hosted_zone_id
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  domain_name                 = var.domain_name
  environment                 = var.environment
  project_name                = var.project_name
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  certificate_arn             = module.acm.certificate_arn
}

module "s3" {
  source = "../../modules/s3"

  bucket_name                 = var.domain_name
  environment                 = var.environment
  project_name                = var.project_name
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
  cloudfront_distribution_id  = module.cloudfront.distribution_id
  github_repo_owner           = var.github_repo_owner
  github_repo_name            = var.github_repo_name
  branch_name                 = var.branch_name
}