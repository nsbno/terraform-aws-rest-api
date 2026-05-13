variable "name" {
  description = "The name of the API Gateway REST API"
  type        = string
}

variable "endpoint_type" {
  type    = string
  default = "REGIONAL"

  validation {
    condition     = contains(["REGIONAL", "EDGE", "PRIVATE"], var.endpoint_type)
    error_message = "endpoint_type must be one of REGIONAL, EDGE, or PRIVATE."
  }
}

variable "hosted_zone_name" {
  
}

variable "alb_arn" {
  
}

variable "openapi_body" {
  type     = string
  nullable = true
  default  = null
}

variable "logging" {
  type = object({
    access_logs                  = optional(bool)
    execution_logs               = optional(bool)
    execution_logs_logging_level = optional(string)
    retention_in_days            = optional(number)
  })
  default = {}
}

variable "tracing_enabled" {
  type    = bool
  default = false
}

variable "detailed_metrics_enabled" {
  type        = bool
  default     = true
  description = "Gives you metrics for each endpoint in your API. Defaults to true, because these are really useful"
}

variable "redeployment_triggers" {
  description = "Map of arbitrary values that, when changed, trigger a redeployment."
  type        = map(string)
  default     = {}
}