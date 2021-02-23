

#
# SAML Idp Lambda Role
#

data "aws_iam_policy_document" "lambda_idp_role_assume" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource aws_iam_role "lambda_idp_role" {
  name = format("lambda-idp")
  path = "/"

  assume_role_policy   = data.aws_iam_policy_document.lambda_idp_role_assume.json
  max_session_duration = var.max_session_duration_seconds

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda_managed_policy" {
  role       = aws_iam_role.lambda_idp_role.name
  policy_arn = format("arn:%s:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", data.aws_partition.current.partition)
}

data "aws_iam_policy_document" "lambda_saml" {
  statement {
    sid    = "createupdate"
    effect = "Allow"
    actions = [
      "iam:CreateSAMLProvider",
      "iam:UpdateSAMLProvider",
      "iam:DeleteSAMLProvider",
    ]
    resources = [
      format("arn:%s:iam::*:saml-provider/%s",
        data.aws_partition.current.partition,
        var.saml_provider_name,
      )
    ]
  }

  statement {
    sid    = "list"
    effect = "Allow"
    actions = [
      "iam:ListSAMLProviders",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_saml" {
  name        = "lambda_saml"
  path        = "/"
  description = "Manage SAML Providers"
  policy      = data.aws_iam_policy_document.lambda_saml.json
}

resource "aws_iam_role_policy_attachment" "lambda_saml" {
  role       = aws_iam_role.lambda_idp_role.name
  policy_arn = aws_iam_policy.lambda_saml.arn
}

#
# SAML IDP Lambda Function
#

locals {
  lambda_filename = format("%s/saml-idp.js", path.module)
  output_path     = format("%s/build/saml-idp.zip", path.module)
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = local.lambda_filename
  output_path = local.output_path
}

resource "aws_lambda_function" "idp" {
  function_name    = "lambda-idp"
  role             = aws_iam_role.lambda_idp_role.arn
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  timeout          = 30
  filename         = local.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  environment {
    variables = {
      METADATA_URL = var.aws_sso_metadata_url
      IDP_NAME     = var.saml_provider_name
    }
  }
  tags = var.tags
}
