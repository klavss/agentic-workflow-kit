# Scenario: release-candidate

## trigger
Production release intent with user-facing impact.

## expected_mode
Release

## expected_flow
- delivery-orchestrator
- checkpoint-review
- release-gate
- milestone-scorecard
- drift-audit
