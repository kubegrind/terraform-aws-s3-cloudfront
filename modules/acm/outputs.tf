output "certificate_arn" {
  description = "ACM certificate ARN"
  value       = var.create_certificate ? aws_acm_certificate.this[0].arn : null
}

output "certificate_id" {
  description = "ACM certificate ID"
  value       = var.create_certificate ? aws_acm_certificate.this[0].id : null
}

output "certificate_domain_validation_options" {
  description = "Domain validation options"
  value       = var.create_certificate ? aws_acm_certificate.this[0].domain_validation_options : []
}
