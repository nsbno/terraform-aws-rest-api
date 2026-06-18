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
  request_parameters = {
    "method.request.path.proxy"  = true
    "method.request.header.host" = true
  }
}

resource "aws_api_gateway_integration" "load_balancer" {
  count = var.load_balancer_integration != null ? 1 : 0

  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = aws_api_gateway_method.this.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = var.load_balancer_integration.backend_uri_template
  connection_type         = "VPC_LINK"
  connection_id           = var.load_balancer_integration.connection_id
  integration_target      = var.load_balancer_integration.load_balancer_arn
  request_parameters      = var.load_balancer_integration.request_parameters
}
 