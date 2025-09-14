# Page Priority
## Linux
[Notes on linux memory management options to prioritize and control memory access using older ulimits, newer cgroups and overcommit policy settings. Mostly as an attempt to keep a desktop environment responsive and avoid swap thrashing under high memory pressure.](https://gist.github.com/JPvRiel/bcc5b20aac0c9cce6eefa6b88c125e03)

[How to assign a "memory priority" to a linux process? - Stack Overflow](https://stackoverflow.com/questions/25404663/how-to-assign-a-memory-priority-to-a-linux-process)

[Can I tell Linux not to swap out a particular processes' memory? - Stack Overflow](https://stackoverflow.com/questions/578137/can-i-tell-linux-not-to-swap-out-a-particular-processes-memory)

[linux - Low memory application priority - Server Fault](https://serverfault.com/questions/3526/low-memory-application-priority)

## Windows
> The memory priority of a thread or process serves as a hint to the memory manager when it trims pages from the working set. Other factors being equal, pages with lower memory priority are trimmed before pages with higher memory priority.

> Every physical page in the system has a page priority value assigned to it by the memory manager. The page priority is a number in the range 0 to 7. Its main purpose is to determine the order in which pages are consumed from the standby list. The memory manager divides the standby list into eight sublists that each stores pages of a particular priority. When the memory manager wants to take a page from the standby list, it takes pages from low-priority lists first.
> 
> Each thread and process in the system is also assigned a page priority. A page’s priority usually  reflects the page priority of the thread that first causes its allocation. (If the page is shared, it reflects the highest page priority among the sharing threads.) A thread inherits its page-priority value from the process to which it belongs. The memory manager uses low priorities for pages it reads from disk speculatively when anticipating a process’s memory accesses.
> 
> By default, processes have a page-priority value of 5, but the `SetProcessInformation` and `SetThreadInformation` user-mode functions allow applications to change process and thread pagepriority values. These functions call the native `NtSetInformationProcess` and `NtSetInformationThread` functions. You can look at the memory priority of a thread with Process Explorer (per-page priority can be displayed by looking at the PFN entries).[^yosifovichWindowsInternalsSystem2017]

Unrelated to thread and I/O priority?

[`MEMORY_PRIORITY_INFORMATION` (processthreadsapi.h) - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/ns-processthreadsapi-memory_priority_information)

Tools:
- Process Explorer


[^yosifovichWindowsInternalsSystem2017]: Yosifovich, P., Ionescu, A., Solomon, D. A., & Russinovich, M. E. (2017). Windows Internals: System architecture, processes, threads, memory management, and more, Part 1. Microsoft Press. https://books.google.com/books?hl=en&lr=&id=y83LDgAAQBAJ&oi=fnd&pg=PA1999&dq=Windows+Internals
