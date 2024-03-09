###Glue Catalog-database variables################
variable "db-create" {
  default = true
}
variable "connection-create" {
  default = true
}

variable "db-name" {}

variable "db-description" {
  default = ""
}

variable "db-catalog" {
  default = ""
}

variable "db-location-uri" {
  default = ""
}

variable "db-params" {
  type    = "map"
  default = {}
}

###Glue connections variables################
variable "connection-create" {
  default = true
}

variable "connection-name" {}
variable "connection-url" {}

variable "connection-user" {}

variable "connection-pass" {}

variable "connection-sg-ids" {
  default = ""
}

variable "connection-subnet" {
  default = ""
}

variable "connection-azs" {
  default = ""
}

variable "connection-catalog-id" {
  default = ""
}

variable "connection-type" {
  default = "JDBC"
}

variable "connection-description" {
  default = ""
}

variable "connection-criteria" {
  type    = "list"
  default = []
}
#####Glue-Crawlers variables ######################################
variable "crawler-create" {
  default = true
}

variable "crawler-name" {}
variable "crawler-db" {}

variable "crawler-description" {
  default = ""
}

variable "crawler-role" {}

variable "crawler-schedule" {
  default = ""
}

variable "crawler-table-prefix" {}

variable "crawler-s3-path" {}

variable "crawler-s3-exclusions" {
  type    = "list"
  default = []
}

###Glue triggers variables###############
variable "trigger-create" {
  default = true
}

variable "trigger-name" {}

variable "trigger-type" {
  description = "It can be CONDITIONAL, ON_DEMAND, and SCHEDULED."
  default     = "SCHEDULED"
}

variable "trigger-schedule" {}

variable "trigger-enabled" {
  default = true
}

variable "trigger-description" {
  default = ""
}

variable "trigger-job-name" {}

variable "trigger-arguments" {
  type    = "map"
  default = {}
}

variable "trigger-timeout" {
  default = 2880
}

#### Glue JOb resources ###############
variable "job-create" {
  default = true
}

variable "job-name" {}

variable "job-role-arn" {}

variable "job--connections" {
  type    = "list"
  default = []
}

variable "job-dpu" {
  default = 2
}

variable "job-script-location" {}

variable "job-command-ame" {
  default = ""
}

variable "job-language" {
  default = "python"
}

variable "job-bookmark" {
  default     = "disabled"
  description = "It can be enabled, disabled or paused."
}

variable "job-bookmark-options" {
  type = "map"

  default = {
    enabled  = "job-bookmark-enable"
    disabled = "job-bookmark-disable"
    paused   = "job-bookmark-pause"
  }
}

variable "job-temp-dir" {}

variable "job-description" {
  default = ""
}

variable "job-max-retries" {
  default = 0
}

variable "job-timeout" {
  default = 2880
}

variable "job-max-concurrent" {
  default = 1
}

variable "job-arguments" {
  type    = "map"
  default = {}
}
