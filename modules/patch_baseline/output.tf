output "patch_baseline" {
   description = "the pb-* id for the specific patch baseline"
   value       = aws_ssm_patch_baseline.patch_baseline.id
}
