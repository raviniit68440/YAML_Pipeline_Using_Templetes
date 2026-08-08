# Deployment Guide & Azure DevOps CI/CD

## 1. Azure DevOps CI/CD Pipeline
The deployment relies on native Azure DevOps YAML pipelines:
- `terraform-ci.yml`: Triggers on pull requests. Runs `fmt`, `validate`, security scans (GitLeaks, tfsec), cost estimation (Infracost), and generates a `tfplan`.
- `terraform-cd.yml`: Triggers on merges to `main`. Orchestrates environment deployments.

## 2. Deployment Process
Deployments follow a linear progression: **Dev -> UAT -> Prod**.
For each environment:
1. `terraform plan -out=tfplan` is executed and published as an artifact.
2. The exact `tfplan` artifact is downloaded by the Apply stage.
3. `terraform apply tfplan` is executed. **No new plan is generated during the apply stage.**

## 3. Approval Process
- **Dev:** Deploys automatically.
- **UAT & Prod:** Mapped to Azure DevOps Environments (`UAT` and `Production`). The apply job will pause and require a human approver to review the Plan artifact before proceeding.

### Production Readiness Checklist
- [ ] All TF configurations formatted (`terraform fmt`).
- [ ] `terraform validate` passes locally.
- [ ] GitLeaks reports zero exposed secrets.
- [ ] Infracost report reviewed and budget approved.
- [ ] Azure DevOps Environment approvers assigned.
