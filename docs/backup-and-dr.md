# Backup & Disaster Recovery

## 1. Backup Architecture
- **Recovery Services Vault (RSV):** A centralized vault deployed per environment to manage backups.
- **VM Backup Policy:** Defined via Terraform to back up VMs daily at 23:00 UTC with a 14-day retention. The policy is dynamically attached to the Linux and Windows VMs via `azurerm_backup_protected_vm`.

## 2. Disaster Recovery Considerations
- Infrastructure is defined as code. In a region loss event, the `location` variable can be changed, and the entire Landing Zone can be redeployed to a secondary region (e.g., `westus`) within minutes.
- Note: Stateful data (Storage, DBs) requires geo-replication settings which should be added to specific stateful modules if multi-region DR is required.
