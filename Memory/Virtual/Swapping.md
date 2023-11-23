# Swapping
## Thrashing
[Wikipedia](https://en.wikipedia.org/wiki/Thrashing_(computer_science))

When memory is simply oversubscribed, and the memory demands of the set of running processes simply exceeds the available physical memory, the OS will constantly be paging, a condition sometimes referred to as **thrashing**.

Admission control: given a set of processes, a system could decide not to run a subset of processes, with the hope that the reduced set of processes’ **working sets** (the pages that they are using actively) fit in memory and thus can make progress.

Some versions of Linux run an out-of-memory killer when memory is oversubscribed; this daemon chooses a memory-intensive process and kills it, thus reducing memory in a none-too-subtle manner. While successful at reducing memory pressure, this approach can have problems.[^three] 不过似乎大部分 Linux 系统并不会这样做。


[^three]: Operating Systems: Three Easy Pieces