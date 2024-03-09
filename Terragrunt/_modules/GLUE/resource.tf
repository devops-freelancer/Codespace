###Glue-Data-catalog-database-resource block###########
resource "aws_glue_catalog_database" "this" {
  count = "${var."db-create ? 1 : 0}"
  name = "${var.db-name}"
  description  = "${var.db-description}"
  catalog_id   = "${var.db-catalog}"
  location_uri = "${var.db-location-uri}"
  parameters   = "${var.db-params}"
}

###Glue-connection-resources###########
resource "aws_glue_connection" "glue_connection_vpc" {
  count = "${var.connection-create ? 1 : 0}"
  name = "${var.connection-name}"
  connection_properties = {
    JDBC_CONNECTION_URL = "${var.connection-url}"
    USERNAME            = "${var.connection-user}"
    PASSWORD            = "${var.connection-pass}"
  }
  physical_connection_requirements {
    security_group_id_list = "${var.connection-sg-ids}"
    subnet_id              = "${var.connection-subnet}"
    availability_zone      = "${var.connection-azs}"
  }
  catalog_id      = "${var.connection-catalog-id}"
  connection_type = "${var.connection-type}"
  description     = "${var.connection-description}"
  match_criteria  = "${var.connection-criteria}"
}

###Glue-Crawlers-resources###########
resource "aws_glue_crawler" "this" {
  count = "${var.crawler-create ? 1 : 0}"

  name          = "${var.crawler-name}"
  database_name = "${var.crawler-db}"
  role          = "${var.crawler-role}"

  schedule     = "${var.crawler-schedule}"
  table_prefix = "${var.crawler-table-prefix}"
  description  = "${var.crawler-description}"

  s3_target {
    path = "${var.crawler-s3-path}"
  }
}

###Glue-Triggers-resources######################
resource "aws_glue_trigger" "this" {
  count = "${var.trigger-create ? 1 : 0}"

  name     = "${var.trigger-name}"
  schedule = "${var.trigger-schedule}"
  type     = "${var.trigger-type}"

  enabled     = "${var.trigger-enabled}"
  description = "${var.trigger-description}"

  actions {
    job_name  = "${var.trigger-job-name}"
    arguments = "${var.trigger-arguments}"
    timeout   = "${var.trigger-timeout}"
  }
}

###Glue-Job-resource block###########

locals {
  default-arguments = {
    "--job-language"        = "${var.job-language}"
    "--job-bookmark-option" = "${lookup(var.job-bookmark-options, var.job-bookmark)}"
    "--TempDir"             = "${var.job-temp-dir}"
  }
}

resource "aws_glue_job" "this" {
  count = "${var.job-create ? 1 : 0}"

  name               = "${var.job-name}"
  role_arn           = "${var.job-role-arn}"
  connections        = ["${var.job-connections}"]
  allocated_capacity = "${var.job-dpu}"

  command {
    script_location = "${var.job-script-location}"
  }

  # https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-glue-arguments.html
  default_arguments = "${merge(local.default-arguments, var.job-arguments)}"

  description = "${var.job-description}"
  max_retries = "${var.job-max-retries}"
  timeout     = "${var.job-timeout}"

  execution_property {
    max_concurrent_runs = "${var.job-max-concurrent}"
  }
}

