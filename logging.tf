locals {
  default_log_retention_in_days = 30
  log_retention_in_days         = coalesce(var.logging.retention_in_days, local.default_log_retention_in_days)
}

resource "aws_cloudwatch_log_group" "access_logs" {
  count = var.logging.access_logs == true ? 1 : 0

  name              = "/aws/api-gateway/${var.name}/access"
  retention_in_days = local.log_retention_in_days
}

resource "aws_cloudwatch_log_group" "execution_logs" {
  count = var.logging.execution_logs == true ? 1 : 0
  # API Gateway writes execution logs to this well-known, API-ID-scoped log
  # group. Declaring it here lets us manage retention instead of relying on
  # the log group being auto-created with infinite retention.
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.rest_service.id}/${aws_api_gateway_stage.rest_service.stage_name}"
  # name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.this.id}/${aws_api_gateway_stage.this.stage_name}"
  retention_in_days = local.log_retention_in_days
}