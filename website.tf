module "frontend" {
  source    = "./modules/s3-cloudfront-website"
  namespace = "cloudtech"
  stage     = "dev"
}

output "frontend_s3_bucket" {
  value = module.frontend.s3_bucket_name
}

output "frontend_cloudfront_url" {
  value = module.frontend.cloudfront_domain_name
}