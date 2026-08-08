# Rollback Plan

## 1. Rollback Process
Terraform is a declarative tool. To roll back an infrastructure change:
1. **Revert the Git Commit:** Use `git revert <commit-hash>` on the `main` branch to revert the `.tf` files to their previous known-good state.
2. **Trigger CI/CD:** Create a PR. The CI pipeline will generate a plan showing the resources being destroyed/modified back to their old state.
3. **Approve the Revert Plan:** Once merged to `main`, the CD pipeline will execute the rollback via standard `terraform apply tfplan` progression through Dev, UAT, and Prod.

*Do not manually modify state or delete resources in the Azure Portal, as this causes state drift.*
