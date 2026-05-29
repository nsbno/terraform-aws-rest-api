//
// Scenario: You need API Gateway to be a simple reverse-proxy in front of a backend,
// and you don't care about defining individual endpoints in API Gateway, just one PROXY
//

module "rest_api" {
  source = "../../"

  name = "my-reverse-proxy"
}
