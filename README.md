<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# SSO Roles

This module is used to configure AWS roles for use with SSO and implements the official
[CloudFormation Stack](https://debrosse-cloudformation-templates.s3-us-gov-west-1.amazonaws.com/aws-gov-cloud-default-aws-sso-roles.template).

References:

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

## SSO Application Configuration

For more detailed help see the references:

* [Enabling SAML 2.0 federation with AWS SSO and AWS Govcloud (US)](https://aws.amazon.com/blogs/publicsector/enabling-saml-2-0-federation-aws-sso-aws-govcloud-us/)
* [Troubleshooting SAML 2.0 federation with AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_saml.html)

This section details some helpful information when creating a new SSO Application.

### Details

* Display Name: `<account-alias> (<role name)`
* Description: `Access to AWS GovCloud Account <account-alias>`

### Application properties

* Application start URL: Leave blank
* Relay state: Leave blank
* Session Duration: 1 hour

### Application metadata

* Application ACS URL: <https://signin.amazonaws-us-gov.com/saml>
* Application SAML audience: `urn:amazon:webservices:govcloud`

### Attribute Mappings

| User attribute in the application | Maps to this string value or user attribute in AWS SSO | Format |
| --- | --- | --- |
| Subject | `${user:name}` | persistent |
| <https://aws.amazon.com/SAML/Attributes/RoleSessionName> | `${user:email}` | unspecified |
| <https://aws.amazon.com/SAML/Attributes/Role> | `<saml-provider-arn>,<iam-role-arn>` | unspecified |

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.0 |
| http | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| http | >= 2.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_iam_account_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| [aws_iam_saml_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) |
| [aws_partition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) |
| [http_http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_role\_name | Role name for administrator access. | `string` | `"AWS_SSO_AdministratorAccessRole"` | no |
| application\_acs\_url | The Assertion Consumer Service (ACS) URL is used to identify where the service provider accepts SAML assertions. | `string` | `"https://signin.amazonaws-us-gov.com/saml"` | no |
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
| assume\_role\_policy | IAM Assume Role Policy to use with other SAML enabled roles. |
| identity\_provider\_arn | ARN for SAML Identity Provider created in IAM |
| max\_session\_duration\_seconds | Maximum CLI Session duration in seconds |
| role\_arn\_admin | ARN for Admin role |
| role\_arn\_power\_user | ARN for Power User role |
| role\_arn\_read\_only | ARN for Read Only role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
