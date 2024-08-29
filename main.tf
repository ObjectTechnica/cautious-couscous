module "windows_patch_baseline" {
    source              = "./modules/patch_baseline"
    baseline_name       = "NASA-Windows-Patch-Baseline" 
    baseline_desc       = "NASA Approved Windows Server Patch Baseline"
    baseline_os         = "WINDOWS"
    patch_filter        = ["WindowsServer2012R2", "WindowsServer2016", "WindowsServer2019", "WindowsServer2022", "MicrosoftDefenderAntivirus"]
    enable_non_security = false
}

module "linux_patch_baseline" {
    source              = "./modules/patch_baseline"
    baseline_name       = "NASA-RedHat-Patch-Baseline" 
    baseline_desc       = "NASA Approved RedHat Server Patch Baseline"
    baseline_os         = "REDHAT_ENTERPRISE_LINUX"
    patch_filter        = ["RedhatEnterpriseLinux8", "RedhatEnterpriseLinux7"]
    enable_non_security = true
}

module "windows_nonprod_patch_deployment" {
    source              = "./modules/patch_deployment"
    patch_baseline_id   = module.windows_patch_baseline.patch_baseline
    baseline_desc       = "Windows Server Patch Baseline"
    patch_group_name    = "windows-non-prod"
    maint_window_name   = "Windows-NonProd"
    maint_window_desc   = "Windows NonProd EC2 Patching Window"
    maint_window_sched  = "cron(0 19 ? * 3#2 *)"
}

module "windows_prod_patch_deployment" {
    source              = "./modules/patch_deployment"
    patch_baseline_id   = module.windows_patch_baseline.patch_baseline
    baseline_desc       = "Windows Server Patch Baseline"
    patch_group_name    = "windows-prod"
    maint_window_name   = "Windows-Prod"
    maint_window_desc   = "Windows Prod EC2 Patching Window"
    maint_window_sched  = "cron(0 19 ? * 3#3 *)"
}

module "linux_nonprod_patch_deployment" {
    source              = "./modules/patch_deployment"
    patch_baseline_id   = module.linux_patch_baseline.patch_baseline
    baseline_desc       = "RedHat Server Patch Baseline"
    patch_group_name    = "redhat-nonprod"
    maint_window_name   = "redhat-NonProd"
    maint_window_desc   = "RedHat NonProd EC2 Patching Window"
    maint_window_sched  = "cron(0 19 ? * 3#2 *)"
}

module "linux_prod_patch_deployment" {
    source              = "./modules/patch_deployment"
    patch_baseline_id   = module.linux_patch_baseline.patch_baseline
    baseline_desc       = "RedHat Server Patch Baseline"
    patch_group_name    = "redhat-prod"
    maint_window_name   = "redhat-Prod"
    maint_window_desc   = "RedHat Prod EC2 Patching Window"
    maint_window_sched  = "cron(0 19 ? * 3#3 *)"
}