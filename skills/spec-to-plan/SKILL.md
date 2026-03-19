---
name: spec-to-plan
description: Use when a non-trivial task has a written spec and needs conversion into an implementation plan before coding. Trigger for plan breakdown, milestones, acceptance criteria, validation commands, risks, rollback notes, and stop conditions. Do not use for direct implementation except explicit re-planning. This skill is single-purpose: planning only.
---

# Purpose
Transform written intent into executable Plan.md.

## Output schema
Plan.md must include: Goal, Non-goals, Hard constraints, Done-when criteria, Must-not-change invariants, Milestones, Exception triggers, Architecture notes, Decision log, Approval.

## Rules
- milestones independently verifiable
- high-risk assumptions validated early
- no implementation code
