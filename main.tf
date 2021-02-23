/*
 * # SSO Roles
 *
 * This module is used to configure AWS roles for use with SSO and implements the official
 * [CloudFormation Stack](https://debrosse-cloudformation-templates.s3-us-gov-west-1.amazonaws.com/aws-gov-cloud-default-aws-sso-roles.template).
 *
 * References:
 *
 * * [Enabling SAML 2.0 federation with AWS SSO and AWS Govcloud (US)](https://aws.amazon.com/blogs/publicsector/enabling-saml-2-0-federation-aws-sso-aws-govcloud-us/)
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
