variable "bucket_name" {
  description = "S3 bucket name for origin"
  type        = string
}

variable "s3_bucket_regional_domain_name" {
  description = "S3 bucket regional domain name"
  type        = string
}

variable "comment" {
  description = "CloudFront distribution comment"
  type        = string
  default     = "Static website distribution"
}

variable "default_root_object" {
  description = "Root URL object"
  type        = string
  default     = "index.html"
}

variable "price_class" {
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

variable "acm_certificate_arn" {
  description = "ACM certificate ARN"
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
