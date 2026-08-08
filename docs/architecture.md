# Azure Landing Zone Architecture

## 1. Landing Zone & Hub-Spoke Architecture
This project utilizes a Hub-and-Spoke network topology:
- **Hub VNet:** Acts as the central point of connectivity. Contains shared services like Azure Bastion and Application Gateway.
- **Spoke VNets:** Provide workload isolation. Each environment (Dev, UAT, Prod) resides in its own isolated Spoke VNet peered securely to the Hub.

## 2. Dev / UAT / Prod Strategy
The environments are strictly separated at the VNet and Resource Group level. The Terraform configuration utilizes a directory-based separation (`environments/dev`, `environments/uat`, `environments/prod`) invoking the same reusable modules to guarantee parity across stages.

## 3. Azure Bastion
Azure Bastion is deployed in the `AzureBastionSubnet` within the Hub VNet. It provides secure and seamless RDP/SSH connectivity to all Spoke VMs directly from the Azure portal over TLS, without exposing public IP addresses on the VMs.

## 4. Application Gateway WAF v2
An Application Gateway is deployed in a dedicated `snet-appgw` subnet in the Hub VNet. It serves as a central ingress point for HTTP/HTTPS traffic, providing layer 7 load balancing, SSL termination, and a Web Application Firewall (WAF) using OWASP 3.2 rules to protect Spoke VMs from common exploits.

## 5. Linux / Windows VM Architecture
VMs are deployed in the Spoke VNets (`snet-web` or `snet-app`). 
- They do **not** have Public IPs.
- They are connected to the Application Gateway Backend Pool.
- They utilize Managed OS Disks, System Assigned Managed Identities, and rely on Key Vault for dynamically generated secure passwords.

---
## Checklists

### Prerequisites Checklist
- [ ] Azure Subscription active.
- [ ] Service Principal created with `Contributor`, `RBAC Administrator`, and `Key Vault Secrets Officer`.
- [ ] Azure DevOps Service Connection `Azure-ARM-Service-Connection` created.
- [ ] ADO Variable Group `landing-zone-vars` created (with `infracostApiKey`).
- [ ] Remote state Storage Account and Container provisioned.

### Implementation Checklist
- [ ] Bootstrap TF state storage.
- [ ] Assign RBAC roles to DevOps SPN.
- [ ] Configure Branch Policies in Azure Repos/GitHub.
- [ ] Create `UAT` and `Production` ADO Environments with Approvals.
- [ ] Trigger first run on `feature/*` branch.
