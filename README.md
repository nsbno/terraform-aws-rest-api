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
