variable "namespace" {
  description = "Namespace for the resources"
  type        = string
}

variable "stage" {
  description = "Environment stage"
  type        = string
}

variable "authors_table_arn" {
  description = "ARN of the authors DynamoDB table"
  type        = string
}

variable "courses_table_arn" {
  description = "ARN of the courses DynamoDB table"
  type        = string
}