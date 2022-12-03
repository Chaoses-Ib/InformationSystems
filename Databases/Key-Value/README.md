# Key-Value Databases
A **key–value database (key–value store)** is a data storage paradigm designed for storing, retrieving, and managing associative arrays, and a data structure more commonly known today as a dictionary or hash table. Dictionaries contain a collection of objects, or **records**, which in turn have many different fields within them, each containing data. These records are stored and retrieved using a **key** that uniquely identifies the record, and is used to find the data within the database.[^wiki]

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

## Benchmarks
- [LMDB: On-Disk Microbenchmark](https://web.archive.org/web/20141209233807/http://symas.com/mdb/ondisk/)
- [LMDB: In-Memory Microbenchmark](https://web.archive.org/web/20141209233002/http://symas.com/mdb/inmem/)
- [redb: Benchmarks](https://github.com/cberner/redb#benchmarks)
- [Sanakirja: Benchmarks](https://pijul.org/posts/2021-02-06-rethinking-sanakirja/#benchmarks)

[^wiki]: [Key–value database - Wikipedia](https://en.wikipedia.org/wiki/Key%E2%80%93value_database)