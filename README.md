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

### IAM Roles

This module comes with three pre-configured roles that can be created. By default they are not created. This list of roles is:

* Admin Access
* Power User Access
* Read Only Access

If you are providing an external IAM role then you do not need to enable any of these.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |
| <a name="provider_http"></a> [http](#provider\_http) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.admin_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.power_user_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.read_only_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.admin_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.power_user_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_only_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_saml_provider.saml](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) | data source |
| [aws_iam_policy_document.role_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [http_http.metadata](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_role_name"></a> [admin\_role\_name](#input\_admin\_role\_name) | Role name for administrator access. | `string` | `"AWS_SSO_AdministratorAccessRole"` | no |
| <a name="input_application_acs_url"></a> [application\_acs\_url](#input\_application\_acs\_url) | The Assertion Consumer Service (ACS) URL is used to identify where the service provider accepts SAML assertions. | `string` | `"https://signin.amazonaws-us-gov.com/saml"` | no |
| <a name="input_aws_sso_metadata_url"></a> [aws\_sso\_metadata\_url](#input\_aws\_sso\_metadata\_url) | Publicly accessible HTTPS location where SAML metadata.xml can be downloaded. | `string` | n/a | yes |
| <a name="input_enable_admin_role"></a> [enable\_admin\_role](#input\_enable\_admin\_role) | Create an administrative role. | `string` | `false` | no |
| <a name="input_enable_power_user_role"></a> [enable\_power\_user\_role](#input\_enable\_power\_user\_role) | Create a power user role. | `string` | `false` | no |
| <a name="input_enable_read_only_role"></a> [enable\_read\_only\_role](#input\_enable\_read\_only\_role) | Create a read-only role. | `string` | `false` | no |
| <a name="input_max_session_duration_seconds"></a> [max\_session\_duration\_seconds](#input\_max\_session\_duration\_seconds) | Maximum CLI Session duration in seconds | `number` | `14400` | no |
| <a name="input_power_user_role_name"></a> [power\_user\_role\_name](#input\_power\_user\_role\_name) | Role name for power user access. | `string` | `"AWS_SSO_PowerUserAccessRole"` | no |
| <a name="input_read_only_role_name"></a> [read\_only\_role\_name](#input\_read\_only\_role\_name) | Role name for read-only access. | `string` | `"AWS_SSO_ReadOnlyAccessRole"` | no |
| <a name="input_saml_provider_name"></a> [saml\_provider\_name](#input\_saml\_provider\_name) | The name of the IAM SAML identity provider that will be created in Identity and Access Management. | `string` | `"AWS-SSO"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assume_role_policy"></a> [assume\_role\_policy](#output\_assume\_role\_policy) | IAM Assume Role Policy to use with other SAML enabled roles. |
| <a name="output_identity_provider_arn"></a> [identity\_provider\_arn](#output\_identity\_provider\_arn) | ARN for SAML Identity Provider created in IAM |
| <a name="output_max_session_duration_seconds"></a> [max\_session\_duration\_seconds](#output\_max\_session\_duration\_seconds) | Maximum CLI Session duration in seconds |
| <a name="output_role_arn_admin"></a> [role\_arn\_admin](#output\_role\_arn\_admin) | ARN for Admin role |
| <a name="output_role_arn_power_user"></a> [role\_arn\_power\_user](#output\_role\_arn\_power\_user) | ARN for Power User role |
| <a name="output_role_arn_read_only"></a> [role\_arn\_read\_only](#output\_role\_arn\_read\_only) | ARN for Read Only role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
