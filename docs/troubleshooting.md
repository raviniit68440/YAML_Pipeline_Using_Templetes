# Troubleshooting Guide

### 1. Terraform State Lock Issues
- **Error:** `Error acquiring the state lock`
- **Resolution:** If a pipeline fails mid-run, the lease on the Blob storage state file might remain active. Use `terraform force-unlock <LOCK_ID>` or break the lease manually in the Azure Portal (Storage Account -> Container -> tfstate -> Break Lease).

### 2. AADSTS700082 Expired Token
- **Error:** `The refresh token has expired due to inactivity.`
- **Resolution:** Your Azure CLI session has expired. Re-authenticate by running `az login`.

### 3. GitLeaks Pipeline Failure
- **Error:** `gitleaks detect --source .` exits with code 1.
- **Resolution:** A secret was committed. You must remove the secret, rotate the compromised credential in Azure, and force-push the amended commit.

### 4. TF Plan/Apply Mismatch
- **Error:** `Saved plan is stale` during CD apply.
- **Resolution:** Someone modified the infrastructure outside of Terraform between the Plan and Apply stages. Re-trigger the pipeline from `main` to generate a fresh plan.
