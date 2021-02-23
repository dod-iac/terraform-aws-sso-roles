
variable "aws_sso_metadata_url" {
  type        = string
  description = "Publicly accessible HTTPS location where SAML metadata.xml can be downloaded."
}

variable "saml_provider_name" {
  type        = string
  description = "The name of the IAM SAML identity provider that will be created in Identity and Access Management."
  default     = "AWS-SSO"
}

variable "admin_role_name" {
  type        = string
  description = "Role name for administrator access."
  default     = "AWS_SSO_AdministratorAccessRole"
}

variable "power_user_role_name" {
  type        = string
  description = "Role name for power user access."
  default     = "AWS_SSO_PowerUserAccessRole"
}

variable "read_only_role_name" {
  type        = string
  description = "Role name for read-only access."
  default     = "AWS_SSO_ReadOnlyAccessRole"
}

variable "enable_admin_role" {
  type        = string
  description = "Create an administrative role."
  default     = true
}

variable "enable_power_user_role" {
  type        = string
  description = "Create a power user role."
  default     = true
}

variable "enable_read_only_role" {
  type        = string
  description = "Create a read-only role."
  default     = true
}

variable "max_session_duration_seconds" {
  type        = number
  description = "Maximum CLI Session duration in seconds"
  default     = 14400
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to resources"
  default     = {}
}
