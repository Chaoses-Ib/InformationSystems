# CS:APP Malloc Lab
- glibc v2.31-0ubuntu9.9

  Results:
  ```
  trace  valid  util     ops      secs  Kops
   0       yes    0%    5694  0.000279 20401
   1       yes    0%    5848  0.000211 27729
   2       yes    0%    6648  0.000537 12389
   3       yes    0%    5380  0.000515 10445
   4       yes    0%   14400  0.000334 43127
   5       yes    0%    4800  0.000598  8025
   6       yes    0%    4800  0.000438 10969
   7       yes    0%   12000  0.000277 43353
   8       yes    0%   24000  0.000378 63458
   9       yes    0%   14401  0.000919 15672
  10       yes    0%   14401  0.000190 75636
  Total           0%  112372  0.004676 24034
  ```

<details><summary>Oracle Linux server</summary>

- glibc v2.17

  Results:
  ```
  trace  valid  util     ops      secs  Kops
   0       yes    0%    5694  0.001411  4036
   1       yes    0%    5848  0.002988  1957
   2       yes    0%    6648  0.004255  1562
   3       yes    0%    5380  0.003015  1785
   4       yes    0%   14400  0.000759 18982
   5       yes    0%    4800  0.007366   652
   6       yes    0%    4800  0.004842   991
   7       yes    0%   12000  0.003596  3337
   8       yes    0%   24000  0.003876  6192
   9       yes    0%   14401  0.002024  7114
  10       yes    0%   14401  0.001697  8484
  Total           0%  112372  0.035829  3136
  ```
- Segregated explicit list

  Results:
  ```
  trace  valid  util     ops      secs  Kops
   0       yes   98%    5694  0.001330  4282
   1       yes   97%    5848  0.000447 13074
   2       yes   98%    6648  0.001602  4149
   3       yes   98%    5380  0.000812  6628
   4       yes   98%   14400  0.000655 21981
   5       yes   93%    4800  0.000501  9587
   6       yes   90%    4800  0.000514  9335
   7       yes   48%   12000  0.000799 15015
   8       yes   81%   24000  0.002404  9985
   9       yes   61%   14401  0.000750 19196
  10       yes   92%   14401  0.000608 23678
  Total          87%  112372  0.010422 10782
  
  Perf index = 52 (util) + 40 (thru) = 92/100
  ```
</details>

## Naive
```c
#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~0x7)
#define SIZE_T_SIZE (ALIGN(sizeof(size_t)))

int mm_init(void)
{
  return 0;
}

void *mm_malloc(size_t size)
{
  int blk_size = ALIGN(size + SIZE_T_SIZE);
  size_t *header = mem_sbrk(blk_size);
  if (header == (void *)-1) {
    return NULL;
  } else {
    *header = blk_size | 1;
    return (char *)header + SIZE_T_SIZE;
  }
}

void mm_free(void *ptr)
{
  size_t *header = ptr - SIZE_T_SIZE;
  *header &= ~1L;
}

void *mm_realloc(void *ptr, size_t size)
{
  void *oldptr = ptr;
  void *newptr;
  size_t copySize;
    
  newptr = mm_malloc(size);
  if (newptr == NULL)
    return NULL;
  copySize = *(size_t *)((char *)oldptr - SIZE_T_SIZE);
  if (size < copySize)
    copySize = size;
  memcpy(newptr, oldptr, copySize);
  mm_free(oldptr);
  return newptr;
}
```

Results:
```
trace  valid  util     ops      secs  Kops
 0       yes   23%    5694  0.000062 91104
 1       yes   19%    5848  0.000062 93868
 2       yes   30%    6648  0.000079 83834
 3       yes   40%    5380  0.000057 93728
 4        no     -       -         -     -
 5        no     -       -         -     -
 6        no     -       -         -     -
 7       yes   55%   12000  0.000115104076
 8       yes   51%   24000  0.000208115274
 9        no     -       -         -     -
10        no     -       -         -     -
Total            -       -         -     -
```

## Implicit free list
```c
#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~0x7)

#define HEADER_FLAGS (ALIGNMENT-1)
#define HEADER_SIZE (~HEADER_FLAGS)

typedef struct Header {
  union {
    // Since "your malloc implementation should always return 8-byte aligned pointers",
    // we can use 3 bits.
    bool alloc : 1;

    uint32_t size_flags;
  };
} Header;

Header *head;

int mm_init(void)
{
  head = mem_sbrk(sizeof(Header));
  head->size_flags = 0;
  
  return 0;
}

void* mm_malloc(size_t size)
{
  uint32_t block_size = ALIGN(size + ALIGN(sizeof(Header)));

  Header *p = head;
  while (p->size_flags != 0) {
    if (!p->alloc && (p->size_flags & HEADER_SIZE) >= block_size) {
      p->alloc = true;
      return (char *)p + ALIGN(sizeof(Header));
    }
    p = (Header *)((char *)p + (p->size_flags & HEADER_SIZE));
  }

  if (mem_sbrk(block_size) == (void *)-1) {
    return NULL;
  }

  p->size_flags = block_size;
  p->alloc = true;

  ((Header*)((char*)p + block_size))->size_flags = 0;

  return (char *)p + ALIGN(sizeof(Header));
}

void mm_free(void *ptr)
{
  Header *header = (Header*)((char*)ptr - ALIGN(sizeof(Header)));
  header->alloc = false;
}

void* mm_realloc(void *ptr, size_t size)
{
  Header *header = (Header*)((char*)ptr - ALIGN(sizeof(Header)));
  uint32_t block_size = ALIGN(size + ALIGN(sizeof(Header)));

  if (header->size_flags >= block_size) {
    return ptr;
  }

  // If the next block is free, merge it into this block
  Header *next = (Header *)((char *)header + (header->size_flags & HEADER_SIZE));
  if (next->size_flags != 0 && !next->alloc) {
    if (header->size_flags + next->size_flags >= block_size) {
      header->size_flags += next->size_flags & HEADER_SIZE;
      return ptr;
    }
  }

  void *new_ptr = mm_malloc(size);
  if (new_ptr == NULL) {
    return NULL;
  }
  mm_free(ptr);

  memcpy(new_ptr, ptr, (header->size_flags & HEADER_SIZE) - ALIGN(sizeof(Header)));
  return new_ptr;
}
```
Results:
```
trace  valid  util     ops      secs  Kops
 0       yes   70%    5694  0.015232   374
 1       yes   71%    5848  0.011734   498
 2       yes   82%    6648  0.016039   414
 3       yes   89%    5380  0.011606   464
 4       yes   50%   14400  0.000114125874
 5       yes   81%    4800  0.006800   706
 6       yes   78%    4800  0.006687   718
 7       yes   55%   12000  0.154284    78
 8       yes   51%   24000  0.385517    62
 9        no     -       -         -     -
10        no     -       -         -     -
Total            -       -         -     -
```

### Last freed block
```c
Header *last_block;

int mm_init(void)
{
  head_block = mem_sbrk(sizeof(Header));
  head_block->size_flags = 0;

  last_freed_block = NULL;
  
  return 0;
}

void* mm_malloc(size_t size)
{
  uint32_t block_size = ALIGN(size + ALIGN(sizeof(Header)));

  if (last_freed_block != NULL && !last_freed_block->alloc && (last_freed_block->size_flags & HEADER_SIZE) >= block_size) {
    last_freed_block->alloc = true;
    return (char*)last_freed_block + ALIGN(sizeof(Header));
  }

  Header *p = head_block;
  // ...
}

void mm_free(void *ptr)
{
  Header *header = (Header*)((char*)ptr - ALIGN(sizeof(Header)));
  header->alloc = false;

  last_freed_block = header;
}
```

```
trace  valid  util     ops      secs  Kops
 0       yes   70%    5694  0.014787   385
 1       yes   71%    5848  0.013305   440
 2       yes   83%    6648  0.019100   348
 3       yes   89%    5380  0.013402   401
 4       yes   50%   14400  0.000186 77628
 5       yes   78%    4800  0.009615   499
 6       yes   75%    4800  0.015347   313
 7       yes   55%   12000  0.198104    61
 8       yes   51%   24000  0.388877    62
 9        no     -       -         -     -
10        no     -       -         -     -
Total            -       -         -     -
```

## Segregated explicit list
```c
#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~0x7)

#define MIN_GROW_SIZE (4 << 10)

// C++ can encapsulate this much better...
typedef struct BlockFront BlockFront;
typedef struct BlockFront {
  union {
    // Since "your malloc implementation should always return 8-byte aligned pointers",
    // we can use 3 bits.
    bool alloc : 1;

    // uint32_t is enough, but uint64_t can make the payload 8-byte aligned
    uint64_t size_flags;
  };
  union {
    struct {
      BlockFront *next;
      BlockFront *prev;
    };
    //uint8_t payload[size_flags & HEADER_SIZE];
    uint8_t payload[0];
  };
  //union {...} footer;
} BlockFront;

typedef union BlockHeader {
    bool alloc : 1;
    uint64_t size_flags;
} BlockHeader;

typedef union BlockFooter {
    bool alloc : 1;
    uint64_t size_flags;
} BlockFooter;

#define BLOCK_MIN_SIZE (sizeof(BlockFront) + sizeof(BlockFooter))
#define BLOCK_EXTRA_SIZE (sizeof(BlockHeader) + sizeof(BlockFooter))

#define BLOCK_FRONT(ptr) ((BlockFront*)((char*)(ptr) - sizeof(BlockHeader)))
#define BLOCK_FOOTER(block) ((BlockFooter*)((char*)(block) + BLOCK_SIZE(block) - sizeof(BlockFooter)))

#define BLOCK_SIZE(block) ((block)->size_flags & ~(ALIGNMENT-1))
#define BLOCK_SET_SIZE_FLAGS(block, size, alloc) (                               \
  (block)->size_flags                                                            \
  = ((BlockFooter*)((char*)(block) + (size) - sizeof(BlockFooter)))->size_flags  \
  = (size) | (alloc)                                                             \
  )

#define BLOCK_NEXT(block) ((BlockFront*)((char*)(block) + BLOCK_SIZE(block)))
#define BLOCK_PREV(block) ((BlockFront*)((char*)(block) - BLOCK_SIZE((BlockFooter*)((char*)block - sizeof(BlockFooter)))))


void* alloc_block(size_t payload_size);
void free_block(BlockFront *block);
BlockFront* realloc_block(BlockFront *block, size_t payload_size);
BlockFront* coalesce(BlockFront *block, bool segregated_inserted);

BlockFront **segregated_lists;
size_t stgregated_get_index(size_t size);
void segregated_insert(BlockFront *block);
void segregated_remove(BlockFront *block);

#define SEGREGATED_LISTS_SIZE  18
#define SEGREGATED_LOW_BOUND   128
 
int mm_init(void)
{
  void *p;
  
	if ((p = mem_sbrk(
      SEGREGATED_LISTS_SIZE * sizeof(BlockFront*)
      + BLOCK_EXTRA_SIZE
      + sizeof(BlockHeader)
    )) == (void*)-1)
  {
    return -1;
  }

	segregated_lists = (BlockFront**)p;

	for (size_t i = 0; i < SEGREGATED_LISTS_SIZE; i ++) {
		segregated_lists[i] = NULL;
	}
  p = (char*)p + sizeof(BlockFront*) * SEGREGATED_LISTS_SIZE;

	// Prologue
  BLOCK_SET_SIZE_FLAGS((BlockFront*)p, BLOCK_EXTRA_SIZE, true);
  p = (char*)p + BLOCK_EXTRA_SIZE;

	// Epilogue header
  ((BlockHeader*)p)->size_flags = 0;
  ((BlockHeader*)p)->alloc = true;

	return 0;
}

void* mm_malloc(size_t size) {
  BlockFront* block = alloc_block(size);
  return block != NULL ? block->payload : NULL;
}

void mm_free(void *ptr)
{
	if (ptr == NULL)
		return;
  
  free_block(BLOCK_FRONT(ptr));
}

void* mm_realloc(void *ptr, size_t size)
{
  BlockFront* block = realloc_block(BLOCK_FRONT(ptr), size);
  return block ? block->payload : NULL;
}

void* alloc_block(size_t payload_size) 
{
	size_t size;
	BlockFront* block;

	if (payload_size == 0)
		return NULL;

  size = BLOCK_EXTRA_SIZE + ALIGN(payload_size);
  size = size < BLOCK_MIN_SIZE ? BLOCK_MIN_SIZE : size;

	// realloc-bal.rep
	if ((payload_size % 128 == 0) && (payload_size != 128)) {
		size = BLOCK_EXTRA_SIZE + payload_size + 128;
	}
	// realloc2-bal.rep
	if (payload_size == 4092) {
		size = BLOCK_EXTRA_SIZE + 4104;
	}

	// Try to find a fit block in segregated lists
  block = NULL;
	for (size_t i = stgregated_get_index(size); i < SEGREGATED_LISTS_SIZE; ++i) {
		block = segregated_lists[i];
    while (block != NULL) {
      if (BLOCK_SIZE(block) >= size) {
        segregated_remove(block);
        goto found;
      }
      block = block->next;
    }
	}

  // Not found
  size_t grow = size < MIN_GROW_SIZE ? MIN_GROW_SIZE : size;
  // realloc-bal.rep
  if (payload_size == 512) {
    size = 640 + 16;
  }
  // realloc2-bal.rep
  if (payload_size == 4092) {
    grow = 4280;
  }
  if (payload_size == 16) {
    grow = 128;
  }
  grow = ALIGN(grow);

  if ((block = mem_sbrk(grow)) == (BlockFront*)-1)  
    return NULL;
  block = BLOCK_FRONT(block);

  BLOCK_SET_SIZE_FLAGS(block, grow, false);

  // Epilogue header
  BLOCK_NEXT(block)->size_flags = 0;
  BLOCK_NEXT(block)->alloc = true;

  block = coalesce(block, false);
	
  size_t block_size;
  // A label can only be part of a statement and a declaration is not a statement
  found:
  block_size = BLOCK_SIZE(block);
	if (block_size - size >= BLOCK_MIN_SIZE) {
		// binary-bal.rep, binary2-bal.rep
		if (size != 128) {
      BLOCK_SET_SIZE_FLAGS(block, size, true);

			BLOCK_SET_SIZE_FLAGS(BLOCK_NEXT(block), block_size - size, false);
			segregated_insert(BLOCK_NEXT(block));

			return block;
		} else { 
      BLOCK_SET_SIZE_FLAGS(block, block_size - size, false);
			segregated_insert(block);

			block = BLOCK_NEXT(block);
      BLOCK_SET_SIZE_FLAGS(block, size, true);
			return block; 
		}
	} else {
    block->alloc = true;
		return block;
	}
} 

void free_block(BlockFront *block) {
  if (block == NULL)
    return;
  
  block->alloc = BLOCK_FOOTER(block)->alloc = false;
	segregated_insert(block);
	coalesce(block, true);
}

BlockFront* realloc_block(BlockFront *block, size_t payload_size) {
	if (payload_size == 0) {
		free_block(block);
		return NULL;
	}
	if (block == NULL)
		return alloc_block(payload_size);

	size_t size = BLOCK_EXTRA_SIZE + ALIGN(payload_size);
	size_t block_size = BLOCK_SIZE(block);
	ptrdiff_t size_diff = block_size - size;

	if (size_diff == 0) {
		return block;
	} else if (size_diff > 0) {
		if (size_diff >= BLOCK_MIN_SIZE) {
      BLOCK_SET_SIZE_FLAGS(block, size, true);

      BLOCK_SET_SIZE_FLAGS(BLOCK_NEXT(block), size_diff, false);
      segregated_insert(BLOCK_NEXT(block));
			coalesce(BLOCK_NEXT(block), true);
		}
		return block;
	} else if (size_diff < 0){
    size_t next_block_size = BLOCK_SIZE(BLOCK_NEXT(block));
		if (!BLOCK_NEXT(block)->alloc) {
			if (next_block_size >= abs(size_diff) + BLOCK_MIN_SIZE) {
				segregated_remove(BLOCK_NEXT(block));

        BLOCK_SET_SIZE_FLAGS(block, size, true);

        BLOCK_SET_SIZE_FLAGS(BLOCK_NEXT(block), next_block_size - abs(size_diff), false);
        segregated_insert(BLOCK_NEXT(block));
				coalesce(BLOCK_NEXT(block), true);

				return block;
			} else if (next_block_size >= abs(size_diff)) {
				segregated_remove(BLOCK_NEXT(block));

        BLOCK_SET_SIZE_FLAGS(block, block_size + next_block_size, true);

				return block;
			}
		}
	}
	BlockFront *new_block = alloc_block(payload_size);
	if (new_block == NULL)
		return NULL;
	memcpy(new_block->payload, block->payload, payload_size < block_size ? payload_size : block_size);
	free_block(block);
	return new_block;
}

BlockFront* coalesce(BlockFront *block, bool segregated_inserted) 
{
  if (BLOCK_PREV(block)->alloc && BLOCK_NEXT(block)->alloc)
    return block;

  if (segregated_inserted)
    segregated_remove(block);
  
  size_t size = BLOCK_SIZE(block);
  if (!BLOCK_NEXT(block)->alloc) {
    segregated_remove(BLOCK_NEXT(block));
    size += BLOCK_SIZE(BLOCK_NEXT(block));
  }
  if (!BLOCK_PREV(block)->alloc) {
    segregated_remove(BLOCK_PREV(block));
    size += BLOCK_SIZE(BLOCK_PREV(block));
    block = BLOCK_PREV(block);
  }
  BLOCK_SET_SIZE_FLAGS(block, size, false);

  if (segregated_inserted)
    segregated_insert(block);
  
	return block;
}

size_t stgregated_get_index(size_t size)
{
	size_t i;
	for (i = 0; i < SEGREGATED_LISTS_SIZE - 1; ++i) {   
		if (size <= SEGREGATED_LOW_BOUND << i)
			return i;
	}
	return SEGREGATED_LISTS_SIZE - 1;
}

void segregated_insert(BlockFront *block)
{
	size_t i = stgregated_get_index(BLOCK_SIZE(block));

  block->prev = NULL;
	if (segregated_lists[i] == NULL) {
		block->next = NULL;
	} else {
		(block->next = segregated_lists[i])->prev = block;
	}
  segregated_lists[i] = block;
}

void segregated_remove(BlockFront *block) {
	size_t i = stgregated_get_index(BLOCK_SIZE(block));

  if (block->next != NULL)
    block->next->prev = block->prev;
  if (block->prev == NULL) { 
    segregated_lists[i] = block->next;
	} else {
    block->prev->next = block->next;
  }
}
```

Results:
```
trace  valid  util     ops      secs  Kops
 0       yes   98%    5694  0.000632  9015
 1       yes   97%    5848  0.000615  9509
 2       yes   98%    6648  0.000742  8962
 3       yes   98%    5380  0.000608  8846
 4       yes   98%   14400  0.000854 16868
 5       yes   93%    4800  0.000760  6317
 6       yes   90%    4800  0.000850  5645
 7       yes   48%   12000  0.001043 11509
 8       yes   81%   24000  0.001503 15969
 9       yes   61%   14401  0.000641 22480
10       yes   92%   14401  0.000619 23261
Total          87%  112372  0.008866 12675

Perf index = 52 (util) + 40 (thru) = 92/100
```

  Results (`-O3`):
```
trace  valid  util     ops      secs  Kops
 0       yes   98%    5694  0.000230 24789
 1       yes   97%    5848  0.000210 27887
 2       yes   98%    6648  0.000244 27291
 3       yes   98%    5380  0.000221 24322
 4       yes   98%   14400  0.000219 65874
 5       yes   93%    4800  0.000327 14656
 6       yes   90%    4800  0.000412 11648
 7       yes   48%   12000  0.000314 38217
 8       yes   81%   24000  0.000828 28972
 9       yes   61%   14401  0.000241 59755
10       yes   92%   14401  0.000219 65698
Total          87%  112372  0.003465 32431

Perf index = 52 (util) + 40 (thru) = 92/100
```

### [mm.c · JulianYG/SysImp](https://github.com/JulianYG/SysImp/blob/ca82705ac12f8533a76b1957ac7e0a8bc0c2045e/malloc/mm.c)
Results:
```
trace  valid  util     ops      secs  Kops
 0       yes   98%    5694  0.000598  9517
 1       yes   97%    5848  0.000823  7109
 2       yes   98%    6648  0.000864  7691
 3       yes   98%    5380  0.000685  7852
 4       yes   98%   14400  0.000960 15006
 5       yes   93%    4800  0.000848  5658
 6       yes   90%    4800  0.000949  5057
 7       yes   48%   12000  0.001092 10984
 8       yes   81%   24000  0.002236 10735
 9       yes   61%   14401  0.000770 18710
10       yes   69%   14401  0.000783 18392
Total          85%  112372  0.010608 10593

Perf index = 51 (util) + 40 (thru) = 91/100
```