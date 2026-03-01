terraform {
  backend "s3" {
    bucket         = "967519196609-terraform-tfstate"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-tfstate-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "dynamodb" {
  source    = "./modules/dynamodb"
  namespace = "cloudtech"
  stage     = "dev"
}

module "iam" {
  source            = "./modules/iam"
  namespace         = "cloudtech"
  stage             = "dev"
  
  authors_table_arn = module.dynamodb.authors_table_arn
  courses_table_arn = module.dynamodb.courses_table_arn
}

module "lambda" {
  source                    = "./modules/lambda"
  namespace                 = "cloudtech"
  stage                     = "dev"
  
  get_all_authors_role_arn  = module.iam.get_all_authors_role_arn
  get_all_courses_role_arn  = module.iam.get_all_courses_role_arn
  get_course_role_arn       = module.iam.get_course_role_arn
  put_course_role_arn       = module.iam.put_course_role_arn
  delete_course_role_arn    = module.iam.delete_course_role_arn
}