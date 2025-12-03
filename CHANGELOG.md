## [0.9.13] - 2025-12-02

### Added

- **ISR and Interrupt Context subsection (2.3.2.1):** Comprehensive explanation of Interrupt Service Routines, interrupt context vs process context, atomic rules, why ISRs cannot sleep, register saving, and IDT mechanics with vector mapping table.
- **Interrupts vs Context Switches subsection (2.3.2.2):** Critical distinction clarifying that interrupts cause mode switches, not task switches, with scenarios table showing when context switches actually occur.
- **MSI/MSI-X subsection (2.3.4.1):** Modern interrupt delivery mechanisms, comparison table (Legacy vs MSI vs MSI-X), multi-queue NIC architecture, and observable commands for diagnosis.
- **Softirq Types subsection (2.3.5.1):** Complete table of 10 kernel-defined softirq types with numeric IDs, purposes, and `/proc/softirqs` interpretation guide.
- **When Softirqs Run subsection (2.3.5.2):** Explanation of inline vs ksoftirqd execution, rate-limiting mechanism, and cause-effect table.
- **NAPI subsection (2.3.5.3):** Interrupt mitigation for networking, hybrid interrupt/polling model, NAPI flow diagram, and budget configuration.
- **Interrupt Storms section (2.3.6):** Causes, symptoms, diagnosis table, interrupt coalescing with `ethtool -c`, tuning trade-offs, and irqbalance guidance.
- **ASCII diagram** at section start showing complete interrupt processing flow from device through ISR, softirq, scheduler check, to user task.

### Changed

- Expanded Key Terms (2.3.1) with ISR, Interrupt Context, Interrupt Vector, and MSI/MSI-X definitions.
- Added terminology clarification distinguishing "Hardware Interrupt" (electrical signal) from "Hard IRQ" (ISR handler code).
- Expanded Beginner Checklist (2.3.9) from 5 to 12 items covering ISRs, interrupt context, softirq interpretation, MSI-X, NAPI, and interrupt storm diagnosis.
- Renumbered sections: Exercise is now 2.3.8, Checklist is now 2.3.9.

## [0.9.12] - 2025-12-01

### Changed

- Rewrote `2.3-interrupt-handling-and-irq-mechanisms.md` to strictly adhere to the Concept Connection Framework.
  - Introduced the "Two-Halves Model" with a receptionist/caseworker analogy.
  - Added a concept chain for the packet processing path.
  - Included a "Real-World Failure Scenario" involving a single-core bottleneck due to poor IRQ affinity.
  - Clarified the role of `ksoftirqd` and its relationship to `%si`.

## [0.9.11] - 2025-12-01

### Changed

- Rewrote `2.2-context-switching-and-kernel-scheduling.md` to strictly adhere to the Concept Connection Framework and new pedagogical rules.
  - Explicitly separated "Voluntary" vs "Non-Voluntary" context switches with a comparison table and observable symptoms.
  - Added a "Concept Chain" for the runqueue cycle.
  - Included a "Real-World Failure Scenario" about a chatty microservice to illustrate voluntary switching costs.
  - Improved the "Load Average" explanation with a clearer distinction between CPU usage and runqueue demand.

## [0.9.10] - 2025-11-26

### Changed

- Refined the `mpstat` explanation in `2.2-context-switching-and-kernel-scheduling.md` to explicitly point to the `%idle` column for identifying scheduling imbalances and single-threaded saturation.

## [0.9.9] - 2025-11-26

### Changed

- Added sample `mpstat -P ALL 1` output to `2.2-context-switching-and-kernel-scheduling.md` to demonstrate how to identify scheduling imbalances and per-CPU idle states.

## [0.9.8] - 2025-11-26

### Changed

- Further refined the explanation for "Load 0.25 on 4 CPUs" in `2.2-context-switching-and-kernel-scheduling.md` to avoid ambiguity by explicitly contrasting single-CPU capacity usage (25%) with total system idleness (93.75%).

## [0.9.7] - 2025-11-26

### Changed

- Refined the explanation for "Load 0.25 on 4 CPUs" in `2.2-context-switching-and-kernel-scheduling.md` to explicitly address "how many" CPUs are occupied (effectively 25% of one CPU).

## [0.9.6] - 2025-11-26

### Fixed

- Corrected the interpretation of "Load 0.25 on 4 CPUs" in `2.2-context-switching-and-kernel-scheduling.md` to accurately state that the system is mostly idle (93.75% idle), fixing a previous error that claimed full utilization.

## [0.9.5] - 2025-11-26

### Changed

- Clarified the "Load N on N CPUs" explanation in `2.2-context-switching-and-kernel-scheduling.md` to explicitly state that this indicates 100% utilization because the average number of tasks equals the number of available CPUs.

## [0.9.4] - 2025-11-26

### Changed

- Added "Contention" to the Key Terms section in `2.2-context-switching-and-kernel-scheduling.md` to formalize the concept of resource competition.

## [0.9.3] - 2025-11-26

### Changed

- Refined Load Average explanation in `2.2-context-switching-and-kernel-scheduling.md` to explicitly link the grocery store analogy to a single CPU (single checkout lane) and added a breakdown of how to interpret load 1.0 vs 4.0 across different CPU counts.

## [0.9.2] - 2025-11-26

### Changed

- Added a simplified "grocery store" arithmetic explanation to the Load Average section in `2.2-context-switching-and-kernel-scheduling.md` to clarify that load is an average queue length, not a rate (tasks/minute).

## [0.9.1] - 2025-11-26

### Changed

- Expanded `pidstat` coverage in `2.2-context-switching-and-kernel-scheduling.md`:
  - Added realistic sample output for `pidstat -w 1`.
  - Provided a detailed explanation of the difference between voluntary (`cswch/s`) and non-voluntary (`nvcswch/s`) context switches, with examples of I/O-bound vs. CPU-bound behavior.

## [0.9.0] - 2025-11-26

### Changed

- Added sample output for `vmstat` in `2.2-context-switching-and-kernel-scheduling.md` to illustrate where to find the context switch count (`cs`).
- Refined the explanation of the `vmstat` sample in `2.2-context-switching-and-kernel-scheduling.md` to explicitly connect the data spike (1200 -> 4500 cs) with the increase in runqueue depth (2 -> 6 r).

## [0.8.0] - 2025-11-25

### Changed

- Enhanced `2.2-context-switching-and-kernel-scheduling.md` by explicitly connecting runqueue depth to I/O bottlenecks and latency, strengthening the "System Synergy" aspect.
- Improved `2.3-interrupt-handling-and-irq-mechanisms.md`:
  - Added a "First Principles" explanation for the top/bottom half split in interrupt handling.
  - Refined the "Interrupt storm" Key Term to highlight its ripple effect on softirq usage.
- Clarified `2.4-kernel-lockups-and-stall-diagnostics.md` Key Terms by providing a more accessible definition of RCU before explaining RCU stalls.
- Improved accessibility in `2.1-cpu-architecture-essentials.md` by:
  - Replacing technical jargon about cache interference with a "neighbor" analogy covering L1/L2 and L3.
  - Smoothing the transition between the CPU topology diagram and tool interpretation.
  - Clarifying Hyper-Threading contention with a concrete example of "number crunching" tasks fighting for execution units.

### Technical Debt

- Polished Section 02 definitions and cross-subsystem connections to better align with the "System Synergy" and "Concept Introduction Discipline" rules.

## [0.7.0] - 2025-11-25

### Changed
- Significantly improved accessibility of `2.1-cpu-architecture-essentials.md` for sysadmin/SRE audience transitioning to performance engineering:
  - Simplified Key Terms by removing IPC (introduced later with perf context) and enhancing definitions with practical analogies and observable metrics.
  - Restructured hyperthreading section with progressive introduction (concept → when it helps → when it hurts) and visual htop examples showing good vs. bad thread distribution.
  - Enhanced cache hierarchy section with clear subsections, "What You'll Observe" symptoms, and labeled perf stat as a "Preview" with simpler counters.
  - Expanded NUMA section to explain the purpose and problem it solves before technical details, added system applicability check, and numastat observation guidance.
  - Improved frequency scaling section with three concrete scenarios, sample outputs, thermal throttling detection with dmesg, and practical troubleshooting guidance.
  - Updated Beginner Checklist with more specific, actionable items tied to observable commands and outcomes.
- Applied "no hidden prerequisites" principle throughout: every concept explained before use, tied to observable commands/metrics, with progressive depth from simple to advanced.

### Technical Debt
- Established pattern for making advanced performance topics accessible: problem → solution → observation, with clear "What You'll Observe" sections and labeled previews for advanced tools.

## [0.1.0] - 2025-11-23

### Added
- Initial section 01 documentation (1.1–1.3) with production-grade Linux performance engineering content.
- Helper scripts for section 01 exercises in `scripts/section01-04-introduction-to-linux-basics.sh`, `scripts/section01-05-processes-and-scheduling.sh`, and `scripts/section01-06-proc-and-sys-explorer.sh`.

### Changed
- Consolidated `docs/learning-path.md` into `docs/README.md` to serve as the single structured entry point for the curriculum.
- Clarified how sections and scripts fit together in the "How to Use This Repository" instructions.

### Technical Debt
- Established initial documentation and script baseline for future expansion of remaining sections.

## [0.2.0] - 2025-11-23

### Added
- Beginner-focused onboarding documents for Section 01, now exposed as `1.1-what-is-an-operating-system.md`, `1.2-the-shell-and-commands.md`, and `1.3-programs-processes-and-threads.md`.

### Changed
- Restructured `docs/01-foundations-of-os-and-linux-internals/` to use a flat, numbered naming scheme (`1.x-*.md`) consistent with later sections.
- Renamed the original Section 01 core documents to `1.4-introduction-to-linux.md`, `1.5-processes-scheduling-and-system-services.md`, and `1.6-filesystem-layout-and-kernel-relevant-paths.md` to reflect their position after the new beginner material.
- Updated `docs/README.md` directory structure to match the new layout and remove the unused `00-linux-fundamentals/` placeholder.

### Fixed
- Eliminated duplicated and confusing Section 01 files by flattening the previous `01-basic-linux-concepts/` subdirectory into the top level and removing on-disk archives in favor of Git history.

### Removed
- Removed the `_archive-v1/` folder under Section 01, relying on Git history as the canonical archive of the original 1.1–1.3 documents.

### Technical Debt
- Simplified the Section 01 structure and naming to reduce cognitive overhead for contributors and learners, making it easier to navigate and evolve the foundational curriculum.

## [0.3.0] - 2025-11-23

### Changed
- Refined `1.1-what-is-an-operating-system.md` to explicitly target a sysadmin audience, clarifying that kernel concepts like kernel mode, system calls, virtual memory, page cache, swapping, and D state are introduced as high-level previews.
- Softened and explained low-level jargon in Section 1.1 performance angles (D state, interrupts, stalls, lockups, throughput) to tie them to observable symptoms in common CLI tools.

## [0.4.0] - 2025-11-23

### Changed
- Added `Key Terms` sections to `1.4-introduction-to-linux.md`, `1.5-processes-scheduling-and-system-services.md`, and `1.6-filesystem-layout-and-kernel-relevant-paths.md` to align with the authoring rules and make core concepts explicit.
- Clarified advanced kernel and performance concepts in Section 01 (rings, context-switch costs, scheduler internals, interrupts/softirqs) as high-level previews with plain-language explanations suitable for a sysadmin/SRE audience.

## [0.5.0] - 2025-11-23

### Added
- New appendix document `11.1-nice-and-cpu-priority.md` explaining nice values, how they interact with the scheduler, and practical usage with `nice` and `renice`.

### Changed
- Linked Section 1.5 scheduling content to the new nice appendix so readers can dive deeper into CPU priority tuning without overloading the main foundations chapter.

## [0.6.0] - 2025-11-24

### Added
- Authored full Section 02 CPU documentation: `2.1-cpu-architecture-essentials.md`, `2.2-context-switching-and-kernel-scheduling.md`, `2.3-interrupt-handling-and-irq-mechanisms.md`, and `2.4-kernel-lockups-and-stall-diagnostics.md`, each with Key Terms, diagrams, exercises, and beginner checklists aligned to the Linux performance curriculum rules.
- Introduced Section 02 demo scripts `scripts/section02-01-cpu-architecture-demo.sh`, `scripts/section02-02-context-switching-demo.sh`, `scripts/section02-03-interrupts-demo.sh`, and `scripts/section02-04-lockup-and-stall-demo.sh` to reproduce CPU-bound workloads, context-switch storms, interrupt-heavy traffic, and CPU starvation scenarios on non-production systems.

### Technical Debt
- Established a structured template for future Section 02 expansions, ensuring consistent use of terminology, observability-focused examples, and script-backed hands-on labs.
