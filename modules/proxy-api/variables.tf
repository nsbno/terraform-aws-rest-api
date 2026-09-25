variable "rest_api_id" {
  type = string
}

variable "parent_id" {
  type = string
}

variable "authorization_type" {
  type        = string
  default     = "AWS_IAM"
  description = "Type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)"

  validation {
    condition     = contains(["NONE", "CUSTOM", "AWS_IAM", "COGNITO_USER_POOLS"], var.authorization_type)
    error_message = "endpoint_type must be one of NONE, CUSTOM, AWS_IAM or COGNITO_USER_POOLS."
  }
}

variable "load_balancer_integration" {
  type = object({
    load_balancer_arn      = string
    connection_id          = string
    backend_uri_template   = string
    request_parameters     = optional(map(string))
    response_transfer_mode = optional(string, "BUFFERED")
    timeout_milliseconds   = optional(number, 29000)
  })

  description = "Connects the PROXY endpoint in API Gateway to an Application Load Balancer, using VPC Link. Set response_transfer_mode to STREAM to let the backend stream a response (e.g. Server-Sent Events) instead of API Gateway buffering it in full before returning; STREAM raises the allowed timeout_milliseconds ceiling from 29,000ms to 900,000ms without a service quota increase."
  nullable    = true
  default     = null

  validation {
    condition     = var.load_balancer_integration == null || contains(["BUFFERED", "STREAM"], var.load_balancer_integration.response_transfer_mode)
    error_message = "response_transfer_mode must be BUFFERED or STREAM."
  }
}

variable "method_request_parameters" {
  description = "Request parameters to be passed from the method request to the integration request."
  type        = map(bool)
  default = {
    "method.request.path.proxy"  = true
    "method.request.header.host" = true
  }
}
