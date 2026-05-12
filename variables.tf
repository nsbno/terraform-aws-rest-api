variable "name" {
  description = "The name of the API Gateway REST API"
  type        = string
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