variable "client_id" {
  description = "Please enter your Client ID (AppId)"
  type        = string
}

variable "client_secret" {
  description = "Please enter your application password/secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Please enter your Azure AD Tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Please enter your Azure Subscription ID"
  type        = string
}

variable "admin_username" {
  description = "Username for the Windows VM"
  type        = string
  default     = "arcadmin"
}

variable "admin_password" {
  description = "Password for the Windows VM"
  type        = string
  sensitive   = true
}
