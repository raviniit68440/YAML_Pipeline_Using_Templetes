# Branching Strategy

The repository follows a Trunk-Based Development model optimized for Terraform:
1. **feature/*** branches: Used for active development. Pushing here triggers the CI pipeline (Plan only).
2. **trunk / development:** (Optional intermediate integration branch).
3. **main:** The single source of truth. Merging to `main` triggers the CD pipeline to execute deployments across Dev, UAT, and Prod environments sequentially.

Pull Requests are strictly enforced to merge into `main`.
