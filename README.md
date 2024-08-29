# Terraform AWS SSM Patch Management

This Terraform module manages patching for EC2 instances using AWS Systems Manager (SSM). It includes the creation of a patch baseline, patch groups, and a maintenance window to ensure that instances are patched within a controlled and predictable schedule.

## Resources Created

- **aws_ssm_patch_baseline**: Defines a patch baseline that specifies which patches are approved for installation on instances.
- **aws_ssm_patch_group**: Groups EC2 instances that should have the same patch compliance levels.
- **aws_ssm_maintenance_window**: Configures a maintenance window during which operations such as patching are performed.
- **aws_ssm_maintenance_window_target**: Targets specific resources or resource groups for tasks to run during the maintenance window.
- **aws_ssm_maintenance_window_task**: Defines tasks such as patching that run during the maintenance window.

## Usage

To use this module, include it in your Terraform configuration with the necessary variables.

### Patch Baseline Example

```hcl
module "windows_patch_baseline" {
    source              = "./modules/patch_baseline"
    baseline_name       = "Company-Windows-Patch-Baseline" 
    baseline_desc       = "Company Approved Windows Server Patch Baseline"
    baseline_os         = "WINDOWS"
    patch_filter        = ["WindowsServer2012R2", "WindowsServer2016", "WindowsServer2019", "WindowsServer2022", "MicrosoftDefenderAntivirus"]
    enable_non_security = false
}
```

### Patch Deployment Example

```hcl
module "windows_nonprod_patch_deployment" {
    source              = "./modules/patch_deployment"
    patch_baseline_id   = module.windows_patch_baseline.patch_baseline
    baseline_desc       = "Windows Server Patch Baseline"
    patch_group_name    = "windows-non-prod"
    maint_window_name   = "Windows-NonProd"
    maint_window_desc   = "Windows NonProd EC2 Patching Window"
    maint_window_sched  = "cron(0 19 ? * 3#2 *)"
}
```

### Variables

- `patch_baseline_name`: Name of the patch baseline.
- `patch_group_name`: Name of the patch group.
- `maintenance_window_name`: Name of the maintenance window.
- `maintenance_window_schedule`: Schedule of the maintenance window in cron or rate format.
- `region`: AWS region where the resources will be created.

### Resource Configuration Details

#### Patch Baseline (`aws_ssm_patch_baseline`)

This resource defines which patches should be approved for installation on instances. It includes configurations for auto-approval delays and operating system specifics.

#### Patch Group (`aws_ssm_patch_group`)

This resource groups EC2 instances under the same patch compliance requirements. A patch group is used to apply a patch baseline to a set of instances.

#### Maintenance Window (`aws_ssm_maintenance_window`)

Defines when operations such as patching are allowed to be performed. This helps in ensuring that patching happens during off-peak hours to minimize impact on business operations.

#### Maintenance Window Target (`aws_ssm_maintenance_window_target`)

Specifies targets for a task within a maintenance window. It can include instances or tags that identify the instances to target.

#### Maintenance Window Task (`aws_ssm_maintenance_window_task`)

Specifies a task to execute during a maintenance window, such as applying patches. It can be linked to a patch baseline and will execute against the targets defined in the maintenance window target.

## Outputs

- `patch_baseline_id`: The ID of the created patch baseline.
- `maintenance_window_id`: The ID of the created maintenance window.

## Requirements

- AWS Provider
- Terraform 0.12+

## Providers

- aws

## License

Specify the license under which this module is available, such as MIT, Apache 2.0, etc.