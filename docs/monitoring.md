# Monitoring & Cost

## 1. Log Analytics & Azure Monitor
- **Log Analytics Workspace (LAW):** A central repository for logs and metrics.
- **Diagnostic Settings:** Automatically deployed to route diagnostic data from Key Vault, App Gateway, and VMs to the central LAW.
- **Azure Monitor:** An Action Group is configured to alert the `Admin` email on critical threshold breaches.

## 2. Infracost
Integrated directly into `terraform-ci.yml`. It parses the Terraform plan, identifies cost implications of the proposed changes, and outputs an HTML artifact. This allows the team to review financial impacts *before* approving a Pull Request.
