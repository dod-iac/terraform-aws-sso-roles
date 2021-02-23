
data "http" "metadata" {
  url = var.aws_sso_metadata_url
}

resource "aws_iam_saml_provider" "saml" {
  name                   = var.saml_provider_name
  saml_metadata_document = data.http.metadata.body
}
