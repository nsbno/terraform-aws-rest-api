terraform-aws-rest-api
===

This module gives you an AWS API Gateway REST API (v1) with sane defaults.
Use this directly or as a building block for more advanced patterns.

## Usage

```terraform
module "rest_api" {
  source = "github.com/nsbno/terraform-aws-rest-api?ref=x.y.z"

  name = "my-rest-api"
}
```

## Examples

- [Directly define individual endpoints](./examples/directly-define-endpoints/main.tf)
- [Endpoints and integrations defined through an OpenAPI schema you provide](./examples/endpoints-using-openapi-schema/main.tf)
- [Just a simple reverse proxy in front of a backend](./examples/simple-reverse-proxy/main.tf) (such as Application Load Balancer)

See [./examples](./examples) for more examples
