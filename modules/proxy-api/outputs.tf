output "recource_proxy_id" {
  value = aws_api_gateway_resource.rest_service_proxy.id
}

output "http_method" {
  value = aws_api_gateway_method.rest_service_any.http_method
}
