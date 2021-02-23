
#
# Assume Role Policy
#

data "aws_iam_policy_document" "role_assume" {
  statement {
    effect = "Allow"
    principals {
      type = "Federated"
      identifiers = [
        aws_iam_saml_provider.saml.arn,
      ]
    }
    actions = [
      "sts:AssumeRoleWithSAML"
    ]
    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values = [
        var.application_acs_url,
      ]
    }
  }
}

#
# Admin Role
#

resource aws_iam_role "admin_role" {
  count = var.enable_admin_role ? 1 : 0

  name = var.admin_role_name
  path = "/"

  assume_role_policy   = data.aws_iam_policy_document.role_assume.json
  max_session_duration = var.max_session_duration_seconds

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "admin_managed_policy" {
  count = var.enable_admin_role ? 1 : 0

  role       = aws_iam_role.admin_role[0].name
  policy_arn = format("arn:%s:iam::aws:policy/AdministratorAccess", data.aws_partition.current.partition)
}

#
# Power User Role
#

resource aws_iam_role "power_user_role" {
  count = var.enable_power_user_role ? 1 : 0

  name = var.power_user_role_name
  path = "/"

  assume_role_policy   = data.aws_iam_policy_document.role_assume.json
  max_session_duration = var.max_session_duration_seconds

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "power_user_managed_policy" {
  count = var.enable_power_user_role ? 1 : 0

  role       = aws_iam_role.power_user_role[0].name
  policy_arn = format("arn:%s:iam::aws:policy/PowerUserAccess", data.aws_partition.current.partition)
}

#
# Read Only User
#

resource aws_iam_role "read_only_role" {
  count = var.enable_read_only_role ? 1 : 0

  name = var.read_only_role_name
  path = "/"

  assume_role_policy   = data.aws_iam_policy_document.role_assume.json
  max_session_duration = var.max_session_duration_seconds

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "read_only_managed_policy" {
  count = var.enable_read_only_role ? 1 : 0

  role       = aws_iam_role.read_only_role[0].name
  policy_arn = format("arn:%s:iam::aws:policy/ReadOnlyAccess", data.aws_partition.current.partition)
}
