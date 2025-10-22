variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Delete all objects when destroying"
  type        = bool
  default     = false
}

variable "cloudfront_distribution_arn" {
  description = "CloudFront distribution ARN for bucket policy"
  type        = string
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}
