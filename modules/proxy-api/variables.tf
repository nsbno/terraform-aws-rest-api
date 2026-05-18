# variable "name" {
#   description = "The name of the API Gateway REST API."
#   type        = string
# }

# variable "redeployment_triggers" {
#   description = "Additional triggers passed in from the caller, to be merged with this module's own triggers."
#   type        = map(string)
#   default     = {}
# }

# variable "hosted_zone_name" {}

# variable "alb_arn" {}

variable "rest_api_id" {
    type = string
}

variable "parent_id" {
    type = string
}

variable "method_authorization" {
    type = string
    default = "AWS_IAM"
    description = "Type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)"

    validation {
        condition     = contains(["NONE", "CUSTOM", "AWS_IAM", "COGNITO_USER_POOLS"], var.method_authorization)
        error_message = "endpoint_type must be one of NONE, CUSTOM, AWS_IAM or COGNITO_USER_POOLS."
    }
}