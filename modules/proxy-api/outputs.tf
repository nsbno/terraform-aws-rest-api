output "recource_proxy_id" {
  value = aws_api_gateway_resource.this.id
}

output "http_method" {
  value = aws_api_gateway_method.this.http_method
}

output "integration_id" {
  value = aws_api_gateway_integration.rest_service.id
}

output "type" {
  value = aws_api_gateway_integration.rest_service.type
}

output "uri" {
  value = aws_api_gateway_integration.rest_service.uri
}

output "connection_type" {
  value = aws_api_gateway_integration.rest_service.connection_type
}

output "request_parameters" {
  value = aws_api_gateway_integration.rest_service.request_parameters
}
