data "archive_file" "get_all_authors_zip" {
  type        = "zip"
  source_file = "${path.module}/src/get-all-authors.js"
  output_path = "${path.module}/get-all-authors.zip"
}
resource "aws_lambda_function" "get_all_authors" {
  filename         = data.archive_file.get_all_authors_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-get-all-authors"
  role             = var.get_all_authors_role_arn
  handler          = "get-all-authors.handler"
  source_code_hash = data.archive_file.get_all_authors_zip.output_base64sha256
  runtime          = "nodejs18.x"
}

data "archive_file" "get_all_courses_zip" {
  type        = "zip"
  source_file = "${path.module}/src/get-all-courses.js"
  output_path = "${path.module}/get-all-courses.zip"
}
resource "aws_lambda_function" "get_all_courses" {
  filename         = data.archive_file.get_all_courses_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-get-all-courses"
  role             = var.get_all_courses_role_arn
  handler          = "get-all-courses.handler"
  source_code_hash = data.archive_file.get_all_courses_zip.output_base64sha256
  runtime          = "nodejs18.x"
}

data "archive_file" "get_course_zip" {
  type        = "zip"
  source_file = "${path.module}/src/get-course.js"
  output_path = "${path.module}/get-course.zip"
}
resource "aws_lambda_function" "get_course" {
  filename         = data.archive_file.get_course_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-get-course"
  role             = var.get_course_role_arn
  handler          = "get-course.handler"
  source_code_hash = data.archive_file.get_course_zip.output_base64sha256
  runtime          = "nodejs18.x"
}

data "archive_file" "save_course_zip" {
  type        = "zip"
  source_file = "${path.module}/src/save-course.js"
  output_path = "${path.module}/save-course.zip"
}
resource "aws_lambda_function" "save_course" {
  filename         = data.archive_file.save_course_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-save-course"
  role             = var.put_course_role_arn
  handler          = "save-course.handler"
  source_code_hash = data.archive_file.save_course_zip.output_base64sha256
  runtime          = "nodejs18.x"
}

data "archive_file" "update_course_zip" {
  type        = "zip"
  source_file = "${path.module}/src/update-course.js"
  output_path = "${path.module}/update-course.zip"
}
resource "aws_lambda_function" "update_course" {
  filename         = data.archive_file.update_course_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-update-course"
  role             = var.put_course_role_arn
  handler          = "update-course.handler"
  source_code_hash = data.archive_file.update_course_zip.output_base64sha256
  runtime          = "nodejs18.x"
}

data "archive_file" "delete_course_zip" {
  type        = "zip"
  source_file = "${path.module}/src/delete-course.js"
  output_path = "${path.module}/delete-course.zip"
}
resource "aws_lambda_function" "delete_course" {
  filename         = data.archive_file.delete_course_zip.output_path
  function_name    = "${var.namespace}-${var.stage}-delete-course"
  role             = var.delete_course_role_arn
  handler          = "delete-course.handler"
  source_code_hash = data.archive_file.delete_course_zip.output_base64sha256
  runtime          = "nodejs18.x"
}