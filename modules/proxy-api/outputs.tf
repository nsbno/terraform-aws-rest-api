output "recource_proxy_id" {
  value = aws_api_gateway_resource.this.id
}

output "http_method" {
  value = aws_api_gateway_method.this.http_method
}

output "integration" {
  value = var.load_balancer_integration != null ? {
    id = aws_api_gateway_integration.load_balancer[0].id
  } : null

  description = "Information about the proxy integration"

  type = object({
    id = string
  })
}