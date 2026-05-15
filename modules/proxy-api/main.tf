# module "rest_api" {
#   source = "../../"

#   name = var.name

#   redeployment_triggers = merge(
#     var.redeployment_triggers,
#     {
#       resource_id        = aws_api_gateway_resource.rest_service_proxy.id
#       resource_path_part = aws_api_gateway_resource.rest_service_proxy.path_part
#       method_id          = aws_api_gateway_method.rest_service_any.id
#       method_http_method = aws_api_gateway_method.rest_service_any.http_method
#     }
#   )
#   hosted_zone_name = var.hosted_zone_name
#   alb_arn = var.alb_arn
# }

resource "aws_api_gateway_resource" "rest_service_proxy" {
  rest_api_id = module.rest_api.rest_api_id
  parent_id   = module.rest_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "rest_service_any" {
  rest_api_id   = module.rest_api.rest_api_id
  resource_id   = aws_api_gateway_resource.rest_service_proxy.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy"  = true
    "method.request.header.host" = true
  }
}