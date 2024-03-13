# Key-Value Databases
A **key–value database (key–value store)** is a data storage paradigm designed for storing, retrieving, and managing associative arrays, and a data structure more commonly known today as a dictionary or hash table. Dictionaries contain a collection of objects, or **records**, which in turn have many different fields within them, each containing data. These records are stored and retrieved using a **key** that uniquely identifies the record, and is used to find the data within the database.[^wiki]

[What's the big deal about key-value databases like FoundationDB and RocksDB? | notes.eatonphil.com](https://notes.eatonphil.com/whats-the-big-deal-about-key-value-databases.html)
- [What's the big deal about embedded key-value databases like RocksDB? | Lobsters](https://lobste.rs/s/avljlh/what_s_big_deal_about_embedded_key_value)

[Intro into database storage engines](https://sergeiturukin.com/2017/06/07/storage-engine-introduction.html)

[TiKV | B-Tree vs LSM-Tree](https://tikv.org/deep-dive/key-value-engine/b-tree-vs-lsm/)
- The main purpose for TiKV to use LSM-tree instead of B-tree as its underlying storage engine is because using cache technology to promote read performance is much easier than promote write performance.

[Btree vs LSM · wiredtiger/wiredtiger Wiki](https://github.com/wiredtiger/wiredtiger/wiki/Btree-vs-LSM)

## Implementations
- [LevelDB](DBMS/LevelDB/README.md)
  - [RocksDB](DBMS/LevelDB/RocksDB/README.md)
- [Lightning Memory-Mapped Database](DBMS/LMDB/README.md)
  - [libmdbx](DBMS/LMDB/libmdbx.md)
- [Sanakirja](https://docs.rs/sanakirja/)

  [Pijul - Rethinking Sanakirja](https://pijul.org/posts/2021-02-06-rethinking-sanakirja/)
- [redb](https://github.com/cberner/redb)

  A simple, portable, high-performance, ACID, embedded key-value store.
- [sled](https://sled.rs/) ([GitHub](https://github.com/spacejam/sled))

  数据库体积相对较大。
  - [kv: An embedded key/value store for Rust](https://github.com/zshipko/rust-kv)
- [Lucid KV](https://clintnetwork.gitbook.io/lucid/) ([GitHub](https://github.com/lucid-kv/lucid))

  Lucid is a high performance, secure and distributed key-value store accessible through an HTTP API, that is built around a modular configuration to enable features on the fly, like persistence, encryption SSE, compression, replication, and more.

[Design Review: Key-Value Storage | Hacker News](https://news.ycombinator.com/item?id=18410597)

[I like LMDB, but why does ~most sql/nosql use LSM/rocksdb compared to it ? At le... | Hacker News](https://news.ycombinator.com/item?id=18426233)

[What kev level database is everyone using? leveldb? rockdsb? : rust](https://www.reddit.com/r/rust/comments/fvudme/what_kev_level_database_is_everyone_using_leveldb/)

[LMDB vs. LevelDB](https://mozilla.github.io/firefox-browser-architecture/text/0017-lmdb-vs-leveldb.html)

## Benchmarks
- [LMDB: On-Disk Microbenchmark](https://web.archive.org/web/20141209233807/http://symas.com/mdb/ondisk/)
- [LMDB: In-Memory Microbenchmark](https://web.archive.org/web/20141209233002/http://symas.com/mdb/inmem/)
- [redb: Benchmarks](https://github.com/cberner/redb#benchmarks)
- [Sanakirja: Benchmarks](https://pijul.org/posts/2021-02-06-rethinking-sanakirja/#benchmarks)
- [Badger vs LMDB vs BoltDB: Benchmarking key-value databases in Go - Dgraph Blog](https://dgraph.io/blog/post/badger-lmdb-boltdb/)
- [LmdbJava Benchmarks: Benchmark of open source, embedded, memory-mapped, key-value stores available from Java (JMH)](https://github.com/lmdbjava/benchmarks)

## Tools
- [EDMA: an interactive terminal app for managing multiple embedded databases system at once with powerful byte deserializer support.](https://github.com/nomadiz/edma)


[^wiki]: [Key–value database - Wikipedia](https://en.wikipedia.org/wiki/Key%E2%80%93value_database)