# Patch Group Associations
resource "aws_ssm_patch_group" "patch_group" {
  baseline_id     = "${var.patch_baseline_id}"
  patch_group     = "${var.patch_group_name}"
}

# Maintenance Window
resource "aws_ssm_maintenance_window" "maintenance_window" {
  name            = "${var.maint_window_name}"
  description     = "${var.maint_window_desc}"
  schedule        = "${var.maint_window_sched}"  # Second Tuesday of every month at 7 PM EST
  schedule_offset = 1
  duration        = 5
  cutoff          = 1
}

# Maintenance Window Target for Windows
resource "aws_ssm_maintenance_window_target" "maintenance_window_target" {
  window_id       = aws_ssm_maintenance_window.maintenance_window.id
  name            = "${var.patch_group_name}"
  description     = "${var.baseline_desc}"
  resource_type   = "INSTANCE"
  targets {
    key           = "tag:Patch Group"
    values        = ["${var.patch_group_name}"]
  }
}

# Maintenance Window Task for Windows
resource "aws_ssm_maintenance_window_task" "main_window_task" {
  window_id       = aws_ssm_maintenance_window.maintenance_window.id
  name            = "${var.patch_group_name}"
  description     = "${var.baseline_desc}" 
  max_concurrency = 100
  max_errors      = 50
  priority        = 1
  cutoff_behavior = "CANCEL_TASK"
  targets {
    key           = "WindowTargetIds"
    values        = [aws_ssm_maintenance_window_target.maintenance_window_target.id]
  }
  task_arn        = "AWS-RunPatchBaseline"
  service_role_arn = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"  # Replace with your role ARN
  task_type       = "RUN_COMMAND"
  task_invocation_parameters {
    run_command_parameters {
      document_version = "$LATEST"
      parameter {
        name   = "Operation"
        values = ["Install"]
      }
      parameter {
        name = "RebootOption"
        values = ["RebootIfNeeded"]
      }
    }
  }
}
