###
# Provider Var's
###
variable "region" {
  default     = "us-gov-west-1"
}

variable "applicationName" {
  default     = ""
}

variable "businessUnit" {
  default     = ""
}

variable "costCenterId" {
  default     = "" 
}

variable "costCenterName" {
  default     = ""
}

variable "environment" {
  default     = "" 
}

variable "function" {
  default     = "" 
}

variable "gitlabRepo" {
  default     = "" 
}

variable "gitlabOrg" {
  default     = ""
}

variable "provisioner" {
  default     = ""
}

variable "requestor" {
  default     = ""
}

variable "terraform" {
  default     = "" 
}

variable "supportEmail" {
  default     = "" 
}

variable "backupPolicy" {
  default     = "" 
}

variable "os" {
  default     = "" 
}

variable "vulnerabilityScan" {
  default     = ""
}

variable "adjoin" {
  default     = ""   
}

###
# Resource Var's
###
variable "monitoring_account_id" {
  description = "The 12-digit AWS Account ID for the Centralized monitoring account"
  default     = "833617259660"
}