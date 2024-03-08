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

[There Ain't No Such Thing as a Free Custom Memory Allocator](https://arxiv.org/abs/2206.11728)

[Hidden Costs of Memory Allocation | Random ASCII – tech blog of Bruce Dawson](https://randomascii.wordpress.com/2014/12/10/hidden-costs-of-memory-allocation/)

[Memory allocation functions can give you more memory than you ask for, and you are welcome to use the freebies too, but watch out for the free lunch - The Old New Thing](https://devblogs.microsoft.com/oldnewthing/20120316-00/?p=8083)
- > But the memory manager won't zero out the three bonus bytes it gave you when you called `Heap­Alloc`, because those bytes aren't new. In fact, the heap manager assumes that you knew about those three extra bytes and were actively using them, and it would be rude to zero out those bytes behind your back.

How bad is using multiple different allocators in the same process in terms of memory usage?

## Implementations
- Windows heap

  [Windows 8 Heap Internals](https://illmatics.com/Windows%208%20Heap%20Internals%20(Slides).pdf)

  [\[llvm-dev\] RFC: Replacing the default CRT allocator on Windows](https://groups.google.com/g/llvm-dev/c/mWQEB-SzJD4)

  > 进程默认堆上内存承担较多功能，分配速度慢。（和理想状态下 glibc 的 malloc 比，速度只有六成左右。）除了比较节约内存，其他方面真的乏善可陈。

  Tools:
  - [HeapMemView - View Process Heap Memory](https://www.nirsoft.net/utils/heap_memory_view.html)

- [mimalloc: a compact general purpose allocator with excellent performance.](https://github.com/microsoft/mimalloc) ([Wikipedia](https://en.wikipedia.org/wiki/Mimalloc))

  - 可能比 Windows heap 节省高达 20% 的内存，也可能增加高达 35% 的内存，取决于具体的应用场景。可能在碎片内存较多的情况下占用低于 Windows heap。
  - 比 Windows heap 的性能高大约 5~20%。可能在多线程的情况下性能提升更多。
  - Memory leaks
    - [memory leak in `mi_thread_data_zalloc` - Issue #748](https://github.com/microsoft/mimalloc/issues/748)
    - [Memory leak when statically linked mimalloc to a dll, which is unloaded via a non main thread - Issue #288](https://github.com/microsoft/mimalloc/issues/288)
  - [When will release the next version? - Issue #835](https://github.com/microsoft/mimalloc/issues/835)

  [如何评价 mimalloc？ - 知乎](https://www.zhihu.com/question/330717205)

  [mimalloc is a compact general purpose allocator with excellent performance characteristics. Initially developed by Daan Leijen for the run-time systems of the Koka and Lean languages. Published by Microsoft. : programming](https://www.reddit.com/r/programming/comments/c3ox2r/mimalloc_is_a_compact_general_purpose_allocator/)

  [Reviewing mimalloc: Part I - Ayende @ Rahien](https://ayende.com/blog/187969-B/reviewing-mimalloc-part-i)

- [jemalloc](https://github.com/jemalloc/jemalloc)

  Windows is not supported.

- [TCMalloc](https://github.com/google/tcmalloc)

- [rpmalloc: Public domain cross platform lock free thread caching 16-byte aligned memory allocator implemented in C](https://github.com/mjansson/rpmalloc)

- [snmalloc: Message passing based allocator](https://github.com/microsoft/snmalloc)

[Mimalloc-bench: Suite for benchmarking malloc implementations.](https://github.com/daanx/mimalloc-bench)

[Benchmarking allocators](https://dustri.org/b/files/blackalps_2022.pdf)


[^csapp]: Computer Systems：A Programmer's Perspective