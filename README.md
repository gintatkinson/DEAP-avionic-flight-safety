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

### 5.1 Automated Turnkey Installation Command

Run the turnkey automated installer directly inside your cloned project repository root:

```bash
git clone https://github.com/gintatkinson/DEAP-avionic-flight-safety.git
cd DEAP-avionic-flight-safety
curl -sSL https://raw.githubusercontent.com/gintatkinson/digital-pipeline-repo/main/scripts/install_pipeline.sh | bash
```

> **Note**: `install_pipeline.sh` automatically provisions `.venv`, installs Python dependencies, injects pipeline governance engine tooling, configures process discipline git hooks, bootstraps tracker labels, executes safety test verification (`pytest`), and compiles MBSE SysML v2 safety models in a single automated turnkey step.

### 5.2 Mandatory Post-Install Agent Initialization & Skill Loading Sequence

Immediately following turnkey installation, any AI agent (Antigravity, Claude Code, Gemini CLI, Cursor) initializing in this repository MUST execute the following 5-step sequence before accepting user directives or executing task implementations:

1. **Read Governance Constitution**: Execute `view_file` on `.pipeline/constitution.md` to ingest the platform-independent functional governance layer and zero-mocking persistence mandates.
2. **Load Project Skills**: Execute `view_file` on `.agents/skills/feature-driven-implementation/SKILL.md` (and any active skills under `.agents/skills/`) to initialize feature-driven implementation protocols and review gates.
3. **Load Governance Rules**: Ingest `.agents/AGENTS.md` to enforce project-scoped agentic rules, context-isolated subagent dispatch loops, and role boundary locks.
4. **Load Platform Profile**: Read the target platform execution profile (`.pipeline/profiles/spark_ada.md` for SPARK Ada 2014 or `.pipeline/profiles/embedded_c.md` for MISRA-C / ARINC 653) to establish platform-specific build, test, and lifecycle constraints.
5. **Bootstrap Tracker Labels**: Verify that repository issue tracker labels are synchronized and operational by running `python3 scripts/reconcile_backlog.py` or verifying label bootstrapping status.

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

### 6.3 Pipeline 0 Command-Line Execution Prompts

To execute Pipeline 0 via context-isolated subagents in your AI agent environment (Antigravity, Claude Code, Gemini CLI, Cursor), copy and execute the following standardized command-line execution prompts in sequence:

#### 6.3.1 Worker 0A: CONOPS & Avionic Mission Envelope Prompt

```text
Role: Worker 0A — CONOPS & Avionic Mission Envelope Synthesizer

Primary Commercial Toolchain Integration Context:
This project explicitly declares MATLAB / Simulink / Stateflow / Embedded Coder as the Primary Tier-1 Commercial Toolchain Integration Context (Model-Based Design, Control Law Synthesis, DO-178C C/SPARK Ada code generation).

Directive:
Execute front-end CONOPS synthesis for the target civil airborne flight control system. Convert raw operational scenarios and airworthiness constraints into a structured Concept of Operations (`CONOPS.md`).

1. Inputs & Constraints:
   - Ingest civil aviation flight envelope boundaries (altitude, airspeed limits, flight phases: taxi, takeoff, climb, cruise, descent, approach, landing).
   - Define system physical and functional boundaries for flight control computer (FCC), autopilot actuators, and flight deck displays.
   - Perform initial system hazard identification per SAE ARP4754A / ARP4761 guidelines.

2. Output Requirement:
   - Generate `CONOPS.md` under `docs/conops/CONOPS.md`.
   - Include operational phase boundaries, mission failure bounds, and top-level safety objectives.
   - Establish baseline integration hooks for MATLAB / Simulink / Stateflow control law synthesis.

PROCEED
```

#### 6.3.2 Worker 0B: STPA, FMECA & Airworthiness DAL Allocation Assurer Prompt

```text
Role: Worker 0B — STPA, FMECA & Airworthiness DAL Allocation Assurer

Primary Commercial Toolchain Integration Context:
This project explicitly declares MATLAB / Simulink / Stateflow / Embedded Coder as the Primary Tier-1 Commercial Toolchain Integration Context (Model-Based Design, Control Law Synthesis, DO-178C C/SPARK Ada code generation).

Directive:
Perform STPA hazard analysis, FMECA failure mode criticality evaluation, and RTCA DO-178C / DO-254 DAL allocation (DAL A–E) based on `docs/conops/CONOPS.md`.

1. Standards Compliance:
   - RTCA DO-178C (Software Considerations in Airborne Systems, DAL A 100% MC/DC coverage).
   - RTCA DO-254 (Design Assurance for Airborne Electronic Hardware, DAL A Hardware).
   - SAE ARP4754A / ARP4761 (Aircraft Systems Safety Assessment, STPA & FMECA).

2. Output Requirements:
   - Generate `STPA_MATRIX.md` under `docs/safety/STPA_MATRIX.md` containing System Losses ($L-1..N$), System Hazards ($H-1..N$), Control Structure topology, Unsafe Control Actions ($UCA-1..N$), Loss Scenarios ($LS-1..N$), and Safety Constraints ($SC-1..N$).
   - Formulate FMECA Matrix detailing component failure modes, local/end effects, single-point failures, detection mechanisms, and Risk Priority Numbers (RPN).
   - Allocate DO-178C / DO-254 Design Assurance Levels (DAL A–E) to all software and hardware components based on hazard severity (Catastrophic, Severe-Major, Major, Minor, No Safety Effect).

PROCEED
```

#### 6.3.3 Worker 0C: SysML v2 Safety Modeling & Model-Based Design Integration Prompt

```text
Role: Worker 0C — SysML v2 Safety Modeling & Model-Based Design Integration Author

Primary Commercial Toolchain Integration Context:
This project explicitly declares MATLAB / Simulink / Stateflow / Embedded Coder as the Primary Tier-1 Commercial Toolchain Integration Context (Model-Based Design, Control Law Synthesis, DO-178C C/SPARK Ada code generation).

Directive:
Formalize the CONOPS (`CONOPS.md`), STPA hazard matrices, FMECA ratings, and DO-178C / DO-254 DAL allocations (`STPA_MATRIX.md`) into a normative SysML v2 textual model and serialized AST handoff contract.

1. Model Engineering Mandate:
   - Construct `DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.sysml` conforming to SysML v2 textual specification standards (`package`, `req`, `part`, `port`, `state`, `satisfy`, `verify`).
   - Define safety statecharts for fault mitigation, autopilot engagement/disengagement, and run-time safety monitors.
   - Synthesize MATLAB / Simulink / Stateflow export specifications for auto-generated SPARK Ada 2014 and MISRA-C:2012 / ARINC 653 code synthesis.

2. Output Requirements:
   - Generate `DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.sysml` under `docs/architecture/blueprints/DEAP_SYSML_V2_SAFETY_MODEL_SPECIFICATION.sysml`.
   - Generate `pipeline0_handoff_contract.json` under `.pipeline/contracts/pipeline0_handoff_contract.json` containing serialized AST payloads for downstream Pipeline 1 Agile projection and Pipeline 2 code synthesis.

PROCEED
```

---

## 7. License & Governance

Governed under the **Digital Engineering Agentic Pipeline (DEAP)** specification framework. All safety claims and traceability tags are mechanically validated on commit.

