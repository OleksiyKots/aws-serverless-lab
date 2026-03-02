output "get_all_authors_invoke_arn" { value = aws_lambda_function.get_all_authors.invoke_arn }
output "get_all_authors_function_name" { value = aws_lambda_function.get_all_authors.function_name }

output "get_all_courses_invoke_arn" { value = aws_lambda_function.get_all_courses.invoke_arn }
output "get_all_courses_function_name" { value = aws_lambda_function.get_all_courses.function_name }

output "get_course_invoke_arn" { value = aws_lambda_function.get_course.invoke_arn }
output "get_course_function_name" { value = aws_lambda_function.get_course.function_name }

output "save_course_invoke_arn" { value = aws_lambda_function.save_course.invoke_arn }
output "save_course_function_name" { value = aws_lambda_function.save_course.function_name }

output "update_course_invoke_arn" { value = aws_lambda_function.update_course.invoke_arn }
output "update_course_function_name" { value = aws_lambda_function.update_course.function_name }

output "delete_course_invoke_arn" { value = aws_lambda_function.delete_course.invoke_arn }
output "delete_course_function_name" { value = aws_lambda_function.delete_course.function_name }