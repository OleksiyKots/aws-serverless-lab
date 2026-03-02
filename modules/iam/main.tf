data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "get_all_authors" {
  name               = "${var.namespace}-${var.stage}-get-all-authors-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}
resource "aws_iam_role_policy" "get_all_authors" {
  name   = "dynamodb-scan-authors"
  role   = aws_iam_role.get_all_authors.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], Resource = "arn:aws:logs:*:*:*" },
      { Effect = "Allow", Action = "dynamodb:Scan", Resource = var.authors_table_arn }
    ]
  })
}

resource "aws_iam_role" "get_all_courses" {
  name               = "${var.namespace}-${var.stage}-get-all-courses-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}
resource "aws_iam_role_policy" "get_all_courses" {
  name   = "dynamodb-scan-courses"
  role   = aws_iam_role.get_all_courses.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], Resource = "arn:aws:logs:*:*:*" },
      { Effect = "Allow", Action = "dynamodb:Scan", Resource = var.courses_table_arn }
    ]
  })
}

resource "aws_iam_role" "get_course" {
  name               = "${var.namespace}-${var.stage}-get-course-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}
resource "aws_iam_role_policy" "get_course" {
  name   = "dynamodb-get-course"
  role   = aws_iam_role.get_course.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], Resource = "arn:aws:logs:*:*:*" },
      { Effect = "Allow", Action = "dynamodb:GetItem", Resource = var.courses_table_arn }
    ]
  })
}

resource "aws_iam_role" "put_course" {
  name               = "${var.namespace}-${var.stage}-put-course-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}
resource "aws_iam_role_policy" "put_course" {
  name   = "dynamodb-put-course"
  role   = aws_iam_role.put_course.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], Resource = "arn:aws:logs:*:*:*" },
      { Effect = "Allow", Action = "dynamodb:PutItem", Resource = var.courses_table_arn }
    ]
  })
}

resource "aws_iam_role" "delete_course" {
  name               = "${var.namespace}-${var.stage}-delete-course-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}
resource "aws_iam_role_policy" "delete_course" {
  name   = "dynamodb-delete-course"
  role   = aws_iam_role.delete_course.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"], Resource = "arn:aws:logs:*:*:*" },
      { Effect = "Allow", Action = "dynamodb:DeleteItem", Resource = var.courses_table_arn }
    ]
  })
}