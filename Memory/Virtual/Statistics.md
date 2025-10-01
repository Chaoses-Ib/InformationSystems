# Virtual Memory Statistics
- Memory usage
  - Virtual / Physical
  - Private / Shareable / Shared
  - Current / Peak
- Page faults
  - Total / Major (hard, I/O) / Minor (soft)

## Linux
[command line - Peak memory usage of a linux/unix process - Stack Overflow](https://stackoverflow.com/questions/774556/peak-memory-usage-of-a-linux-unix-process)

## Windows
- [`SYSTEM_EXTENDED_PROCESS_INFORMATION`](https://ntdoc.m417z.com/system_extended_process_information) (`SYSTEM_PROCESS_INFORMATION_EXTENSION`)

  [`SYSTEM_PROCESS_INFORMATION_EXTENSION`](https://www.geoffchappell.com/studies/windows/km/ntoskrnl/api/ex/sysinfo/process_extension.htm)
- [→Working set querying](../Windows/Working%20Sets.md#querying)

APIs:
- [GetProcessMemoryInfo](https://learn.microsoft.com/en-us/windows/win32/api/psapi/nf-psapi-getprocessmemoryinfo)
  - Soft page faults

### Page faults
- `SYSTEM_EXTENDED_PROCESS_INFORMATION`
- `Get-Counter -Counter "\Memory\Pages Input/sec"`

[Production postmortem: The Guinness record for page faults & high CPU - RavenDB NoSQL Database](https://ravendb.net/articles/production-postmortem-the-guinness-record-for-page-faults-high-cpu)

[glandium.org » Blog Archive » How to get the hard page fault count on Windows](https://glandium.org/blog/?p=1963)
- [winapi - Programatically read program's page fault count on Windows - Stack Overflow](https://stackoverflow.com/questions/6416005/programatically-read-programs-page-fault-count-on-windows)

[windows - Measuring Only Page Faults That Reach the Disk - Server Fault](https://serverfault.com/questions/893575/measuring-only-page-faults-that-reach-the-disk)

[memory - On Windows it's possible to monitor the hard faults for each process? - Server Fault](https://serverfault.com/questions/152470/on-windows-its-possible-to-monitor-the-hard-faults-for-each-process)

[winapi - Programatically read program's page fault count on Windows - Stack Overflow](https://stackoverflow.com/questions/6416005/programatically-read-programs-page-fault-count-on-windows)

[memory - Monitoring Hard Faults on Windows Server 2003 using PerfMon - Server Fault](https://serverfault.com/questions/7406/monitoring-hard-faults-on-windows-server-2003-using-perfmon)

[windows - What is Performance Monitor telling me when my page faults / second are high? - Super User](https://superuser.com/questions/240578/what-is-performance-monitor-telling-me-when-my-page-faults-second-are-high)

## Libraries
### Rust
- sysinfo
  - [Process peak memory usage - Issue #1587](https://github.com/GuillaumeGomez/sysinfo/issues/1587)

### .NET
- NtObjectManager
  - `(Get-NtProcess -Name rust-analyzer.exe -InfoOnly).HardFaultCount`

## Tools
Linux:
- vmstat ([Wikipedia](https://en.wikipedia.org/wiki/Vmstat))

Windows:
- Task Manager
- Performance Monitor
- System Informer
