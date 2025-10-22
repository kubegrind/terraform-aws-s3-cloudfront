variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Delete all objects when destroying"
  type        = bool
  default     = false
}

variable "cloudfront_comment" {
  description = "CloudFront distribution comment"
  type        = string
  default     = "Static website distribution"
}

variable "default_root_object" {
  description = "Root URL object"
  type        = string
  default     = "index.html"
}

variable "cloudfront_price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "enable_ipv6" {
  description = "Enable IPv6"
  type        = bool
  default     = true
}

variable "domain_aliases" {
  description = "Domain aliases (CNAMEs)"
  type        = list(string)
  default     = []
}

variable "create_acm_certificate" {
  description = "Create ACM certificate"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "Primary domain name for ACM"
  type        = string
  default     = ""
}

variable "subject_alternative_names" {
  description = "Additional domain names for ACM"
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "Route53 zone ID for DNS validation"
  type        = string
  default     = null
}

variable "acm_certificate_arn" {
  description = "Existing ACM certificate ARN"
  type        = string
  default     = null
}

variable "minimum_protocol_version" {
  description = "Minimum TLS version"
  type        = string
  default     = "TLSv1.2_2021"
}

variable "web_acl_id" {
  description = "WAF Web ACL ID"
  type        = string
  default     = null
}

variable "forwarded_headers" {
  description = "Headers to forward"
  type        = list(string)
  default     = []
}

variable "min_ttl" {
  description = "Minimum cache time (seconds)"
  type        = number
  default     = 0
}

variable "default_ttl" {
  description = "Default cache time (seconds)"
  type        = number
  default     = 3600
}

variable "max_ttl" {
  description = "Maximum cache time (seconds)"
  type        = number
  default     = 86400
}

variable "custom_error_responses" {
  description = "Custom error responses"
  type = list(object({
    error_code            = number
    response_code         = number
    response_page_path    = string
    error_caching_min_ttl = number
  }))
  default = [
    {
      error_code            = 403
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 300
    },
    {
      error_code            = 404
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 300
    }
  ]
}

variable "geo_restriction_type" {
  description = "Geo restriction type"
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "Country codes for geo restriction"
  type        = list(string)
  default     = []
}

variable "response_headers_policy_id" {
  description = "Existing headers policy ID"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}
