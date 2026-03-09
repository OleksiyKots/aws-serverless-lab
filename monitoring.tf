resource "aws_sns_topic" "lambda_alarms" {
  name = "cloudtech-dev-lambda-alarms"
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.lambda_alarms.arn
  protocol  = "email"
  endpoint  = "oleksiykots10@gmail.com" 
}

locals {
  lambda_functions = [
    "cloudtech-dev-get-all-authors",
    "cloudtech-dev-get-all-courses",
    "cloudtech-dev-get-course",
    "cloudtech-dev-save-course",
    "cloudtech-dev-update-course",
    "cloudtech-dev-delete-course"
  ]
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors_alarm" {
  for_each            = toset(local.lambda_functions)
  
  alarm_name          = "${each.key}-error-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60" 
  statistic           = "Sum"
  threshold           = "1"  
  alarm_description   = "УВАГА: Функція ${each.key} впала з помилкою!"

  dimensions = {
    FunctionName = each.key
  }

  alarm_actions = [aws_sns_topic.lambda_alarms.arn]
}