//
// Scenario: You need API Gateway to be a simple reverse-proxy in front of a backend,
// and you don't care about defining individual endpoints in API Gateway, just one PROXY
//

locals {
  backend_url = "https://api.example.com"
}

module "rest_api" {
  source = "../../"

  name                        = "my-reverse-proxy"
  enable_execute_api_endpoint = true
  redeployment_triggers       = local.backend_url
}

module "proxy-api" {
  source = "../../modules/proxy-api"

  rest_api_id = module.rest_api.rest_api_id
  parent_id   = module.rest_api.root_resource_id
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id             = module.rest_api.rest_api_id
  resource_id             = module.proxy-api.recource_proxy_id
  http_method             = module.proxy-api.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "${local.backend_url}/{proxy}"

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

