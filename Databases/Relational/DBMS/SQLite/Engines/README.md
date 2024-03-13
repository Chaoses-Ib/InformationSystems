# Storage Engines
[SQLite4: Pluggable Storage Engine](https://sqlite.org/src4/doc/trunk/www/storage.wiki)

[SQLite Forum: Native support for pluggable backends in SQLite](https://sqlite.org/forum/forumpost/3b12692d93850552)

## Engines
- In-memory binary tree storage engine
- [LSM](https://sqlite.org/src4/doc/trunk/www/lsmusr.wiki)

  [SQLite4: LSM Benchmarks](https://sqlite.org/src4/doc/trunk/www/lsmperf.wiki)

  [charles leifer | LSM Key/Value Storage in SQLite3](https://charlesleifer.com/blog/lsm-key-value-storage-in-sqlite3/)

  Rust: [lsmlite-rs: Rust bindings for SQLite's lsm1 extension in stand-alone manner.](https://github.com/helsing-ai/lsmlite-rs)

Others:
- [LMDB/sqlightning: SQLite3 ported to use LMDB instead of its original Btree code.](https://github.com/LMDB/sqlightning) (discontinued)
  - [LumoSQL: Official Github Mirror of the LumoSQL Database Project](https://github.com/LumoSQL/LumoSQL)
- [SQLHeavy: SQLite ported to LevelDB, LMDB, RocksDB, and anything else you can imagine](https://github.com/btrask/sqlheavy) (discontinued)