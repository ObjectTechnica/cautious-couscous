variable "baseline_name" {
  description = "Friendly name in AWS to identify the patch baseline"
}

variable "baseline_desc" {
  description = "What does this baseline do"
  type        = string
}

variable "baseline_os" {
  description = "This can either be WINDOWS or REDHAT_ENTERPRISE_LINUX declared in the root module"
}

variable "patch_filter" {
  description = "operationg systems to add to the patch baseline queue"
}

variable "enable_non_security" {
  description = "addition of non security related patches - WINDOWS does not support EnableNonSecurity "
}