resource "aws_api_gateway_rest_api" "api" {
  name        = "cloudtech-dev-api"
  description = "Serverless REST API for Lab"
}

resource "aws_api_gateway_resource" "authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "authors"
}
resource "aws_api_gateway_method" "get_authors" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.authors.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "get_authors_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.authors.id
  http_method             = aws_api_gateway_method.get_authors.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.get_all_authors_invoke_arn
}
resource "aws_api_gateway_method_response" "get_authors_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_authors.http_method
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true }
}
resource "aws_api_gateway_integration_response" "get_authors_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_authors.http_method
  status_code = aws_api_gateway_method_response.get_authors_200.status_code
  depends_on  = [aws_api_gateway_integration.get_authors_lambda]
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'" }
}

resource "aws_api_gateway_resource" "courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "courses"
}

resource "aws_api_gateway_method" "get_courses" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "get_courses_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.get_courses.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.get_all_courses_invoke_arn
}
resource "aws_api_gateway_method_response" "get_courses_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_courses.http_method
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true }
}
resource "aws_api_gateway_integration_response" "get_courses_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_courses.http_method
  status_code = aws_api_gateway_method_response.get_courses_200.status_code
  depends_on  = [aws_api_gateway_integration.get_courses_lambda]
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'" }
}

resource "aws_api_gateway_method" "post_courses" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.courses.id
  http_method   = "POST"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "post_courses_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.courses.id
  http_method             = aws_api_gateway_method.post_courses.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.save_course_invoke_arn
}
resource "aws_api_gateway_method_response" "post_courses_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_courses.http_method
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true }
}
resource "aws_api_gateway_integration_response" "post_courses_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.post_courses.http_method
  status_code = aws_api_gateway_method_response.post_courses_200.status_code
  depends_on  = [aws_api_gateway_integration.post_courses_lambda]
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'" }
}

resource "aws_api_gateway_resource" "course_id" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.courses.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "get_course" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.course_id.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "get_course_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.course_id.id
  http_method             = aws_api_gateway_method.get_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.get_course_invoke_arn
  request_templates = {
    "application/json" = <<EOF
{ "id": "$input.params('id')" }
EOF
  }
}
resource "aws_api_gateway_method_response" "get_course_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true }
}
resource "aws_api_gateway_integration_response" "get_course_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = aws_api_gateway_method_response.get_course_200.status_code
  depends_on  = [aws_api_gateway_integration.get_course_lambda]
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'" }
}

resource "aws_api_gateway_method" "put_course" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.course_id.id
  http_method   = "PUT"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "put_course_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.course_id.id
  http_method             = aws_api_gateway_method.put_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.update_course_invoke_arn
  request_templates = {
    "application/json" = <<EOF
{
  "id": "$input.params('id')",
  "title": $input.json('$.title'),
  "authorId": $input.json('$.authorId'),
  "length": $input.json('$.length'),
  "category": $input.json('$.category'),
  "watchHref": $input.json('$.watchHref')
}
EOF
  }
}
resource "aws_api_gateway_method_response" "put_course_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.put_course.http_method
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true }
}
resource "aws_api_gateway_integration_response" "put_course_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.put_course.http_method
  status_code = aws_api_gateway_method_response.put_course_200.status_code
  depends_on  = [aws_api_gateway_integration.put_course_lambda]
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'" }
}

resource "aws_api_gateway_method" "delete_course" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.course_id.id
  http_method   = "DELETE"
  authorization = "NONE"
}
resource "aws_api_gateway_integration" "delete_course_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.course_id.id
  http_method             = aws_api_gateway_method.delete_course.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = module.lambda.delete_course_invoke_arn
  request_templates = {
    "application/json" = <<EOF
{ "id": "$input.params('id')" }
EOF
  }
}
resource "aws_api_gateway_method_response" "delete_course_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.delete_course.http_method
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = true }
}
resource "aws_api_gateway_integration_response" "delete_course_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.course_id.id
  http_method = aws_api_gateway_method.delete_course.http_method
  status_code = aws_api_gateway_method_response.delete_course_200.status_code
  depends_on  = [aws_api_gateway_integration.delete_course_lambda]
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'" }
}

resource "aws_lambda_permission" "apigw_get_authors" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.get_all_authors_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
resource "aws_lambda_permission" "apigw_get_courses" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.get_all_courses_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
resource "aws_lambda_permission" "apigw_get_course" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.get_course_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
resource "aws_lambda_permission" "apigw_post_courses" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.save_course_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
resource "aws_lambda_permission" "apigw_put_course" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.update_course_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
resource "aws_lambda_permission" "apigw_delete_course" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.delete_course_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "api_deploy" {
  depends_on = [
    aws_api_gateway_integration.get_authors_lambda,
    aws_api_gateway_integration.get_courses_lambda,
    aws_api_gateway_integration.post_courses_lambda,
    aws_api_gateway_integration.get_course_lambda,
    aws_api_gateway_integration.put_course_lambda,
    aws_api_gateway_integration.delete_course_lambda
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
  lifecycle { create_before_destroy = true }
}

resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "v1" 
}

output "public_api_url_authors" {
  value = "${aws_api_gateway_stage.api_stage.invoke_url}/authors"
}
output "public_api_url_courses" {
  value = "${aws_api_gateway_stage.api_stage.invoke_url}/courses"
}