# [RocksDB](http://rocksdb.org/)
[GitHub](https://github.com/facebook/rocksdb)

RocksDB 是 Google 已停止开发的 LevelDB 的一个分支，由 Meta 维护。RocksDB 有较为成熟的商业应用，在 Meta、Netflix、Uber、Yahoo! 和 LinkedIn 的生产系统中都有使用。

RocksDB 的功能很丰富，可以灵活适应各种不同的应用场景，同时保持高性能和高可靠性。

[RocksDB Is Eating the Database World | Rockset](https://rockset.com/blog/rocksdb-is-eating-the-database-world/)

## Bindings
- Rust: [rust-rocksdb](https://github.com/rust-rocksdb/rust-rocksdb)

## Bulk query
- [Block cache](https://github.com/facebook/rocksdb/wiki/Block-Cache)

  [Small Datum: Tuning the RocksDB block cache](http://smalldatum.blogspot.com/2016/09/tuning-rocksdb-block-cache.html)
- [allow_mmap_reads](https://github.com/facebook/rocksdb/issues/507)
- [PinnableSlice](http://rocksdb.org/blog/2017/08/24/pinnableslice.html)
- [MultiGet](https://github.com/facebook/rocksdb/wiki/MultiGet-Performance)
- 并行

[Optimizing Bulk Load in RocksDB | Rockset](https://rockset.com/blog/optimizing-bulk-load-in-rocksdb/)

## Bulk insert
- [WriteBatch](https://github.com/facebook/rocksdb/wiki/Basic-Operations#atomic-updates)
- allow_mmap_writes
- 并行

## In-memory database
RocksDB 同时支持 on-desk database 和 in-memory database，并且还可以对 in-memory database 可靠地进行持久化。

然而，RocksDB 的 in-memory database [依赖 tmpfs/ramfs](https://github.com/facebook/rocksdb/issues/618)，这意味着在 Windows 无法将直接使用 in-memory database。但奇怪的是，RocksDB-Cloud 的 [Microsoft Contribution Notes](https://github.com/rockset/rocksdb-cloud/blob/master/WINDOWS_PORT.md) 中又若无其事地在 Windows 上进行了 in-memory benchmark。

[How to persist in-memory RocksDB database? | RocksDB](http://rocksdb.org/blog/2014/03/27/how-to-persist-in-memory-rocksdb-database.html)