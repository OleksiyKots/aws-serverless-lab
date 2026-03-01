module "courses_label" {
  source    = "cloudposse/label/null"
  version   = "0.25.0"
  namespace = var.namespace
  stage     = var.stage
  name      = "courses"
}

resource "aws_dynamodb_table" "courses" {
  name         = module.courses_label.id
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

module "authors_label" {
  source    = "cloudposse/label/null"
  version   = "0.25.0"
  namespace = var.namespace
  stage     = var.stage
  name      = "authors"
}

resource "aws_dynamodb_table" "authors" {
  name         = module.authors_label.id
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}