# [RocksDB](http://rocksdb.org/)
[GitHub](https://github.com/facebook/rocksdb), [Wiki](https://github.com/facebook/rocksdb/wiki)

[How RocksDB works - Artem Krylysov](https://artem.krylysov.com/blog/2023/04/19/how-rocksdb-works/)
- [How RocksDB Works | Hacker News](https://news.ycombinator.com/item?id=35634673)

RocksDB 是 Google 已停止开发的 LevelDB 的一个分支，由 Meta 维护。RocksDB 有较为成熟的商业应用，在 Meta、[Netflix](https://netflixtechblog.com/application-data-caching-using-ssds-5bf25df851ef)、Uber、Yahoo! 和 LinkedIn 的生产系统中都有使用。See [RocksDB Users and Use Cases](https://github.com/facebook/rocksdb/wiki/RocksDB-Users-and-Use-Cases) for details.

RocksDB 的功能很丰富，可以灵活适应各种不同的应用场景，同时保持高性能和高可靠性。

[rocksdbbook](https://zhangyuchi.gitbooks.io/rocksdbbook/content/Home.html)

[RocksDB Is Eating the Database World | Rockset](https://rockset.com/blog/rocksdb-is-eating-the-database-world/)

[RocksDB Overview | PingCAP Docs](https://docs.pingcap.com/tidb/dev/rocksdb-overview)

## Static sorted tables
### Block-based tables
[Index block](https://github.com/facebook/rocksdb/wiki/Index-Block-Format):
- [Partitioned index/filters](https://rocksdb.org/blog/2017/05/12/partitioned-index-filter.html)

Data block:
- [Block size](https://github.com/facebook/rocksdb/wiki/Basic-Operations#block-size)

  The default block size is approximately 4096 uncompressed bytes. Applications that mostly do bulk scans over the contents of the database may wish to increase this size. Applications that do a lot of point reads of small values may wish to switch to a smaller block size if performance measurements indicate an improvement. There isn't much benefit in using blocks smaller than one kilobyte, or larger than a few megabytes.

- Delta encoding

  `use_delta_encoding`

- [Data block hash index](https://github.com/facebook/rocksdb/wiki/Data-Block-Hash-Index)

  [Improving Point-Lookup Using Data Block Hash Index | RocksDB](https://rocksdb.org/blog/2018/08/23/data-block-hash-index.html)

- Checksums

  [Per Key-Value Checksum | RocksDB](https://rocksdb.org/blog/2022/07/18/per-key-value-checksum.html)

[Block cache](https://github.com/facebook/rocksdb/wiki/Block-Cache):
- [cache_index_and_filter_blocks](https://groups.google.com/g/rocksdb/c/jMkcGQ0VZsY)
- [Small Datum: Tuning the RocksDB block cache](http://smalldatum.blogspot.com/2016/09/tuning-rocksdb-block-cache.html)

### Plain tables
[PlainTable](https://github.com/facebook/rocksdb/wiki/PlainTable-Format)
- [PlainTable — A New File Format | RocksDB](https://rocksdb.org/blog/2014/06/23/plaintable-a-new-file-format.html)

## [Compaction](https://github.com/facebook/rocksdb/wiki/Compaction)
[Speedb | Understanding RocksDB Leveled Compaction](https://www.speedb.io/blog-posts/understanding-leveled-compaction)
- There can be multiple versions of a key at L0 because the SST files at L0 are stored in the order they are generated. 
- The compaction background process will be triggered when the number of files in L0 reaches the threshold in the `level0_file_num_compaction_trigger` setting (defaults to `4`). This moves one or more SST files from L0 by compacting and writing the data to L1.
- You can also set a periodic compaction to trigger by period of time rather than just when L0 is flushed down to L1 using the `options.periodic_compaction_seconds` setting. The default setting is `UINT64_MAX – 1` which lets RocksDB control the period. RocksDB defaults to 30 days and can be configured to not run at all by configuring the setting to 0. 

Options:
- 默认 L0 是 64 MiB，`target_file_size_base` 是 64 MiB，`target_file_size_multiplier` 是 1，因此所有 SST 都是 64 MiB，无法直接区分。
- 默认 `level0_file_num_compaction_trigger` 是 4，`max_bytes_for_level_base` 是 256 MiB，`max_bytes_for_level_multiplier` 是 10，因此 L0 和 L1 都最多有 4 个文件，而 L2 最多有 40 个。

[Manual Compaction · facebook/rocksdb Wiki](https://github.com/facebook/rocksdb/wiki/Manual-Compaction)
- TransactionDB 不支持 manual compaction。

## Keys
- RocksDB 默认使用字典序对 key 进行排序，为了提高空间局部性，应当让局部数据尽可能拥有前端相同的 key。

  如果使用数值作为 key，就是让局部数据拥有接近的 key 值，同时使用**大端序**来序列化 key。

  [\[KAFKA-12314\] Leverage custom comparator for optimized range scans on RocksDB - ASF JIRA](https://issues.apache.org/jira/browse/KAFKA-12314)
  
- Key spaces
  
  RocksDB 对于需要多个 key space 的需求提供了三种方案：
  - Column families
  - Prefixes
  - 多个 DB

### [Column families](https://github.com/facebook/rocksdb/wiki/Column-Families)
- What are column families used for?
  
  The most common reasons of using column families:
  - Use different compaction setting, comparators, compression types, merge operators, or compaction filters in different parts of data.
  - Drop a column family to delete its data.
  - One column family to store metadata and another one to store the data.

- What's the difference between storing data in multiple column family and in multiple rocksdb database?

  The main differences will be backup, atomic writes and performance of writes. The advantage of using multiple databases: database is the unit of backup or checkpoint. It's easier to copy a database to another host than a column family. Advantages of using multiple column families:
  - Write batches are atomic across multiple column families on one database. You can't achieve this using multiple RocksDB databases
  - If you issue sync writes to WAL, too many databases may hurt the performance.

- I have different key spaces. Should I separate them using prefixes, or use different column families?

  If each key space is reasonably large, it's a good idea to put them in different column families. If it can be small, then you should consider to pack multiple key spaces into one column family, to avoid the trouble of maintaining too many column families.

尽管未在文档中进行说明，column family 的 name 对字符没有特殊限制，只要不含 `\0` 就是有效的。

需要注意的是，在以 read-write 模式打开含有多个 column families 的 DB 时，需要手动指定所有 column families；不过 read 模式不需要这样做，因此可以先以 read 模式打开 DB，枚举 column families，再重新以 read-write 模式打开。一些 binding 针对这一问题提供了直接枚举 column families 的封装，例如 [rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/issues/608)。

[MySQL · RocksDB · Column Family介绍 | pagefault](https://www.pagefault.info/2018/06/06/mysql-%C2%B7-rocksdb-introduction-to-column-family.html)

[Can't drop default column family · Issue #10138 · facebook/rocksdb](https://github.com/facebook/rocksdb/issues/10138)

### Prefixes
- [Prefix Seek](https://github.com/facebook/rocksdb/wiki/Prefix-Seek)

## Read
- [allow_mmap_reads](https://github.com/facebook/rocksdb/issues/507)
- [PinnableSlice](http://rocksdb.org/blog/2017/08/24/pinnableslice.html)
- [MultiGet](https://github.com/facebook/rocksdb/wiki/MultiGet-Performance)
- Compression
- 并行
- [Direct I/O](https://github.com/facebook/rocksdb/wiki/Direct-IO)
- Read ahead

### Point lookup
- Point lookup 的性能远低于 scan，当 point lookup 的数据量占全部数据的 **~5%** 以上时，scan 所有数据会比 point lookup 更快。
  
  具体比率取决于对 point lookup 做了多少优化：
  - 在不使用 mmap 和 block cache 时，这一比率是 2%；
  - 在使用 mmap 时，这一比率是 4%；
  - 在使用充足的 block cache 时，这一比率是 7%。
  
  而 LMDB 的这一比率是 ~15%。
  
- Compression 对 point lookup 的性能有很大的负面影响。
- OptimizeForPointLookup

  ```cpp
  ColumnFamilyOptions* ColumnFamilyOptions::OptimizeForPointLookup(
    uint64_t block_cache_size_mb) {
    BlockBasedTableOptions block_based_options;
    block_based_options.data_block_index_type =
        BlockBasedTableOptions::kDataBlockBinaryAndHash;
    block_based_options.data_block_hash_table_util_ratio = 0.75;
    block_based_options.filter_policy.reset(NewBloomFilterPolicy(10));
    block_based_options.block_cache =
        NewLRUCache(static_cast<size_t>(block_cache_size_mb * 1024 * 1024));
    table_factory.reset(new BlockBasedTableFactory(block_based_options));
    memtable_prefix_bloom_size_ratio = 0.02;
    memtable_whole_key_filtering = true;
    return this;
  }
  ```

  [OptimizeForPointLookup and iterators · Issue #10135 · facebook/rocksdb](https://github.com/facebook/rocksdb/issues/10135)
- [Bloom filters](https://github.com/facebook/rocksdb/wiki/Setup-Options-and-Basic-Tuning#bloom-filters)

[How can I improve the readrandom performance?](https://groups.google.com/g/rocksdb/c/ahYhGiFxc3I?pli=1)

[Indexing SST Files for Better Lookup Performance | RocksDB](https://rocksdb.org/blog/2014/04/21/indexing-sst-files-for-better-lookup-performance.html)

### Scanning
- [Iterator](https://github.com/facebook/rocksdb/wiki/Iterator)

  [Iterator Implementation](https://github.com/facebook/rocksdb/wiki/Iterator-Implementation)
- pin_data
- fill_cache

[c++11 - Parallelize rocksdb iterator - Stack Overflow](https://stackoverflow.com/questions/40918751/parallelize-rocksdb-iterator)

## Write
- [WriteBatch](https://github.com/facebook/rocksdb/wiki/Basic-Operations#atomic-updates)
- [Write Batch With Index](https://github.com/facebook/rocksdb/wiki/Write-Batch-With-Index)
- [Transactions](https://github.com/facebook/rocksdb/wiki/Transactions)

  TransactionDB 是基于 Write Batch With Index 实现的，有两个不同实现：
  - TransactionDB
  
  - OptimisticTransactionDB

  [Transactions · rocksdbbook](https://zhangyuchi.gitbooks.io/rocksdbbook/content/Transactions.html)

  [Rocksdb transactions - SoByte](https://www.sobyte.net/post/2022-01/rocksdb-tx/)
  
- allow_mmap_writes
- 并行
- [PrepareForBulkLoad](https://github.com/facebook/rocksdb/blob/1567108fc10e50c68f6d9df1223c1c6e2d6aab2e/options/options.cc#L469)

  ```cpp
  // The goal of this method is to create a configuration that
  // allows an application to write all files into L0 and
  // then do a single compaction to output all files into L1.
  Options*
  Options::PrepareForBulkLoad()
  {
    // never slowdown ingest.
    level0_file_num_compaction_trigger = (1<<30);
    level0_slowdown_writes_trigger = (1<<30);
    level0_stop_writes_trigger = (1<<30);
    soft_pending_compaction_bytes_limit = 0;
    hard_pending_compaction_bytes_limit = 0;

    // no auto compactions please. The application should issue a
    // manual compaction after all data is loaded into L0.
    disable_auto_compactions = true;
    // A manual compaction run should pick all files in L0 in
    // a single compaction run.
    max_compaction_bytes = (static_cast<uint64_t>(1) << 60);

    // It is better to have only 2 levels, otherwise a manual
    // compaction would compact at every possible level, thereby
    // increasing the total time needed for compactions.
    num_levels = 2;

    // Need to allow more write buffers to allow more parallism
    // of flushes.
    max_write_buffer_number = 6;
    min_write_buffer_number_to_merge = 1;

    // When compaction is disabled, more parallel flush threads can
    // help with write throughput.
    max_background_flushes = 4;

    // Prevent a memtable flush to automatically promote files
    // to L1. This is helpful so that all files that are
    // input to the manual compaction are all at L0.
    max_background_compactions = 2;

    // The compaction would create large files in L1.
    target_file_size_base = 256 * 1024 * 1024;
    return this;
  }
  ```

[Optimizing Bulk Load in RocksDB | Rockset](https://rockset.com/blog/optimizing-bulk-load-in-rocksdb/)

[Small Datum: Concurrent inserts and the RocksDB memtable](http://smalldatum.blogspot.com/2016/02/concurrent-inserts-and-rocksdb-memtable.html)

[Titan: A RocksDB Plugin to Reduce Write Amplification | PingCAP](https://www.pingcap.com/blog/titan-storage-engine-design-and-implementation/)

## Snapshot
- [Snapshot](https://github.com/facebook/rocksdb/wiki/Snapshot)
- [Checkpoints](https://github.com/facebook/rocksdb/wiki/Checkpoints)

  [Use Checkpoints for Efficient Snapshots | RocksDB](https://rocksdb.org/blog/2015/11/10/use-checkpoints-for-efficient-snapshots.html)

  [\[Help \] What is the difference between backup and checkpoint ? which one will be recommended if I want to do backup restore operation · Issue #6863 · facebook/rocksdb](https://github.com/facebook/rocksdb/issues/6863)

## Compression
[Compression](https://github.com/facebook/rocksdb/wiki/Compression)

[Compressor Microbenchmark: RocksDB](http://www.lmdb.tech/bench/inmem/compress/RocksDB/)

## In-memory database
RocksDB 同时支持 on-desk database 和 in-memory database，并且还可以对 in-memory database 可靠地进行持久化。

然而，RocksDB 的 in-memory database [依赖 tmpfs/ramfs](https://github.com/facebook/rocksdb/issues/618)，这意味着在 Windows 无法将直接使用 in-memory database。但奇怪的是，RocksDB-Cloud 的 [Microsoft Contribution Notes](https://github.com/rockset/rocksdb-cloud/blob/master/WINDOWS_PORT.md) 中又若无其事地在 Windows 上进行了 in-memory benchmark。

[How to persist in-memory RocksDB database? | RocksDB](http://rocksdb.org/blog/2014/03/27/how-to-persist-in-memory-rocksdb-database.html)

## Performance
[Setup Options and Basic Tuning](https://github.com/facebook/rocksdb/wiki/Setup-Options-and-Basic-Tuning)

[RocksDB Tuning Guide](https://github.com/facebook/rocksdb/wiki/RocksDB-Tuning-Guide)

## [Concurrency](https://github.com/facebook/rocksdb/wiki/Basic-Operations#concurrency)
> A database may only be opened by one process at a time. The `rocksdb` implementation acquires a lock from the operating system to prevent misuse. Within a single process, the same `rocksdb::DB` object may be safely shared by multiple concurrent threads. I.e., different threads may write into or fetch iterators or call `Get` on the same database without any external synchronization (the rocksdb implementation will automatically do the required synchronization). However other objects (like Iterator and WriteBatch) may require external synchronization. If two threads share such an object, they must protect access to it using their own locking protocol. More details are available in the public header files.

[`iterator.h`](https://github.com/facebook/rocksdb/blob/9a31b8dd2c293d92fb15524a97b63ded003f53c0/include/rocksdb/iterator.h#L14):
> Multiple threads can invoke const methods on an Iterator without external synchronization, but if any of the threads may call a non-const method, all threads accessing the same Iterator must use external synchronization.

[`ColumnFamilyHandle`](https://github.com/facebook/rocksdb/blob/05c3b8ecac246fd62fb47b4b925af5d587b5ad6d/include/rocksdb/db.h#L78) should be thread-safe, see [`column_family.cc`](https://github.com/facebook/rocksdb/blob/05c3b8ecac246fd62fb47b4b925af5d587b5ad6d/db/column_family.cc) for details.

[General question: thread safety · Issue #15 · iabudiab/ObjectiveRocks](https://github.com/iabudiab/ObjectiveRocks/issues/15#issuecomment-469423210)

## Bindings
- Rust: [rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb)

  Column families:
  - `SingleThreaded` 模式下只能使用 `&ColumnFamily`，同时 `create_cf` 和 `drop_cf` 需要 `&mut DB`，借用限制比较大。

    [Change a column family storing by aleksuss · Pull Request #314 · rust-rocksdb/rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/pull/314)

    [Question: Why do create_cf() and drop_cf() require mutability? · Issue #468 · rust-rocksdb/rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/issues/468)

  - [ColumnFamily is Send but not Sync · Issue #407 · rust-rocksdb/rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/issues/407)
  
  - `MultiThreaded` 模式下只能使用 `Arc<BoundColumnFamily<'a>>`，而 `BoundColumnFamily<'a>` 只支持 `Send`，导致 `Arc<BoundColumnFamily<'a>>` 成了 `!Send + !Sync`。

    [Don't leak dropped column families by ryoqun · Pull Request #509 · rust-rocksdb/rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/pull/509)

    [Implement `AsColumnFamilyRef` for `Arc<Mutex<BoundColumnFamily<'a>>>` · Issue #803 · rust-rocksdb/rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/issues/803)

  [Options, ReadOptions, WriteOptions missing many settings · Issue #260 · rust-rocksdb/rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/issues/260)

  [CompactRange and similar APIs from TransactionDB? · Issue #728 · rust-rocksdb/rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/issues/728)

## Tools
[Administration and Data Access Tool · facebook/rocksdb Wiki](https://github.com/facebook/rocksdb/wiki/Administration-and-Data-Access-Tool):
- ldb

  [RocksDB Administration and Data Access Tool – SHASHANGKA SHEKHAR'S BLOG](https://shashangka.com/2020/06/26/rocksdb-administration-and-data-access-tool/)
- sst_dump

  [Preset Dictionary Compression | RocksDB](https://rocksdb.org/blog/2021/05/31/dictionary-compression.html)

Rust: [RocksDB Administration and Data Access Tool · Issue #781 · rust-rocksdb/rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb/issues/781)

[RocksDB Trace, Replay, Analyzer, and Workload Generation · facebook/rocksdb Wiki](https://github.com/facebook/rocksdb/wiki/RocksDB-Trace%2C-Replay%2C-Analyzer%2C-and-Workload-Generation)

Third-party:
- [EDMA: an interactive terminal app for managing multiple embedded databases system at once with powerful byte deserializer support.](https://github.com/nomadiz/edma)
- [Rocksplicator: RocksDB Replication](https://github.com/pinterest/rocksplicator)