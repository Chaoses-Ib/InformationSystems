# Manual Memory Management
The `sbrk()` function grows or shrinks the heap by adding incr to the kernel’s `brk` pointer. If successful, it returns the old value of `brk`, otherwise it returns −1 and
sets errno to ENOMEM. If incr is zero, then `sbrk()` returns the current value of `brk`. Calling `sbrk()` with a negative incris legal but tricky because the return value
(the old value of `brk`) points to `abs(incr)` bytes past the new top of the heap.[^csapp]

Fragmentation:
- Internal fragmentation: occurs when an allocated block is larger than the payload.
- External fragmentation: occurs when there is enough aggregate free memory to satisfy an allocate request, but no single free block is large enough to handle the request.

Since external fragmentation is difficult to quantify and impossible to predict, allocators typically employ heuristics that attempt to maintain small numbers of larger free blocks rather than large numbers of smaller free blocks.[^csapp]

Data structures:
- Implicit free list[^csapp]

  The advantage of an implicit free list is simplicity. A significant disadvantage is that the cost of any operation that requires a search of the free list, such as placing allocated blocks, will be linear in the total number of allocated and free blocks in the heap.

- Explicit free list[^csapp]

  A disadvantage of explicit lists in general is that free blocks must be large enough to contain all of the necessary pointers, as well as the header and possibly a footer. This results in a larger minimum block size and increases the potential for internal fragmentation.

- Segregated free list[^csapp]

  The segregated fits approach is a popular choice with production-quality allocators such as the GNU malloc package provided in the C standard library because it is both fast and memory efficient. Search times are reduced because searches are limited to particular parts of the heap instead of the entire heap. Memory utilization can improve because of the interesting fact that a simple first-fit search of a segregated free list approximates a best-fit search of the entire heap.

[Hidden Costs of Memory Allocation | Random ASCII – tech blog of Bruce Dawson](https://randomascii.wordpress.com/2014/12/10/hidden-costs-of-memory-allocation/)

## Implementations
- Windows heap

  [Windows 8 Heap Internals](https://illmatics.com/Windows%208%20Heap%20Internals%20(Slides).pdf)

  [\[llvm-dev\] RFC: Replacing the default CRT allocator on Windows](https://groups.google.com/g/llvm-dev/c/mWQEB-SzJD4)

- [mimalloc: a compact general purpose allocator with excellent performance.](https://github.com/microsoft/mimalloc)

  [如何评价 mimalloc？ - 知乎](https://www.zhihu.com/question/330717205)

  [mimalloc is a compact general purpose allocator with excellent performance characteristics. Initially developed by Daan Leijen for the run-time systems of the Koka and Lean languages. Published by Microsoft. : programming](https://www.reddit.com/r/programming/comments/c3ox2r/mimalloc_is_a_compact_general_purpose_allocator/)

- [jemalloc](https://github.com/jemalloc/jemalloc)

  Windows is not supported.

- [TCMalloc](https://github.com/google/tcmalloc)

- [rpmalloc: Public domain cross platform lock free thread caching 16-byte aligned memory allocator implemented in C](https://github.com/mjansson/rpmalloc)

- [snmalloc: Message passing based allocator](https://github.com/microsoft/snmalloc)


[^csapp]: Computer Systems：A Programmer's Perspective