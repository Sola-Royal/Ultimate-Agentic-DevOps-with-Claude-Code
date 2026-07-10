---
name: s3_storage_class
description: S3 bucket using STANDARD storage class; candidate for INTELLIGENT_TIERING to optimize infrequent access patterns
metadata:
  type: project
---

**Current State**: S3 bucket (portfolio-site-production-{account-id}) has no explicit storage class configured, defaults to STANDARD. Bucket contains static portfolio assets with infrequent access patterns.

**Why**: Static portfolios have variable access patterns - popular pages accessed frequently, older content rarely accessed. STANDARD charges highest per-GB rate; infrequent access tiers are cheaper.

**How to apply**: For workloads with unpredictable access patterns and potential archived content, enable INTELLIGENT_TIERING. AWS automatically moves objects between 4 tiers (Frequent, Infrequent, Archive Instant, Archive Access) based on access patterns. Includes small per-1000-objects monitoring cost (~$0.0025/month per 1000 objects) but savings on infrequent tiers typically exceed this.
