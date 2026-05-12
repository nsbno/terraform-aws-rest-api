resource "aws_api_gateway_rest_api" "this" {
  name = var.name

  // Provides the most amount of flexibility, even though "overwrite" is the default
  put_rest_api_mode = "merge"

  // Caused Cyclical error. But we should really have a dependency
  # depends_on = [
  #   aws_cloudwatch_log_group.execution_logs.id,
  # ]
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    changed_body = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = "main"

  xray_tracing_enabled = var.tracing_enabled

  dynamic "access_log_settings" {
    // There's only 0 or 1 access log groups
    for_each = aws_cloudwatch_log_group.access_logs

    content {
      destination_arn = access_log_settings.value.arn

      format = jsonencode({
        requestId               = "$context.requestId"
        requestTime             = "$context.requestTime"
        httpMethod              = "$context.httpMethod"
        resourcePath            = "$context.resourcePath"
        status                  = "$context.status"
        responseLength          = "$context.responseLength"
        protocol                = "$context.protocol"
        sourceIp                = "$context.identity.sourceIp"
        userAgent               = "$context.identity.userAgent"
        userArn                 = "$context.identity.userArn"
        errorMessage            = "$context.error.message"
        integrationErrorMessage = "$context.integrationErrorMessage"
      })
    }
  }
}

resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*" # Apply to all resources

  settings {
    metrics_enabled    = var.detailed_metrics_enabled
    logging_level      = coalesce(var.logging.execution_logs_logging_level, "OFF")
    data_trace_enabled = false
  }

  // This was the only place we could place the dependency,
  // that didn't cause Cyclical errors
  depends_on = [
    aws_cloudwatch_log_group.execution_logs,
  ]
}
