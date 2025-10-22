output "distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = aws_cloudfront_distribution.this.arn
}

output "domain_name" {
  description = "CloudFront domain name"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "hosted_zone_id" {
  description = "CloudFront Route 53 zone ID"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}

output "oac_id" {
  description = "CloudFront OAC ID"
  value       = aws_cloudfront_origin_access_control.this.id
}

output "response_headers_policy_id" {
  description = "Response headers policy ID"
  value       = var.response_headers_policy_id != null ? var.response_headers_policy_id : try(aws_cloudfront_response_headers_policy.security_headers[0].id, null)
}
