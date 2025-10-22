module "acm" {
  source = "./modules/acm"

  create_certificate        = var.create_acm_certificate
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  route53_zone_id           = var.route53_zone_id
  tags                      = var.tags
}

module "cloudfront" {
  source = "./modules/cloudfront"

  bucket_name                     = var.bucket_name
  s3_bucket_regional_domain_name  = module.s3.bucket_regional_domain_name
  comment                         = var.cloudfront_comment
  default_root_object             = var.default_root_object
  price_class                     = var.cloudfront_price_class
  enable_ipv6                     = var.enable_ipv6
  domain_aliases                  = var.domain_aliases
  acm_certificate_arn             = var.create_acm_certificate ? module.acm.certificate_arn : var.acm_certificate_arn
  minimum_protocol_version        = var.minimum_protocol_version
  web_acl_id                      = var.web_acl_id
  forwarded_headers               = var.forwarded_headers
  min_ttl                         = var.min_ttl
  default_ttl                     = var.default_ttl
  max_ttl                         = var.max_ttl
  custom_error_responses          = var.custom_error_responses
  geo_restriction_type            = var.geo_restriction_type
  geo_restriction_locations       = var.geo_restriction_locations
  response_headers_policy_id      = var.response_headers_policy_id
  tags                            = var.tags
}

module "s3" {
  source = "./modules/s3"

  bucket_name                  = var.bucket_name
  force_destroy                = var.force_destroy
  cloudfront_distribution_arn  = module.cloudfront.distribution_arn
  tags                         = var.tags
}
