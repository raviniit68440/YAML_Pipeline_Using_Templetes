# Security Operations

## 1. Key Vault & Managed Identity
- **Managed Identity:** All VMs and PaaS services use System/User Assigned Managed Identities. No Service Principal credentials are hardcoded.
- **Key Vault:** Configured with `rbac_authorization_enabled = true`. Secrets (like generated VM passwords) are pushed to the Vault dynamically during deployment.

## 2. RBAC (Role-Based Access Control)
Least privilege is enforced via the `rbac` module. For example, the application Managed Identity is explicitly granted the `Key Vault Secrets User` role to read its required secrets.

## 3. GitLeaks & tfsec
- **GitLeaks:** Integrated into the CI pipeline to scan the codebase for hardcoded passwords, tokens, or SSH keys. The build fails immediately if any are found.
- **tfsec:** Scans Terraform configurations for security misconfigurations (e.g., public IPs on VMs, open NSGs).

## 4. Security Considerations
- VMs strictly lack Public IPs.
- Access is gated via Azure Bastion.
- Application Gateway acts as a WAF to drop malicious payloads.
