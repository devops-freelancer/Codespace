
variable "region" {
  type = string
}

variable "lambda-function-name" {
type = string
}

variable "lambda-runtime" {
type = string
}

variable "lambda-handler" {
type = string
}

variable "layers.arn" {
type = string
}



variable "lambda_timeout" {
type = string
}

variable "app-prefix" {
type = string

}

variable "batch-size" {
 type = number
}

variable "maximum-batching-window-in-seconds" {
 type = number
}