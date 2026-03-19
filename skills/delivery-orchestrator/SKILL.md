---
name: delivery-orchestrator
description: Default coordinator for non-trivial coding tasks. Trigger when requests involve multi-step planning, implementation, review, validation, documentation, or milestone progression. Do not use for trivial one-step tasks or pure informational Q&A. This skill is single-purpose: route and gate workflow, not implement product changes directly.
---

# Purpose
Route work to the right skills with deterministic gates and mode-aware controls.

## Modes
- Explore
- Build (default)
- Harden
- Release

## Routing (non-trivial default)
1. spec-to-plan
2. checkpoint-review (plan gate)
3. explicit approval check
4. milestone-autopilot
5. drift-audit

## Conditional routing
- initiative-index
- milestone-scorecard
- security-baseline
- dependency-governance
- release-gate
- framework-governance

## Output contract
Always include: mode, phase, gate status, confidence, evidence, unknowns, next check.
