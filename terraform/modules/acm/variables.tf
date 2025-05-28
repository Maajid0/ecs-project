variable "acm_domain_name" {
  description = "Domain for ACM certificate"
  type        = string
  default     = "tm.maajid.co.uk"  
}

variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID to create validation records"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "validation_method" {
    type = string
    description = "The validation method used for the ACM certificate"
}

variable "dns_ttl" {
  type = number
  description = "TTL for DNS records"
}