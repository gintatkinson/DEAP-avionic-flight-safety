# Claude Code Project Guidelines

## Primary Commercial Toolchain Integration Context
This project explicitly declares MATLAB / Simulink / Stateflow / Embedded Coder as the Primary Tier-1 Commercial Toolchain Integration Context (Model-Based Design, Control Law Synthesis, DO-178C C/SPARK Ada code generation).

## Upstream Toolchain & Downstream Perimeter Context
- **Upstream Provenance**: `gintatkinson/deap03@e75d23d412fa88f5ecc9683c0615c3303d43bf00` (`stage-10-complete`, Ferrocene `stable-26.08.0` via `criticalup.toml`).
- **Perimeter Role**: `downstream-consumer` (`N_up_src == 0`, zero symlinks, pure 7-bit LF ASCII on governed files).
- **Signed Release Manifest & Key**: `.deap/update-manifest.json` (SHA-256 `1243abcb151f276806ea96b01e77b671e3eed03b4c8e1653fa5bd5baee8b3619`) verified against Tier-2 `Ed25519` public key `606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`.

## Workflow & Quality Gates
- Follow project governance in `AGENTS.md`, `downstream-profiles/README.md`, `downstream-profiles/DOWNSTREAM_INSTALLATION_AND_CI_GUIDE.md`, and `downstream-profiles/profile-non-rust-targets/NON_RUST_MULTI_TOOLCHAIN_PROFILES.md` (alongside `profile-dart-flutter-hmi/` and `profile-target-app-runtime/`).
- Strict Planning Gate: Do not execute unauthorized modifications without an approved implementation plan.
- Verify signed `0x60` `UpdateManifest` and `B_5` binaries: `./.deap/bin/verify-baseline verify-manifest --workspace . --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`.
- Execute downstream perimeter, ASCII, and `schema/lib/{ISQ,RAAML}.sysml` verification gate: `./.deap/bin/verify-baseline perimeter --workspace . --perimeter-role downstream-consumer --schema-scope lib-only --manifest .deap/update-manifest.json --bundle-dir .deap/bin --verify-key 606a0547d9928339c7c8f8dc7cd075969390fa8fb3497b3702013b9074d6d54b`.
- Seal SysML v2 / RAAML v1 canonical IR snapshot: `./.deap/bin/ingest-sysml seal --workspace . --schema-dir schema --out-snapshot .deap/ir.snapshot.bin`.
- Assemble ConOps & Mission Intent projections: `./.deap/bin/assemble-conops project --workspace . --snapshot .deap/ir.snapshot.bin --out-dir docs/conops`.
- Compile SysML v2 safety artifacts and `#![no_std]` contracts: `./.deap/bin/compile-sysml build --workspace . --snapshot .deap/ir.snapshot.bin --conops-receipt .deap/conops.receipt.json --out-docs docs`.
- Reconcile Agile/WBS backlog specifications and 3-way Merkle state: `./.deap/bin/reconcile-backlog sync --workspace . --snapshot .deap/ir.snapshot.bin --docs-dir docs --schema-dir schema`.
