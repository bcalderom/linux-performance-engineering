# Linux Performance Engineering Learning Framework  
*A multi-level curriculum from beginner fundamentals to expert kernel performance analysis.*

---

## 🔰 Project Overview

This project provides a **complete learning system** that takes learners from **Linux basics** to **advanced performance engineering** and **kernel-level forensics**.  
It is designed for both beginners starting from zero and experienced engineers seeking deep specialization.

The framework integrates:

- Foundational OS and Linux concepts  
- Step-by-step progression into CPU, memory, storage, networking, and kernel internals  
- Real-world failure scenarios from production systems  
- Hands-on labs and reproducible simulation scripts  
- AI-generated, production-ready learning documents  

Each topic is broken into carefully scoped documents to ensure clarity, consistency, and an intuitive learning path.

---

## 🧱 Learning Philosophy

This curriculum is built around three principles:

### **1. Start simple, evolve into depth**
Beginners should first master:  
- What Linux is  
- What commands, processes, and filesystems are  
- What actually happens when you run a program  

Only then do we move into performance engineering.

### **2. Teach concepts through real-world incidents**  
Performance engineering is best learned by observing real failures:
- High CPU saturation  
- Disk I/O stalls  
- SoftIRQ storms  
- Memory pressure  
- Kernel freezes  

### **3. Learn by doing**  
Each module includes:
- Hands-on exercises  
- Diagnostics tool usage  
- Scripts under `/scripts/` that recreate real issues  
- Interpretations of real logs and metrics  

---

# 🧭 Curriculum Overview

The curriculum is organized into **10 major sections**, starting with foundational material before deep technical dives.

---

# **1. Foundations of Operating Systems & Linux Internals**

Beginner-friendly onboarding into Linux as an OS, the shell, processes, and the core kernel interactions you need before diving into CPU, memory, and networking.

### 1.1 What Is an Operating System?
- High-level view of what an OS does (process, memory, device, and I/O management).
- Why performance engineers care about the OS as a resource arbiter.

### 1.2 The Shell and Commands
- What a shell is and how it interprets commands.
- What happens when you press Enter on a command.

### 1.3 Programs, Processes and Threads
- Plain definitions with concrete examples (`sleep`, `ps`, `top -H`).
- How PIDs, PPIDs, and threads relate.

### 1.4 Introduction to Linux
- How Linux is architected (monolithic kernel, user vs kernel space).
- How applications interact with the kernel via system calls.

### 1.5 Processes, Scheduling & System Services
- Process lifecycle and observable states (R, S, D, Z).
- High-level scheduler behavior and systemd service management.

### 1.6 Filesystem Layout & Kernel-Relevant Paths
- Filesystem tree overview and key directories.
- Where Linux exposes kernel and system state (`/proc`, `/sys`, `/var/log`, `/run`).

---

# **2. CPU Architecture, Scheduling & Interrupts**

Deeper understanding of CPU internals, scheduling behavior, and interrupt processing.  
*(This module now assumes Chapters 0 and 1 are complete.)*

- **2.1 CPU Architecture Essentials**  
- **2.2 Context Switching & Kernel Scheduling**  
- **2.3 Interrupt Handling & IRQ Mechanisms**  
- **2.4 Kernel Lockups & Stall Diagnostics**  

---

# **3. Memory Management & Performance**

Covers how Linux allocates memory, handles page faults, caching, and diagnosing memory stalls.

- **3.1 Virtual Memory, RAM & Swap**  
- **3.2 Page Cache & Buffer Cache**  
- **3.3 Page Faults & Latency**  
- **3.4 Memory Stall Diagnostics**  

---

# **4. Networking Fundamentals**

Understanding networking concepts from the perspective of performance engineering.

- **4.1 Network Interfaces & Drivers**  
- **4.2 Packets, MTU, Latency & Throughput**  
- **4.3 TCP & UDP Internals**  

---

# **5. Linux Kernel Networking Internals**

How the kernel processes packets and where bottlenecks emerge.

- **5.1 Full Packet Path (RX/TX)**  
- **5.2 Softnet Queues & Backlogs**  
- **5.3 RSS, RPS, RFS**  
- **5.4 NIC Drivers (ENA, VirtIO, ixgbe)**  
- **5.5 Microbursts & Short-Lived Congestion**  

---

# **6. Storage & Filesystem Performance**

Diagnostics for block devices, SSDs, NVMes, queues, and I/O schedulers.

---

# **7. Kernel Tuning (sysctl)**

Best practices for performance tuning across memory, networking, and system behavior.

---

# **8. Monitoring, Observability & Metrics**

Metric interpretation, correlation techniques, failure pattern recognition.

---

# **9. Advanced Diagnostics & Incident Forensics**

How to analyze kernel freezes, IRQ storms, microbursts, and more.

---

# **10. Complementary Modules**

Kernel architecture deep dives, eBPF, chaos engineering, hardware fundamentals.

---

# 📂 Directory Structure

docs/
  01-foundations-of-os-and-linux-internals/
    1.1-what-is-an-operating-system.md
    1.2-the-shell-and-commands.md
    1.3-programs-processes-and-threads.md
    1.4-introduction-to-linux.md
    1.5-processes-scheduling-and-system-services.md
    1.6-filesystem-layout-and-kernel-relevant-paths.md
  02-cpu-architecture-scheduling-and-interrupts/
  03-memory-management-and-performance/
  04-networking-fundamentals/
  05-linux-kernel-networking-internals/
  06-storage-and-filesystem-performance/
  07-kernel-tuning-sysctl/
  08-monitoring-observability-and-metrics/
  09-advanced-diagnostics-and-incident-forensics/
  10-complementary-modules/
scripts/
