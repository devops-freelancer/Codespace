output "connection-name" {
  value = "${module.glue_connection.connection-name}"
}

output "connection-type" {
  value = "${module.glue_connection.connection-type}"
}

output "connection-vpc-settings" {
  value = "${module.glue_connection.connection-vpc-settings}"
}

output "connection-catalog-id" {
  value = "${module.glue_connection.connection-catalog}"
}

output "crawler-s3-name" {
  value = "${module.glue_crawler.crawler-s3-name}"
}

output "crawler-s3-db" {
  value = "${module.glue_crawler.crawler-s3-db}"
}

output "db-name" {
  value = "${module.glue_database.db-name}"
}

output "job-name" {
  value = "${module.glue_job.job-name}"
}

output "job-dpu" {
  value = "${module.glue_job.job-dpu}"
}

output "trigger-name" {
  value = "${module.glue_trigger.trigger-name}"
}

output "trigger-schedule" {
  value = "${module.glue_trigger.trigger-schedule}"
}