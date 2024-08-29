# Create Patch Baselines
resource "aws_ssm_patch_baseline" "patch_baseline" {
  name             = "${var.baseline_name}"
  description      = "${var.baseline_desc}"
  operating_system = "${var.baseline_os}"
  # approved_patches_compliance_level = "CRITICAL"
  
approval_rule {
    patch_filter {
      key    = "PRODUCT"
      values = "${var.patch_filter}"
    }
    approve_after_days  = 0
    enable_non_security = "${var.enable_non_security}"
  }
}
