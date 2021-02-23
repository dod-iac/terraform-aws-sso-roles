/*
 * # SSO Roles
 *
 * This module is used to configure AWS roles for use with SSO and implements the official
 * [CloudFormation Stack](https://debrosse-cloudformation-templates.s3-us-gov-west-1.amazonaws.com/aws-gov-cloud-default-aws-sso-roles.template).
 *
 * References:
 *
 *
 * ## Usage
 *
 * ```hcl
 * module "sso_roles" {
 *   source = "dod-iac/sso-roles/aws"
 *
 *   aws_sso_metadata_url = "http://example.com/"
 *
 *   tags = {
 *     Project     = var.project
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * ## SSO Application Configuration
 *
 * For more detailed help see the references:
 *
 * * [Enabling SAML 2.0 federation with AWS SSO and AWS Govcloud (US)](https://aws.amazon.com/blogs/publicsector/enabling-saml-2-0-federation-aws-sso-aws-govcloud-us/)
 * * [Troubleshooting SAML 2.0 federation with AWS](https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_saml.html)
 *
 * This section details some helpful information when creating a new SSO Application.
 *
 * ### Details
 *
 * * Display Name: `<account-alias> (<role name)`
 * * Description: `Access to AWS GovCloud Account <account-alias>`
 *
 * ### Application properties
 *
 * * Application start URL: Leave blank
 * * Relay state: Leave blank
 * * Session Duration: 1 hour
 *
 * ### Application metadata
 *
 * * Application ACS URL: <https://signin.amazonaws-us-gov.com/saml>
 * * Application SAML audience: `urn:amazon:webservices:govcloud`
 *
 * ### Attribute Mappings
 *
 * | User attribute in the application | Maps to this string value or user attribute in AWS SSO | Format |
 * | --- | --- | --- |
 * | Subject | `${user:name}` | persistent |
 * | <https://aws.amazon.com/SAML/Attributes/RoleSessionName> | `${user:email}` | unspecified |
 * | <https://aws.amazon.com/SAML/Attributes/Role> | `<saml-provider-arn>,<iam-role-arn>` | unspecified |
 *
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 *
 */

data "aws_caller_identity" "current" {}
data "aws_iam_account_alias" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}
