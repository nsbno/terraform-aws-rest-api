output "recource_proxy_id" {
  value = aws_api_gateway_resource.this.id
}

output "http_method" {
  value = aws_api_gateway_method.this.http_method
}

output "integration" {
  value = var.load_balancer_integration != null ? {
    id = aws_api_gateway_integration.load_balancer[0].id
    uri = aws_api_gateway_integration.load_balancer[0].uri
    connection_type = aws_api_gateway_integration.load_balancer[0].connection_type
    request_parameters = aws_api_gateway_integration.load_balancer[0].request_parameters
  } : null

  description = "Information about the proxy integration"

  type = object({
    id = string
    uri = string
    connection_type = string
    request_parameters = map(string)
  })
}
