---
name: cache_ttl
description: CloudFront cache behavior using CachingOptimized managed policy with default TTLs
metadata:
  type: project
---

**Current State**: Using AWS managed policy `CachingOptimized` (658327ea-f89d-4fab-a63d-7e88639e58f6) which provides:
- Default TTL: 1 day (86400 seconds)
- Max TTL: 1 year (31536000 seconds)
- Honors Cache-Control headers from origin
- No explicit min/max overrides in config

**Portfolio Context**: Static HTML/CSS with no dynamic content - perfect candidate for longer TTL. Assets rarely change, and when they do, cache invalidation via CloudFront can be triggered.

**Cost Impact**: Each cache miss = origin request to S3 = data transfer cost + S3 request charge. Longer TTL = fewer origin requests = lower costs, especially during traffic spikes.

**Recommendation**: For static portfolio with infrequent updates, increase default TTL to 30-90 days. Use cache invalidation after deployments rather than relying on natural expiration.
