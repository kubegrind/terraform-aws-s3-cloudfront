# Terraform AWS S3 CloudFront Module

Terraform module for hosting a secure static website on AWS using S3 and CloudFront with Origin Access Control (OAC).

## Architecture

This module is organized into three sub-modules:
- **S3 Module**: Private S3 bucket with encryption
- **CloudFront Module**: CDN distribution with OAC and security headers
- **ACM Module**: Optional SSL certificate with DNS validation

## Features

- Private S3 bucket with public access blocked
- CloudFront CDN with global edge caching
- Origin Access Control (OAC) for secure S3 access
- HTTPS support with ACM certificate
- Security headers (HSTS, X-Content-Type-Options, etc.)
- Server-side encryption (AES256)
- SPA support for React, Vue, Angular apps
- Optional WAF integration
- Optional geographic restrictions

## Best Practices

- Private S3 bucket (CloudFront accesses via OAC)
- HTTPS enforcement with HTTP → HTTPS redirect
- Security headers for improved security posture
- Server-side encryption at rest (AES256)
- TLS 1.2+ minimum protocol version
- Gzip compression enabled

## Usage

### Basic Example

```hcl
module "static_website" {
  source = "github.com/yourusername/terraform-aws-s3-cloudfront"

  bucket_name = "my-static-website"

  tags = {
    Environment = "production"
    Project     = "my-website"
  }
}
```

### With Existing ACM Certificate

```hcl
module "static_website" {
  source = "github.com/yourusername/terraform-aws-s3-cloudfront"

  bucket_name             = "my-static-website"
  cloudfront_comment      = "My Static Website"
  cloudfront_price_class  = "PriceClass_100"

  domain_aliases      = ["www.example.com", "example.com"]
  acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abc123"

  minimum_protocol_version = "TLSv1.2_2021"

  default_ttl = 3600
  max_ttl     = 86400

  tags = {
    Environment = "production"
    Project     = "my-website"
  }
}

resource "aws_route53_record" "website" {
  zone_id = "Z123456789ABC"
  name    = "www.example.com"
  type    = "A"

  alias {
    name                   = module.static_website.cloudfront_domain_name
    zone_id                = module.static_website.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
```

### With ACM Certificate Creation

```hcl
module "static_website" {
  source = "github.com/yourusername/terraform-aws-s3-cloudfront"

  bucket_name = "my-static-website"

  create_acm_certificate    = true
  domain_name               = "example.com"
  subject_alternative_names = ["www.example.com"]
  route53_zone_id           = "Z123456789ABC"

  domain_aliases = ["example.com", "www.example.com"]

  tags = {
    Environment = "production"
  }
}
```

## Deploying Content

Upload your static files to S3:

```bash
aws s3 sync ./dist s3://my-static-website/ --delete

aws cloudfront create-invalidation \
  --distribution-id <distribution-id> \
  --paths "/*"
```

## Module Structure

```
.
├── main.tf                 # Root module
├── variables.tf
├── outputs.tf
├── versions.tf
└── modules/
    ├── s3/                 # S3 bucket module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── cloudfront/         # CloudFront module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── acm/                # ACM certificate module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the S3 bucket | `string` | n/a | yes |
| force_destroy | Delete all objects when destroying | `bool` | `false` | no |
| cloudfront_comment | CloudFront comment | `string` | `"Static website distribution"` | no |
| default_root_object | Root URL object | `string` | `"index.html"` | no |
| cloudfront_price_class | Price class | `string` | `"PriceClass_100"` | no |
| enable_ipv6 | Enable IPv6 | `bool` | `true` | no |
| domain_aliases | Domain aliases (CNAMEs) | `list(string)` | `[]` | no |
| create_acm_certificate | Create ACM certificate | `bool` | `false` | no |
| domain_name | Primary domain name for ACM | `string` | `""` | no |
| subject_alternative_names | Additional domain names for ACM | `list(string)` | `[]` | no |
| route53_zone_id | Route53 zone ID for DNS validation | `string` | `null` | no |
| acm_certificate_arn | Existing ACM certificate ARN | `string` | `null` | no |
| minimum_protocol_version | Minimum TLS version | `string` | `"TLSv1.2_2021"` | no |
| web_acl_id | WAF Web ACL ID | `string` | `null` | no |
| forwarded_headers | Headers to forward | `list(string)` | `[]` | no |
| min_ttl | Minimum cache time (seconds) | `number` | `0` | no |
| default_ttl | Default cache time (seconds) | `number` | `3600` | no |
| max_ttl | Maximum cache time (seconds) | `number` | `86400` | no |
| custom_error_responses | Custom error responses | `list(object)` | SPA defaults | no |
| geo_restriction_type | Geo restriction type | `string` | `"none"` | no |
| geo_restriction_locations | Country codes | `list(string)` | `[]` | no |
| response_headers_policy_id | Existing headers policy ID | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3_bucket_id | S3 bucket name |
| s3_bucket_arn | S3 bucket ARN |
| s3_bucket_domain_name | S3 bucket domain name |
| s3_bucket_regional_domain_name | S3 regional domain name |
| cloudfront_distribution_id | CloudFront distribution ID |
| cloudfront_distribution_arn | CloudFront distribution ARN |
| cloudfront_domain_name | CloudFront domain name |
| cloudfront_hosted_zone_id | CloudFront Route 53 zone ID |
| cloudfront_oac_id | CloudFront OAC ID |
| response_headers_policy_id | Response headers policy ID |
| acm_certificate_arn | ACM certificate ARN |

## Notes

- ACM certificates must be in the `us-east-1` region for CloudFront
- CloudFront distribution changes take 15-20 minutes to propagate
- Create CloudFront invalidations after uploading new content
- Default error responses support SPA client-side routing

## Security

- S3 bucket is completely private
- HTTPS enforced (HTTP redirects to HTTPS)
- Security headers configured automatically
- TLS 1.2+ required
- AES256 encryption at rest
- Consider adding AWS WAF for additional protection

## License

MIT
