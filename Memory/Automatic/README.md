# Automatic Memory Management
## Garbage Collection
A **garbage collector** is a dynamic storage allocator that automatically frees allocated blocks that are no longer needed by the program. Garbage collection dates back to Lisp systems developed by John McCarthy at MIT in the early 1960s. It is an important part of modern language systems such as Java, ML, Perl, and Mathematica, and it remains an active and important area of research.[^csapp]

Books:
- [The Garbage Collection Handbook](https://gchandbook.org/) ([Z-Library](https://zlibrary-jp.se/book/25362864/bb30ae))

### Tracing garbage collection
**Tracing garbage collection** is the most common type of garbage collection, so much so that "garbage collection" often refers to tracing garbage collection, rather than other methods such as reference counting. The overall strategy consists of determining which objects should be garbage collected by tracing which objects are reachable by a chain of references from certain root objects, and considering the rest as garbage and collecting them. However, there are a large number of algorithms used in implementation, with widely varying complexity and performance characteristics.[^wiki]

#### Mark-and-sweep algorithm
[^csapp]
1. Mark phase: mark all reachable and allocated descendants of the root nodes
   
   ```c
   void mark(ptr p) {
     // If p points to some word in an allocated block, isPtr() returns a pointer b to the beginning of that block. Returns NULL otherwise.
     if ((b = isPtr(p)) == NULL)
       return;
     if (blockMarked(b))
       return;
     markBlock(b);
     // length() returns the length in words (excluding the header) of block b.
     len = length(b);
     for (i=0; i < len; i++)
       mark(b[i]);
   }
   ```
 
   The mark phase calls the mark function once for each root node. The mark function returns immediately if p does not point to an allocated and unmarked heap block. Otherwise, it marks the block and calls itself recursively on each word in block. Each call to the markfunction marks any unmarked and reachable descendants of some root node. At the end of the mark phase, any allocated block that is not marked is guaranteed to be unreachable and, hence, garbage that can be reclaimed in the sweep phase.
 
   Typically, one of the spare low-order bits in the block header is used to indicate whether a block is marked or not.

2. Sweep phase: free each unmarked allocated block

   ```c
   void sweep(ptr b, ptr end) {
     while (b < end) {
       if (blockMarked(b))
         unmarkBlock(b);
       else if (blockAllocated(b))
         free(b);
       b = nextBlock(b);
     }
   }
   ```

### Reference counting
**Reference counting garbage collection** is where each object has a count of the number of references to it. Garbage is identified by having a reference count of zero. As with manual memory management, and unlike tracing garbage collection, reference counting guarantees that objects are destroyed as soon as their last reference is destroyed, and usually only accesses memory which is either in CPU caches, in objects to be freed, or directly pointed to by those, and thus tends to not have significant negative side effects on CPU cache and virtual memory operation.[^wiki]

### Escape analysis
**Escape analysis** is a compile-time technique that can convert heap allocations to stack allocations, thereby reducing the amount of garbage collection to be done. This analysis determines whether an object allocated inside a function is accessible outside of it. If a function-local allocation is found to be accessible to another function or thread, the allocation is said to "escape" and cannot be done on the stack. Otherwise, the object may be allocated directly on the stack and released when the function returns, bypassing the heap and associated memory management costs.[^wiki]


[^wiki]: [Garbage collection (computer science) - Wikipedia](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science))
[^csapp]: Computer Systems：A Programmer's Perspective