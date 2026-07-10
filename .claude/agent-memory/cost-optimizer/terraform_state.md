---
name: terraform_state
description: Terraform backend currently commented out; uses local state; S3 backend has lifecycle policy opportunity
metadata:
  type: project
---

**Current State**: Backend block in terraform/backend.tf is commented out. Infrastructure uses local state (terraform.tfstate in working directory).

**Issues**:
- Local state not suitable for team environments or CI/CD
- No version history or backup
- Commented-out backend specifies S3 with versioning enabled

**When Backend is Enabled**: 
The S3 bucket (terraform-state-portfolio-site-production-{account-id}) will have:
- Versioning: enabled (holds all state versions)
- Encryption: enabled (good)
- DynamoDB lock table: required for state locking

**Cost Optimization**: When state bucket is created, implement lifecycle policies:
- Expire non-current versions after 30 days
- Transition old versions to GLACIER for long-term retention
- Set Intelligent-Tiering for version storage

**Estimated Impact**: For a small portfolio project with infrequent state changes, S3 state bucket costs ~$1-5/month. Lifecycle policies save ~30-50% by expiring old versions.
