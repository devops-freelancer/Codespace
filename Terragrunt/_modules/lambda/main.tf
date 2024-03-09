data "archive_file" "lambda-archivecode" {
count         =  length(var.lambda-function-name)
type          =  "zip"
source_dir    =  "$(var.lambda-function-name-sourcecode-folderpath)"
output_path   =  "$(var.lambda-function-name-sourcecode-folderpath).zip"
}

resource "aws_lambda_function" "this" {
depends_on       = [data.archive_file.lambda-archivecode]
filename         = "$(var.lambda-function-name-sourcecode-folderpath).zip"
function_name    =  var.lambda-function-name 
runtime          =  var.lambda-runtime
handler          =  var.lambda-handler
source_code_hash =  filebase64sha512("$(var.lambda-function-name-sourcecode-folderpath).zip")
layers           =  var.layers.arn
timeout          =  var.lambda_timeout
role             =  aws_iam_role.lambda-role.arn
environment {                                            }
}
resource "aws_lambda_event_source_mapping" "this" {
  event_source_arn                  = aws_msk_cluster.this.arn
  function_name                     = aws_lambda_function.this.arn
  starting_position                 = "LATEST"
  batch_size                        = var.batch-size
  maximum_batching_window_in_seconds = var.maximum-batching-window-in-seconds
}

resource "aws_iam_role" "lambda-role" {
  name                = "${var.app-prefix}-role"
  managed_policy_arns = ["arn.aws.iam:{}:policy/sts-assume-role"]
  assume_role_policy = jsondecode( {
  "Version": "2012-10-17",
  "Statement": [
    { 
      "Effect": "Allow",
      "Pricinpal": {
            "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }  ]
    } )
  }


