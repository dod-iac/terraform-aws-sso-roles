# SSO Roles

This module is used to configure AWS roles for use with SSO and implements the official
[CloudFormation Stack](https://debrosse-cloudformation-templates.s3-us-gov-west-1.amazonaws.com/aws-gov-cloud-default-aws-sso-roles.template).

References:

* [Enabling SAML 2.0 federation with AWS SSO and AWS Govcloud (US)](https://aws.amazon.com/blogs/publicsector/enabling-saml-2-0-federation-aws-sso-aws-govcloud-us/)

## Usage

```hcl
module "sso_roles" {
  source = "dod-iac/sso-roles/aws"

  aws_sso_metadata_url = "http://example.com/"

  tags = {
    Project     = var.project
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | >= 3.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [archive_file](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) |
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/data-sources/caller_identity) |
| [aws_iam_account_alias](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/data-sources/iam_account_alias) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/data-sources/iam_policy_document) |
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/resources/iam_policy) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/resources/iam_role_policy_attachment) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/resources/iam_role) |
| [aws_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/resources/lambda_function) |
| [aws_partition](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/data-sources/partition) |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/3.0/docs/data-sources/region) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_role\_name | Role name for administrator access. | `string` | `"AWS_SSO_AdministratorAccessRole"` | no |
| aws\_sso\_metadata\_url | Publicly accessible HTTPS location where SAML metadata.xml can be downloaded. | `string` | n/a | yes |
| enable\_admin\_role | Create an administrative role. | `string` | `true` | no |
| enable\_power\_user\_role | Create a power user role. | `string` | `true` | no |
| enable\_read\_only\_role | Create a read-only role. | `string` | `true` | no |
| max\_session\_duration\_seconds | Maximum CLI Session duration in seconds | `number` | `14400` | no |
| power\_user\_role\_name | Role name for power user access. | `string` | `"AWS_SSO_PowerUserAccessRole"` | no |
| read\_only\_role\_name | Role name for read-only access. | `string` | `"AWS_SSO_ReadOnlyAccessRole"` | no |
| saml\_provider\_name | The name of the IAM SAML identity provider that will be created in Identity and Access Management. | `string` | `"AWS-SSO"` | no |
| tags | Tags to be applied to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| identity\_provider\_arn | ARN for SAML Identity Provider created in IAM |
| role\_arn\_admin | ARN for Admin role |
| role\_arn\_power\_user | ARN for Power User role |
| role\_arn\_read\_only | ARN for Read Only role |
