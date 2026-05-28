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