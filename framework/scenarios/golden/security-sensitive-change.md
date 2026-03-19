# Scenario: security-sensitive-change

## trigger
Changes touch auth/secrets/network/permissions.

## expected_mode
Harden

## expected_flow
- delivery-orchestrator
- spec-to-plan
- checkpoint-review
- security-baseline
- milestone-autopilot
- drift-audit
