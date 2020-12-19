variable "AWS_REGION" {
type = string
default = "us-east-1"
description = "Région de notre instance ec2"
}

variable "AWS_ACCESS_KEY" {


}
variable "AWS_SECRET_KEY" {


}


variable "AWS_AMIS" {
type = map(string)
default = {
"eu-west-1" = "ami-0aef57767f5404a3c"
"us-east-1" = "ami-04d29b6f966df1537"
"us-east-2" = "ami-07c1207a9d40bc3bd"
}
}







variable "region" {
  description = "The AWS region we want this bucket to live in."
  default     = "us-east-1"
}

variable "app_name" {
  description = "The AWS region we want this bucket to live in."
  default     = "teraform-kinesis"
}


variable "shard_count" {
  description = "The number of shards that the stream will use."
  default     = "1"
}

variable "retention_period" {
  description = "Length of time data records are accessible after they are added to the stream."
  default     = "48"
}

variable "shard_level_metrics" {
  type        = list(string)
  description = "A list of shard-level CloudWatch metrics which can be enabled for the stream."
  default     = []
}

variable "s3_bucket_arn" {
  description = "s3 bucket arn where kinesis firehose put data."
  default     = "arn:aws:s3:::hejer-bucket"
}

variable "s3_bucket_path" {
  description = "s3 bucket path where kinesis firehose put data."
  default     = "s3://hejer-bucket"
}

variable "storage_input_format" {
  description = "storage input format for aws glue for parcing data"
  default     = "org.apache.hadoop.mapred.TextInputFormat"
}

variable "storage_output_format" {
  description = "storage output format for aws glue for parcing data"
  default     = "org.apache.hadoop.mapred.TextInputFormat"
}






