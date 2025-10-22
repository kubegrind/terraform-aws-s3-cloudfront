variable "create_certificate" {
  description = "Whether to create ACM certificate"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "Primary domain name"
  type        = string
  default     = ""
}

variable "subject_alternative_names" {
  description = "Additional domain names"
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "Route53 zone ID for DNS validation"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}
