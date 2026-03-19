---
name: project-init
description: Use when initializing or maturing a repository for my agentic workflow. Trigger when a repo is new, lightly scaffolded, or ready to codify project-local rails. This skill should inspect the repo, decide whether a repo-local AGENTS.md is warranted yet, and create the durable task-memory system under docs/agentic/. Do not use for normal feature implementation. This skill is single-purpose: repository bootstrap rails only.
---

# Purpose
Bootstrap durable task-memory rails with maturity-aware behavior.

## Modes
- plan-only (default)
- apply

## Classify
- empty
- lightly scaffolded
- structured

## Create
- docs/agentic/README.md
- docs/agentic/templates/{Spec,Plan,Implement,Documentation,Decision}.template.md
