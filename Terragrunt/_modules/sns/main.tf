resource "aws_sns_topic" "this" {
  name =  var.sns-topic-name
}

data "aws_cloudwatch_log_group" "lambda-log-group" {
  name = var.log-group-name
}  

resource "aws_cloudwatch_log_metric_filter" "this" {
  name           = "${aws_sns_topic.this.name}-metric_filter"
  pattern        = "ERROR"
  log_group_name = data.aws_cloudwatch_log_group.lambda-log-group.name

  metric_transformation {
    name      = "LambdaFailureCount"
    namespace = "LambdaFailure"
    value     = "1"
  }
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = "itsme@yesisonline.co.in"
}

resource "aws_sns_topic_policy" "lambda-failure-sns-topic-policy" {
  arn = aws_sns_topic.this.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = [
        "SNS:Publish",
        "SNS:Subscribe",
        "SNS:Receive"
      ],
      Resource = aws_sns_topic.this.arn
    }]
  })
}
resource "aws_cloudwatch_event_rule" "lambda-failure-rule" {
  name        = "${aws_sns_topic.this.name}-rule"  
  description = "Example CloudWatch Event Rule"
  event_pattern = <<PATTERN
  "source": ["aws.lambda"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventName": ["Invoke"],
    "responseElements": {
      "statusCode": ["500"]
    },
    "errorType": ["LambdaException"]
  }
}
PATTERN
}

data "aws_lambda_function" "example_lambda_function" {
  count         = length(aws_lambda_function.this)
  function_name = aws_lambda_function.this[count.index]
}

resource "aws_cloudwatch_event_target" "lambda-target" {
  count         = length(aws_lambda_function.this)
  rule      = aws_cloudwatch_event_rule.lambda-failure-rule.name  
  target_id = "lambda-failure-event-target"
  arn       = data.aws_lambda_function.example_lambda_function[count.index].arn
}
