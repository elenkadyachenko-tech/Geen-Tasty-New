provider "aws" {
    region = "eu-north-1"
}

data "archive_file" "python_code"{
    type = "zip"
    source_file = "${path.module}/lambda/lambda_function.py"
    output_path = "function5.zip"
}

data "aws_iam_policy_document" "assume_role"{
    statement{
        effect = "Allow"
        principals  { 
            type = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }
        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "lambda_role" {
    name               = "lambda_execution_role"
    assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "lambda" {
    filename         = data.archive_file.python_code.output_path
    role = "arn:aws:iam::134580877804:role/PowerUser-lambda-1"
    function_name    = "marathon_lambda_function"
    handler          = "lambda_function.lambda_handler"
    runtime          = "python3.13"
}

