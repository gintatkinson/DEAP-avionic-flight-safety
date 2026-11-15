# Project-Scoped Rules

## Upstream Provenance & Downstream Consumer Perimeter Classification
- **Upstream Specification Core Baseline**: `gintatkinson/deap03@e75d23d412fa88f5ecc9683c0615c3303d43bf00` (`stage-10-complete`), compiled with Ferrocene `stable-26.08.0` pinned via `criticalup.toml`.
- **Cryptographic Release Attestation**: Signed `0x60` RFC 8785 JCS manifest at `.deap/update-manifest.json` (SHA-256 `1243abcb151f276806ea96b01e77b671e3eed03b4c8e1653fa5bd5baee8b3619`) verified against Tier-2 `Ed25519` public key `VK_REL = 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`.
- **Workspace Perimeter Role (`--perimeter-role downstream-consumer`)**:
  * Zero upstream compiler source directories (`N_up_src == 0`; `crates/deap-*` and upstream `blueprints/*.md` are strictly forbidden).
  * Legacy DEAP01 directories (`.pipeline/`, `rules/`, `skills/`, `.agents/`, `target/release/`) and symlinks are permanently retired and forbidden.
  * Foundation SysML v2 / OMG RAAML v1.0 libraries reside strictly at `schema/lib/ISQ.sysml` and `schema/lib/RAAML.sysml` (`--schema-scope lib-only` in template repositories; `--schema-scope all` in populated customer mission workspaces).
  * Downstream architecture, coding standards, C11 FFI headers, and multi-toolchain synthesis profiles reside under `downstream-profiles/` (`README.md`, `DOWNSTREAM_INSTALLATION_AND_CI_GUIDE.md`, `profile-dart-flutter-hmi/`, `profile-target-app-runtime/`, and `profile-non-rust-targets/`).

## Strict Coordinator Tool Locking & Pre-Action Compliance Rules
Thought blocks MUST focus directly on the user's active request and technical reasoning -- NEVER prefix thought blocks with repetitive initialization or compliance checklists. Before invoking any modifying tool or mutating command, enforce these 4 pre-action locks:
* **Intent Classification**: Distinguish questions/inquiries (read-only response only) from direct modification commands.
* **User Authorization Lock**: Modifying tools and mutating `run_command` invocations are strictly locked unless exact target files and changes are documented in an approved `implementation_plan.md` (stored per-conversation at `<appDataDir>/brain/<conversation-id>/implementation_plan.md`) AND the user explicitly approves (`PROCEED` / `Approved` / `Approve plan`). Writing this conversation's `implementation_plan.md` is the sole permitted pre-approval write.
* **Zero Silent Assumptions**: Surface ambiguities and verify workspace state empirically rather than making silent assumptions.
* **Plan Continuity & Single-Task Anti-Snowballing**: Never abandon or alter an active in-flight plan without user authorization. Each `implementation_plan.md` MUST contain at most 1 atomic work package (backlog queues reside exclusively in the issue tracker; never append new tasks onto completed plans).

## Pure Schema-Driven Compiler Invariant (Zero Hardcoded Domain Concepts)
- **Abstract MBSE Compiler Declaration**: The `deap03` five-binary `B_5` toolchain (`.deap/bin/{ingest-sysml,assemble-conops,compile-sysml,reconcile-backlog,verify-baseline}`) is a formal KerML 1.0 / SysML v2.0 + OMG RAAML v1.0 compiler and independent `DO-330 TQL-5` verification framework.
- **Strict Prohibition of Hardcoded Domain Concepts**: Agents are strictly forbidden from inventing or hardcoding ungrounded domain concepts outside declared `.sysml` AST definitions and curated domain catalogs.
- **Deterministic Schema-Derived Specifications**: All specification projections (ConOps, Mission Intent, STPA/FMECA safety artifacts, `#![no_std]` contracts, Epics, Features, User Stories, Use Cases, WBS) derive deterministically from canonical IR snapshots (`.deap/ir.snapshot.bin`) sealed from `schema/`.

## Domain Distribution Template Clean Landing Zone & Asset Preservation Invariant
- **Clean Landing Zone Mandate**: In upstream domain distribution templates (`DEAP-*`), `docs/epics/`, `docs/features/`, `docs/user-stories/`, and `docs/use-cases/` remain clean landing zones with `.gitkeep`, while `schema/lib/{ISQ,RAAML}.sysml` supplies the normative foundation library set (`--schema-scope lib-only`).
- **Curated Domain Asset Preservation**: Domain catalogs, reference ConOps/Mission Intent exemplars, and primary safety research corpus files (`docs/{catalogs,conops,domain,research}/`) are authoritative domain assets and MUST NOT be truncated or deleted without explicit user authorization.
- **Customer Workspace Boundary**: Concrete customer mission models (`schema/*.sysml`), generated Rust contracts, Simulink `.slx`/`.sldd` models, ROS2/PX4 flight code, and Flutter HMI code (`app_flutter/`) belong in downstream customer project repositories cloned from this template.

## Lazy On-Demand Governance Loading (Zero Per-Turn Initialization Ceremony)
- **Zero Per-Turn Startup Ceremony**: Conversational, diagnostic, and read-only turns execute zero startup ceremony. Agents MUST NEVER halt a user's prompt to emit startup receipt tables.
- **On-Demand Profile Loading**:
  1. Read `downstream-profiles/README.md` and `downstream-profiles/DOWNSTREAM_INSTALLATION_AND_CI_GUIDE.md` when configuring builds, FFI integration, or CI pipelines.
  2. Read `downstream-profiles/profile-dart-flutter-hmi/DART_FLUTTER_CODING_STANDARD.md`, `SAFETY_CRITICAL_REALTIME_UI_BLUEPRINT.md`, and `DART_RUST_FFI_SYNTHESIS_PROFILE.md` ONLY during Flutter/HMI tasks (`app_flutter/`).
  3. Read `downstream-profiles/profile-target-app-runtime/{RUNTIME_METADATA_ENGINE_BLUEPRINT,PERSISTENCE_ARCHITECTURE_BLUEPRINT}.md` ONLY during dynamic metadata or persistence tasks.
  4. Read `downstream-profiles/profile-non-rust-targets/NON_RUST_MULTI_TOOLCHAIN_PROFILES.md` ONLY during MATLAB/Simulink/Stateflow/Embedded Coder, ANSYS SCADE, SPARK Ada, MISRA C/C++, AADL, or FMI target tasks.
  5. Run `.deap/bin/verify-baseline` gates once at the coordinator level prior to commit gates rather than on read-only turns.

## Signed `deap03` Five-Binary (`B_5`) Toolchain & Mandatory Verification Gates
- **Five Canonical Precompiled Executables (`DO-330 TQL-1` & `TQL-5`)**:
  1. `./.deap/bin/ingest-sysml` (`TQL-1`): Deterministic SysML v2 / Markdown / legacy DEAP01 frontend and `.deap/ir.snapshot.bin` sealer (`check`, `seal`, `slice`, `migrate-legacy`).
  2. `./.deap/bin/assemble-conops` (`TQL-1`): Pre-STPA ConOps and METL operational slice assembler (`check`, `project`, `slice`).
  3. `./.deap/bin/compile-sysml` (`TQL-1`): 5-pass safety compiler, ZBDD cut-set analyzer, `#![no_std]` contract synthesizer, and AST docstring injector (`check`, `build`, `supersede-seed`, `inject-docstrings`).
  4. `./.deap/bin/reconcile-backlog` (`TQL-1`): Stage P4/P5/M3.5 Agile/WBS projector and 3-way Merkle tracker reconciler (`project`, `sync`, `tracker`, `slice`, `migrate-defects`).
  5. `./.deap/bin/verify-baseline` (`TQL-5`): Disjoint independent verification oracle, `0x60` manifest verifier, atomic bundle installer, and downstream perimeter gate (`audit`, `hygiene`, `attest`, `verify-manifest`, `install-bundle`, `perimeter`, `setup-hooks`).
- **Mandatory Local Verification Gates Prior to Commit**:
  * Bundle & Signature Parity Gate:
    `./.deap/bin/verify-baseline verify-manifest --workspace . --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`
  * Downstream Perimeter, Zero-Symlink, Pure 7-Bit ASCII & Foundation Lowering Gate:
    `./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope lib-only --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`
- **Retired Tooling**: Legacy `target/release/*` DEAP01 binaries, `.pipeline/*`, `scripts/*.py`, `pytest`, and shell wrapper scripts are permanently retired and MUST NOT be recreated or invoked.

## Mandatory Subagent Dispatch, TDD & Zero-Mocking Persistence Rules
- **Subagent Context Isolation**: Multi-item research, specification elaboration, and feature implementation loops MUST dispatch context-isolated single-item subagents with explicit target file boundaries and 3-layer Definition of Done ((1) Domain State & Data Model, (2) Logic & Safety State Management, (3) Presentation / Middleware / Actuator Interface Binding).
- **Mandatory TDD & Compilation Verification**: Every executable code change requires RED-GREEN-REFACTOR unit/integration tests and a verified clean build (`cargo test`, `flutter analyze && flutter test`, or target platform build) prior to completion.
- **Zero-Mocking Live Persistence**: Client and runtime targets MUST bind to live SQLite/register/telemetry persistence per `PERSISTENCE_ARCHITECTURE_BLUEPRINT.md`; in-memory mocks in production paths are forbidden.

## Black-Box Binary Firewall, Pure 7-Bit ASCII & Remote Synchronization Rules
- **Black-Box Binary Firewall**: Never copy upstream compiler crates (`crates/deap-*`) or upstream `blueprints/*.md` into downstream repositories, and never read upstream compiler internals from sibling directories during downstream tasks.
- **Workspace-Relative Paths & Zero Symlinks**: All paths MUST be workspace-relative (`.`, `./...`); symbolic links anywhere outside `.git` are rejected fail-closed by `verify-baseline perimeter`.
- **Pure 7-Bit LF ASCII (`0x20..=0x7E` + `0x0A`)**: All governed governance, CI, profile, and `.sysml` files (`README.md`, `AGENTS.md`, `CLAUDE.md`, `.gitlab-ci.yml`, `.gitignore`, `.deap/*`, `downstream-profiles/**/*.md`, `schema/**/*.sysml`) MUST contain strictly pure 7-bit ASCII with Unix LF line endings, zero horizontal tabs (`0x09`), zero CR (`0x0D`), and zero Unicode em/en dashes (`--` or `-` only).
- **Mermaid & KaTeX Integrity**: Use deterministic `flowchart TD` (or supported Mermaid headers) with quoted special-character labels; keep display math `$$` on isolated lines.
- **Commit Non-Closure & Remote Sync**: Never use auto-closing keywords (`fix #`, `fixes #`, `close #`, `resolve #`) in commit messages; use `(#<id>)` or `(refs #<id>)`. No task is complete until pushed to `origin` with `git diff origin/<branch>` verified empty.
