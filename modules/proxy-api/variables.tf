variable "rest_api_id" {
    type = string
}

variable "parent_id" {
    type = string
}

variable "authorization_type" {
    type = string
    default = "AWS_IAM"
    description = "Type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)"

    validation {
        condition     = contains(["NONE", "CUSTOM", "AWS_IAM", "COGNITO_USER_POOLS"], var.method_authorization)
        error_message = "endpoint_type must be one of NONE, CUSTOM, AWS_IAM or COGNITO_USER_POOLS."
    }
}