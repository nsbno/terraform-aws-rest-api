output "rest_api_id" {
  description = "The ID of the REST API."
  value       = aws_api_gateway_rest_api.rest_service.id
}

output "rest_api_recource_proxy_id" {
    value = aws_api_gateway_resource.rest_service_proxy.id
}

output "rest_api_http_method" {
    value = aws_api_gateway_method.rest_service_any.http_method
}

output "api_gateway_stage_name" {
    value = module.rest_api.api_gateway_stage_name
}

output "api_gateway_stage_arn" {
    value = module.rest_api.api_gateway_stage_arn
}