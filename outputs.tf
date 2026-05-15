output "rest_api_id" {
  description = "The ID of the REST API."
  value       = aws_api_gateway_rest_api.rest_service.id
}

output "root_resource_id" {
  description = "The root resource ID of the REST API."
  value       = aws_api_gateway_rest_api.rest_service.root_resource_id
}

output "stage_name" {
    value = aws_api_gateway_stage.rest_service.stage_name
}

output "stage_arn" {
    value = aws_api_gateway_stage.rest_service.arn
}
