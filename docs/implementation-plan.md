# Implementation Plan & Module Architecture

## 1. Terraform Module Architecture
The infrastructure is composed of small, single-purpose, highly reusable Terraform modules located in `/modules/`.
- **Core:** `resource_group`, `virtual_network`, `subnet`, `vnet_peering`.
- **Security:** `nsg`, `route_table`, `key_vault`, `managed_identity`, `rbac`.
- **Monitoring & Backup:** `log_analytics`, `azure_monitor`, `diagnostic_settings`, `recovery_services_vault`, `vm_backup_policy`.
- **Workloads:** `bastion`, `application_gateway`, `linux_vm`, `windows_vm`.

## 2. Terraform Remote State
State files are isolated per environment to prevent blast radius impact:
- Stored remotely in Azure Blob Storage.
- Configured via backend parameters dynamically supplied via ADO pipelines during `terraform init`.
- Uses Azure Table Storage natively for state locking.
