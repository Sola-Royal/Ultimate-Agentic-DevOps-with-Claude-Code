---
name: project-terraform-baseline
description: Baseline state of terraform/ infra as of first security audit (2026-07-10) - what exists and what is intentionally deferred
metadata:
  type: project
---

As of 2026-07-10, `terraform/` (main.tf, providers.tf, variables.tf, outputs.tf, backend.tf) provisions only:
S3 bucket (private, public access block, bucket policy scoped to CloudFront via OAC + SourceArn condition) and a CloudFront
distribution (OAC, redirect-to-https, CachingOptimized managed policy). No IAM roles, no OIDC provider, no GitHub Actions
workflow files exist in the repo yet, despite CLAUDE.md stating deployment is "automated via GitHub Actions."
`backend.tf` remote S3 state backend is deliberately commented out pending a manual bootstrap step (create state bucket +
DynamoDB lock table outside Terraform first, per instructions in the file itself) — this is a known/intentional
chicken-and-egg gap, not an oversight.

Known gaps identified in the first audit (still open as of 2026-07-10):
- No S3 server-side encryption, versioning, or access logging resources.
- No CloudFront access logging, no response-headers-policy (CSP/X-Frame-Options/HSTS missing), no WAF.
- No IAM/OIDC role defined anywhere for CI/CD — GitHub Actions deployment mechanism is unimplemented/unknown.
- `variable "domain_name"` declared but unused (no aliases/ACM cert wired into the CloudFront distribution).
- S3 bucket name embeds the raw AWS account ID (`data.aws_caller_identity.current.account_id`) as a naming convention.

**Why:** Captured so future audits don't re-discover the same gaps from scratch, and so "IAM/OIDC missing" or
"backend.tf disabled" aren't flagged as new regressions if they were already known limitations — check git log/current
files first to confirm whether a gap has since been addressed before treating it as newly introduced.
**How to apply:** When re-auditing, diff current terraform/ state against this list. If IAM/OIDC or a GitHub Actions
workflow has since been added, verify it against the checklist (scoped trust policy per repo/branch, least-privilege
policy, no wildcards) rather than assuming it's still absent.
