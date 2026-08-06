---
title: "Platform Implementation Profile — SPARK Ada Flight Software"
project: "Digital Engineering Agentic Pipeline (DEAP)"
platform: spark_ada
tier: technical_execution
target_standards:
  - "RTCA DO-178C (DAL A)"
  - "RTCA DO-254 (DAL A)"
  - "SPARK 2014 / Ada 2012"
---

# SPARK Ada Implementation Profile

This profile defines technical execution rules for DO-178C DAL A flight software written in SPARK Ada 2014.

## 1. Static Verification & Formal Proof
- All subprograms MUST be annotated with SPARK 2014 contracts (`Global`, `Depends`, `Pre`, `Post`).
- Formal proof using `GNATprove` MUST pass with zero unproved checks at mode `silver` or higher.
- `pragma SPARK_Mode (On)` MUST be present at the package level.

## 2. Memory & Structural Directives
- **Zero Dynamic Heap Allocation:** `pragma Restrictions (No_Implicit_Heap_Allocations)` and `pragma Restrictions (No_Allocators)` are mandatory.
- **Bounded Loops:** All loops MUST have verifiable upper iteration bounds (`pragma Loop_Invariant`).
- **No Recursion:** `pragma Restrictions (No_Recursion)` is mandatory.

## 3. Structural Coverage
- **DAL A Verification:** 100% Modified Condition/Decision Coverage (MC/DC) MUST be achieved via GNATcoverage without dead code or unverified branches.
- Every safety-critical routine MUST carry the `/// Safety-Realises:` tag linking to the corresponding System Safety Constraint.
