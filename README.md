# Digital Engineering Agentic Pipeline (DEAP) — Civil Avionic Flight Safety Platform

> **Repository Identifier:** `DEAP-avionic-flight-safety`  
> **Status:** `PRODUCTION-GRADE / ACTIVE`  
> **Classification:** `Civil Avionic Flight Safety & High-Integrity Airborne Systems Platform`  
> **Target Regulatory Frameworks:** `RTCA DO-178C (DAL A–E)` | `RTCA DO-254 (DAL A–E)` | `SAE ARP4754A` | `SAE ARP4761`  
> **Primary Technology Profiles:** `SPARK Ada 2014` | `MISRA-C:2012 / ARINC 653`  

---

## 1. System Overview

The **DEAP Civil Avionic Flight Safety Platform** (`DEAP-avionic-flight-safety`) is a standalone downstream domain platform built on the Digital Engineering Agentic Pipeline (DEAP) architecture. It provides an end-to-end model-based systems engineering (MBSE) and automated safety assurance environment for civil airborne flight control computers (FCC), autopilot systems, and safety-critical avionics.

By unifying System-Theoretic Process Analysis (STPA) with Failure Mode, Effects, and Criticality Analysis (FMECA), this platform enforces strict airworthiness standards down to source code ASTs, hardware register maps, and unit test execution gates.

---

## 1.1 Primary Commercial Toolchain Integration

This platform explicitly declares **MATLAB / Simulink / Stateflow / Embedded Coder** as the Primary Tier-1 Commercial Toolchain Integration (Model-Based Design, Control Law Synthesis, DO-178C C/SPARK Ada Code Generation).

---

## 2. Supported Regulatory & Airworthiness Frameworks

| Standard | Domain & Scope | Target Assurance | DEAP Mechanical Automation |
| :--- | :--- | :--- | :--- |
| **RTCA DO-178C** | Software Considerations in Airborne Systems | DAL A (Catastrophic) to DAL E | Enforces 100% MC/DC coverage, zero dynamic heap allocation, bounded loop bounds, `/// Safety-Realises:` tags. |
| **RTCA DO-254** | Design Assurance for Airborne Electronic Hardware | DAL A Hardware | Validates FPGA fixed-point register bounds (Q16.16), bus babbling timers, and pinout constraints. |
| **SAE ARP4754A** | Guidelines for Development of Civil Aircraft and Systems | Aircraft / System FHA & SSA | Automates functional hazard identification and safety requirement decomposition into backlog Epics & Features. |
| **SAE ARP4761** | Guidelines and Methods for Conducting Safety Assessment | STPA & FMECA Worksheets | Generates formal BDD User Stories and Use Case Realization Matrices linking hazards to source code symbols. |

---

## 3. Platform Technology Profiles

### 3.1 SPARK Ada Profile (`.pipeline/profiles/spark_ada.md`)
- **Language Standard:** SPARK 2014 / Ada 2012
- **Formal Proof:** GNATprove flow analysis and theorem proving (Silver/Gold/Platinum assurance)
- **Memory Safety:** Zero dynamic heap allocation (`pragma Restrictions (No_Implicit_Heap_Allocations)`)
- **Structural Coverage:** 100% MC/DC coverage verified via GNATcoverage

### 3.2 Embedded C Profile (`.pipeline/profiles/embedded_c.md`)
- **Language Standard:** ISO C99 / C11 with MISRA-C:2012 Compliance
- **OS / Partitioning:** ARINC 653 APEX partition scheduling
- **Memory Rules:** Static stack frame allocation only (`malloc`/`free` strictly forbidden)
- **Static Analysis:** Cppcheck / Clang-Tidy MISRA enforcement gates

---

## 4. Repository Structure & Canonical Specifications

All architecture blueprints, concept papers, SysML v2 models, and specifications for DEAP are hosted centrally in the Single Source of Truth repository: **[DEAP-spec-core](https://github.com/gintatkinson/DEAP-spec-core)**.

### Canonical Specifications (hosted in `DEAP-spec-core`):
- **Civil Avionic Safety Concept Paper**: [DEAP_FLIGHT_SYSTEMS_SAFETY_CONCEPT_PAPER.md](https://github.com/gintatkinson/DEAP-spec-core/blob/main/docs/architecture/blueprints/DEAP_FLIGHT_SYSTEMS_SAFETY_CONCEPT_PAPER.md)
- **SysML v2 Textual Safety Model**: [DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.sysml](https://github.com/gintatkinson/DEAP-spec-core/blob/main/docs/architecture/blueprints/DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.sysml)
- **SysML v2 MATLAB Export Blueprint**: [DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.md](https://github.com/gintatkinson/DEAP-spec-core/blob/main/docs/architecture/blueprints/DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.md)
- **Safety-Critical Real-Time UI Framework**: [SAFETY_CRITICAL_REALTIME_UI_FRAMEWORK.md](https://github.com/gintatkinson/DEAP-spec-core/blob/main/docs/architecture/blueprints/SAFETY_CRITICAL_REALTIME_UI_FRAMEWORK.md)
- **Master Specification Sitemap**: [DEAP_SPECIFICATIONS_SITEMAP.md](https://github.com/gintatkinson/DEAP-spec-core/blob/main/docs/architecture/DEAP_SPECIFICATIONS_SITEMAP.md)

### Repository Tree:
```
DEAP-avionic-flight-safety/
├── .agents/
│   └── AGENTS.md                  # Project-scoped agentic governance rules & delegation gates
├── .pipeline/
│   ├── constitution.md            # Platform-independent functional safety governance tier
│   └── profiles/
│       ├── spark_ada.md           # SPARK Ada 2014 platform execution profile
│       └── embedded_c.md          # MISRA-C / ARINC 653 platform execution profile
├── tests/
│   └── test_avionic_safety_governance.py   # Automated safety compliance & MBSE test suite
├── pyproject.toml                 # Pytest & verification configuration
└── README.md                      # Platform master specification & usage guide
```

---

## 5. Installation & Developer Quick-Start Guide

### 5.1 Step 1: Repository Clone
```bash
git clone https://github.com/gintatkinson/DEAP-avionic-flight-safety.git
cd DEAP-avionic-flight-safety
```

### 5.2 Step 2: Virtual Environment Setup
```bash
python3.12 -m venv .venv
source .venv/bin/activate
pip install -r pyproject.toml
```

### 5.3 Step 3: DEAP Pipeline Tooling & Governance Engine Installation
```bash
curl -sSL https://raw.githubusercontent.com/gintatkinson/digital-pipeline-repo/main/scripts/install_pipeline.sh | bash
```

### 5.4 Step 4: Automated Safety Governance Verification
```bash
python3 -m pytest tests/
```

### 5.5 Step 5: MBSE SysML v2 Model Compilation & Parsing
```bash
python3 compile_sysml.py docs/architecture/blueprints/DEAP_AVIONIC_SAFETY_MODEL.sysml
```

---

## 6. Pipeline 0: Pre-Spec Safety Engineering Execution Workflow

Pipeline 0 executes pre-specification safety engineering, transforming high-level operational concepts into formal safety models and allocation baselines prior to functional specification engineering. The workflow leverages context-isolated worker subagents operating under strict DO-178C / DO-254 / ARP4754A / ARP4761 airworthiness mandates.

### 6.1 Subagent Execution Roles

#### Worker 0A: CONOPS Engineering & Hazard Identification
- **Role:** `Pipeline 0A CONOPS Worker`
- **Scope:** 
  - Formulates Concept of Operations (CONOPS), defining flight envelopes, operational phases (taxi, takeoff, climb, cruise, descent, approach, landing), and mission failure bounds.
  - Performs initial system hazard identification per SAE ARP4754A / ARP4761 guidelines.
  - Derives top-level safety objectives and airworthiness constraints linking operational scenarios to system-level safety targets.

#### Worker 0B: STPA, FMECA & Airworthiness DAL Allocation
- **Role:** `Pipeline 0B Safety Analysis Worker`
- **Scope:**
  - **STPA (System-Theoretic Process Analysis):** Constructs hierarchical control structure models, identifies Losses (L), Hazards (H), System Safety Constraints (SSC), and Unsafe Control Actions (UCAs) across flight control states.
  - **FMECA (Failure Mode, Effects, and Criticality Analysis):** Tabulates item failure modes, local/end effects, failure detection mechanisms, single-point failure risks, and severity/criticality classifications.
  - **DO-178C / DO-254 DAL Allocation:** Assigns Design Assurance Levels (DAL A through DAL E) to software and hardware items based on hazard severity (Catastrophic, Hazardous/Severe-Major, Major, Minor, No Safety Effect).
  - **Verification Coverage Gates:** Mandates 100% MC/DC coverage for DAL A, Decision Coverage for DAL B, and Statement Coverage for DAL C software items, verified against SPARK Ada / Embedded C platform profiles.

#### Worker 0C: SysML v2 Safety Modeling & Model-Based Design Integration
- **Role:** `Pipeline 0C SysML v2 Safety Modeling Worker`
- **Scope:**
  - Authors formal SysML v2 textual safety models (`.sysml`), defining system block definitions, interface ports, safety constraint blocks, and requirement relationships (`satisfy`, `verify`, `refine`).
  - Synthesizes safety model exports targeting the **Primary Tier-1 Commercial Toolchain Context** (**MATLAB / Simulink / Stateflow / Embedded Coder**).
  - Establishes bi-directional traceability between SysML v2 safety requirements, Simulink control law models, Stateflow fault statecharts, and auto-generated C / SPARK Ada source code ASTs.

---

## 7. License & Governance

Governed under the **Digital Engineering Agentic Pipeline (DEAP)** specification framework. All safety claims and traceability tags are mechanically validated on commit.

