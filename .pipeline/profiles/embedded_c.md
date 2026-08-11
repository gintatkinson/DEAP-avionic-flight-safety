---
title: "Platform Implementation Profile — Embedded MISRA-C / ARINC 653 Flight Software"
project: "Digital Engineering Agent Platform (DEAP)"
platform: embedded_c
tier: technical_execution
target_standards:
  - "RTCA DO-178C (DAL A/B)"
  - "MISRA-C:2012"
  - "ARINC 653 APEX"
---

# Embedded C Implementation Profile

This profile defines technical execution rules for DO-178C DAL A/B flight software implemented in C99/C11 following MISRA-C guidelines.

## 1. MISRA-C Compliance
- All code MUST adhere strictly to MISRA-C:2012 Mandatory and Required rules.
- Static analysis checks via Clang-Tidy / Cppcheck MUST produce zero violations.
- Pointer arithmetic and direct type casting of arbitrary pointers are strictly prohibited.

## 2. Partitioning & Memory Directives
- **ARINC 653 Partition Scheduling:** Code execution is strictly partitioned into deterministic time slices (minor/major frames).
- **Zero Dynamic Memory:** `malloc()`, `free()`, `calloc()`, `realloc()` are strictly forbidden. All state structures MUST be statically allocated at compile time.
- Static analysis MUST enforce stack depth boundaries for every thread/partition.

## 3. Structural Traceability & Coverage
- Mandatory 100% Statement and Decision coverage (MC/DC for DAL A).
- Every exported C function header MUST include `/// Safety-Realises: [SC-NN / Hazard-ID]` annotations.
