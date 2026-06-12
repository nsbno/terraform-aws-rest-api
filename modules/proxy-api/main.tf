resource "aws_api_gateway_resource" "this" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "this" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "ANY"
  authorization = var.authorization_type
}

resource "aws_api_gateway_integration" "rest_service" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = aws_api_gateway_method.this.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = var.uri
  connection_type         = "VPC_LINK"
  connection_id           = var.connection_id
  integration_target      = var.integration_target
  request_parameters = var.request_parameters
}
 