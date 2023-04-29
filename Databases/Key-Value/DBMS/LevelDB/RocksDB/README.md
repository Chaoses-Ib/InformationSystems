# [RocksDB](http://rocksdb.org/)
[GitHub](https://github.com/facebook/rocksdb)

RocksDB 是 Google 已停止开发的 LevelDB 的一个分支，由 Meta 维护。RocksDB 有较为成熟的商业应用，在 Meta、[Netflix](https://netflixtechblog.com/application-data-caching-using-ssds-5bf25df851ef)、Uber、Yahoo! 和 LinkedIn 的生产系统中都有使用。

RocksDB 的功能很丰富，可以灵活适应各种不同的应用场景，同时保持高性能和高可靠性。

[rocksdbbook](https://zhangyuchi.gitbooks.io/rocksdbbook/content/Home.html)

[RocksDB Is Eating the Database World | Rockset](https://rockset.com/blog/rocksdb-is-eating-the-database-world/)

## Bindings
- Rust: [rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb)

## Key space
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

[Can't drop default column family · Issue #10138 · facebook/rocksdb](https://github.com/facebook/rocksdb/issues/10138)

### Prefixes
- [Prefix Seek](https://github.com/facebook/rocksdb/wiki/Prefix-Seek)

## Read
- [Block cache](https://github.com/facebook/rocksdb/wiki/Block-Cache)

  [Small Datum: Tuning the RocksDB block cache](http://smalldatum.blogspot.com/2016/09/tuning-rocksdb-block-cache.html)
- [allow_mmap_reads](https://github.com/facebook/rocksdb/issues/507)
- [PinnableSlice](http://rocksdb.org/blog/2017/08/24/pinnableslice.html)
- [MultiGet](https://github.com/facebook/rocksdb/wiki/MultiGet-Performance)
- Compression
- 并行
- [cache_index_and_filter_blocks](https://groups.google.com/g/rocksdb/c/jMkcGQ0VZsY)
- [Direct I/O](https://github.com/facebook/rocksdb/wiki/Direct-IO)
- Read ahead
- [PlainTable](https://github.com/facebook/rocksdb/wiki/PlainTable-Format)

### Point lookup
- [Bloom filters](https://github.com/facebook/rocksdb/wiki/Setup-Options-and-Basic-Tuning#bloom-filters)
- [Block hash index](https://rocksdb.org/blog/2018/08/23/data-block-hash-index.html)

### Scanning
- [Iterator](https://github.com/facebook/rocksdb/wiki/Iterator)

  [Iterator Implementation](https://github.com/facebook/rocksdb/wiki/Iterator-Implementation)
- pin_data
- fill_cache

## Write
- [WriteBatch](https://github.com/facebook/rocksdb/wiki/Basic-Operations#atomic-updates)
- Transactions

  [Transactions · rocksdbbook](https://zhangyuchi.gitbooks.io/rocksdbbook/content/Transactions.html)

  [Rocksdb transactions - SoByte](https://www.sobyte.net/post/2022-01/rocksdb-tx/)
  
- allow_mmap_writes
- 并行

[Optimizing Bulk Load in RocksDB | Rockset](https://rockset.com/blog/optimizing-bulk-load-in-rocksdb/)

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
