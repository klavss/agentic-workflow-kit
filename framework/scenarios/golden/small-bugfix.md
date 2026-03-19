# Scenario: small-bugfix

## trigger
Single-file, low-risk change.

## expected_mode
Explore or Build-light

## expected_flow
- delivery-orchestrator
- optional spec-to-plan (if still non-trivial)
- checkpoint-review (light)
- drift-audit (light)

## expected_stop_triggers
None by default.
