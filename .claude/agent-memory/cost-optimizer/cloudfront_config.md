---
name: cloudfront_config
description: CloudFront distribution using PriceClass_200 with default CachingOptimized TTL settings
metadata:
  type: project
---

**Current Configuration**:
- PriceClass_200: Covers North America, Europe, Asia, Australia (98% of global audience coverage)
- Cache Policy: CachingOptimized (AWS managed) with default TTL values
- Compression: Enabled (good)
- OAC Origin Access Control: Configured (good security)

**Observations**: 
- PriceClass_200 is appropriate for global audiences but may be over-provisioned for regional/niche portfolios
- CachingOptimized defaults are conservative to ensure freshness; static portfolio could cache longer
- No explicit TTL overrides configured

**Cost Tier Breakdown**:
- PriceClass_All: ~100% of edge locations, highest cost
- PriceClass_200: ~98% coverage, ~20-30% cheaper than All
- PriceClass_100: North America + Europe only, ~30% cheaper than 200
