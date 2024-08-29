variable "baseline_desc" {
  description = "What does this baseline do"
  type        = string
}

variable "patch_baseline_id" {
  description = "patch baseline id created by the patch_baseline module"
}

variable "patch_group_name" {
  description = "Friendly name for the associated patch group"
}

variable "maint_window_name" {
  description = "Friendly name for the Patching Maintence Window"
}

variable "maint_window_desc" {
  description = "Friendly description for the maintence window"
}

variable "maint_window_sched" {
  description = "CRON expression used to schedule the maintenance window"
}
