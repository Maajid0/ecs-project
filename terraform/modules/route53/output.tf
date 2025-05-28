output "zone_id" {
  value = data.aws_route53_zone.selected.id
}

output "record_fqdn" {
  value = aws_route53_record.subdomain.fqdn
}
