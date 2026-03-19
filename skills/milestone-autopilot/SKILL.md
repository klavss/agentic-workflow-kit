---
name: milestone-autopilot
description: Use only after Plan.md is reviewed and approved to execute milestones sequentially with verification, review, drift checks, docs updates, and checkpoint commits. Trigger for carrying out approved plans with minimal supervision. Do not use before planning gates are complete. This skill is single-purpose: milestone execution only.
---

# Purpose
Execute one approved milestone at a time.

## Loop
1. implement current milestone only
2. run verification
3. run checkpoint-review
4. run drift-audit
5. update docs/status
6. checkpoint commit if validation passed
7. continue only if no exception trigger
