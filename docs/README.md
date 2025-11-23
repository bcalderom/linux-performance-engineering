# Linux Performance Engineering Learning Framework

This project is a comprehensive, structured learning system designed to guide engineers from foundational Linux internals to expert-level performance analysis, tuning, and incident forensics. It integrates theory, practice, and real-world troubleshooting into a unified framework that mirrors the skillset required in modern production environments.

The curriculum is organized into progressive modules covering CPU architecture, memory management, kernel behavior, networking internals, storage performance, observability, and advanced debugging methodologies. Each topic is broken down into sections and subtopics with detailed descriptions to maintain clarity and ensure the learner always understands how each concept fits into the larger ecosystem of Linux performance engineering.

To maximize practical value, the project includes:

- Hands-on exercises that reinforce deep understanding through direct experimentation.
- Reproducible scripts stored in a `scripts/` directory that simulate real-world performance scenarios such as CPU starvation, softirq backlog, memory pressure, disk contention, and network microbursts.
- Production-grade Markdown documents generated via structured prompts, ensuring uniformity and high quality across all learning materials.
- Failure scenarios, debugging workflows, and best practices inspired by real incidents, helping learners develop a forensic approach to diagnosing and resolving system bottlenecks.

Overall, this project provides an end-to-end educational experience, equipping engineers with the ability to interpret Linux behavior under load, detect subtle performance degradations, resolve complex kernel-level issues, and confidently operate high-performance systems in demanding environments.

---

## Curriculum Overview

The learning path is organized into 10 major sections. Each section contains focused topics that map directly to standalone documents under `docs/`.

### 1. Foundations of Operating Systems & Linux Internals

- **1.1 Introduction to Linux**  
  Foundation for understanding Linux as an operating system and how it differs from monolithic, microkernel, and hybrid OS designs. Introduces kernel space vs user space and why this distinction matters for performance.

  - **1.1.1 Kernel Space vs User Space** – Memory protection, privilege levels, and why crashes or stalls occurring in kernel space are critical.
  - **1.1.2 System Calls Overview** – How applications interact with the kernel, how syscalls affect performance, and how syscall overhead is measured.

- **1.2 Processes, Scheduling & System Services**  
  How Linux executes programs, manages CPU access, and schedules threads. Crucial for diagnosing performance degradation and CPU saturation.

  - **1.2.1 Process Lifecycle** – From creation (fork/exec) to termination, including common bottlenecks.
  - **1.2.2 Linux Scheduling (CFS & RT)** – How scheduler decisions impact latency and throughput.
  - **1.2.3 Systemd & Service Management** – Service monitoring, dependencies, and troubleshooting.

- **1.3 Filesystem Layout & Kernel-Relevant Paths**  
  Where Linux stores logs, metrics, kernel tunables, and runtime data.

  - **1.3.1 /proc and /sys Explained** – Interpreting real-time metrics and kernel state exposure.
  - **1.3.2 Key Directories for Diagnostics** – `/var/log`, `/proc`, `/sys`, `/run`.

---

### 2. CPU Architecture, Scheduling & Interrupts

- **2.1 CPU Architecture Essentials**  
  Hardware understanding required to interpret performance metrics.

  - **2.1.1 Cores, Threads & NUMA Topology** – Impact on affinity and memory locality.
  - **2.1.2 CPU Pipelines & Cache Hierarchy** – Pipeline stalls, branch prediction, L1/L2/L3 caches, and TLBs.

- **2.2 Context Switching & Kernel Scheduling**  
  How the kernel switches tasks and the performance implications.

  - **2.2.1 Voluntary vs Involuntary Switches** – How blocking syscalls differ from scheduler-driven switches.
  - **2.2.2 Runqueue Saturation** – Identifying overloaded CPUs.

- **2.3 Interrupt Handling & IRQ Mechanisms**  
  Critical to diagnose high CPU usage, packet drops, and softlockups.

  - **2.3.1 HardIRQs** – Immediate handling by the CPU.
  - **2.3.2 SoftIRQs & ksoftirqd Behavior** – Kernel network processing path.
  - **2.3.3 IRQ Affinity & Balancing** – Distributing load across cores.

- **2.4 Kernel Lockups & Stall Diagnostics**  
  Detecting and analyzing freezes and CPU stalls.

  - **2.4.1 Softlockups** – Long non-preemptible kernel execution.
  - **2.4.2 Hardlockups** – Detected by NMI watchdog.
  - **2.4.3 RCU Stalls** – A common cause of kernel hangs.

---

### 3. Memory Management & Performance

- **3.1 RAM, Swap & Virtual Memory**  
  How Linux manages memory and why memory pressure causes slowdowns.

  - **3.1.1 Memory Zones & Allocation** – Normal, DMA, HighMem.
  - **3.1.2 Swap Policies** – Swappiness, pressure, and OOM scenarios.

- **3.2 Page Cache & Buffer Cache**  
  Why “used memory” might not indicate real pressure.

  - **3.2.1 File-backed Pages** – How disk I/O is accelerated.
  - **3.2.2 Dirty Pages & Writeback** – `dirty_ratio` implications on performance.

- **3.3 Page Faults & Latency**  
  Minor vs major faults and troubleshooting techniques.

- **3.4 Memory Stall Diagnostics**  
  Advanced analysis of allocation failures and latency spikes.

  - **3.4.1 THP (Transparent HugePages) Failures** – Impact on latency.
  - **3.4.2 Slab Allocator Issues** – Slab fragmentation and debugging.

---

### 4. Networking Fundamentals

- **4.1 Network Interfaces & Drivers**  
  Understanding NICs, naming conventions, and driver roles.

  - **4.1.1 Modern Interface Names (ensX)** – Predictable naming systems.
  - **4.1.2 NIC Offloading Features** – TSO, GSO, GRO, LRO.

- **4.2 Packets, MTU, Latency & Throughput**  
  The basics every engineer needs to debug networking.

  - **4.2.1 MTU & Fragmentation** – How incorrect MTU causes performance drops.
  - **4.2.2 Latency Components** – RTT, queues, retransmissions.

- **4.3 TCP & UDP Internals**  
  Transport protocols within Linux.

  - **4.3.1 TCP State Machine** – Connection lifecycle, SYN flood symptoms.
  - **4.3.2 UDP Behavior** – No retransmission and its implications.

---

### 5. Linux Kernel Networking Internals

- **5.1 Full Packet Path (RX/TX)**  
  Essential for analyzing packet drops inside the kernel.

  - **5.1.1 Driver → SoftIRQ → Socket** – Sequential breakdown of packet processing.

- **5.2 Softnet Queues & Backlogs**  
  Internal queueing and overflow problems.

  - **5.2.1 softnet_stat Interpretation** – `packet_drop` vs `time_squeezed`.

- **5.3 RSS, RPS, RFS & IRQ Distribution**  
  Techniques for multi-core traffic distribution.

- **5.4 NIC Drivers (ENA, VirtIO, ixgbe)**  
  Driver-specific quirks, tuning, and interrupts.

- **5.5 Microbursts & Short-Lived Congestion**  
  Why average graphs miss critical events.

---

### 6. Storage & Filesystem Performance

- **6.1 IOPS, Throughput & Latency**  
  Dimensioning storage performance.

- **6.2 NVMe vs SSD Architecture**  
  Differences and bottlenecks.

- **6.3 IO Queues & Saturation**  
  Identifying disk contention.

- **6.4 Tools: iostat, fio, blktrace**  
  Instrumentation and benchmarking.

---

### 7. Kernel Tuning (sysctl)

- **7.1 sysctl Framework**  
  How the kernel exposes tunables.

- **7.2 Network Tuning**  
  Optimizing buffers, queues, and TCP behavior.

- **7.3 Memory Tuning**  
  Adjusting swappiness, dirty pages, caches.

- **7.4 Best Practices for Production**  
  Safe tunables per environment.

---

### 8. Monitoring, Observability & Metrics

- **8.1 Graph Interpretation (Grafana)**  
  Correlating subsystems and reading time-series data meaningfully.

- **8.2 Failure Patterns**  
  Common shapes observed in outages.

- **8.3 Metrics Correlation Techniques**  
  Using metrics to discover root cause.

- **8.4 Critical SRE Metrics**  
  Golden signals plus Linux-specific metrics.

---

### 9. Advanced Diagnostics & Incident Forensics

- **9.1 Kernel Networking Freeze**  
  Detailed incident model for diagnosing kernel-level network freezes.

- **9.2 IRQ Storms & SoftIRQ Saturation**  
  Abrupt CPU spikes due to interrupt storms.

- **9.3 Microburst Analysis**  
  Detecting short-lived events missed by coarse monitoring.

- **9.4 Systematic Forensic Method**  
  Step-by-step incident investigation methodology.

---

### 10. Complementary Modules

- **10.1 Kernel Architecture Deep Dive**  
  Monolithic design, subsystems, internal APIs.

- **10.2 eBPF & Deep Observability**  
  Tracepoints, uprobes, kprobes.

- **10.3 Kernel Logs & dmesg Analysis**  
  Reading timestamps, decoding messages.

- **10.4 Chaos Engineering**  
  Injecting controlled failures.

- **10.5 Hardware Fundamentals**  
  PCIe, microcode, NUMA, thermal throttling.

---

## How to Use This Repository

1. Start from section **1.x** documents in `docs/01-*/` to build foundations.
2. Progress through CPU, memory, networking, and storage modules as needed.
3. Use scripts in `scripts/` to reproduce scenarios and experiments described in the documents.
4. Refer to advanced modules (9.x and 10.x) when performing incident forensics or deep kernel investigations.
