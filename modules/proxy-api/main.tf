resource "aws_api_gateway_resource" "rest_service_proxy" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "rest_service_any" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.rest_service_proxy.id
  http_method   = "ANY"
  authorization = var.method_authorization

  request_parameters = {
    "method.request.path.proxy"  = true
    "method.request.header.host" = true
  }
}