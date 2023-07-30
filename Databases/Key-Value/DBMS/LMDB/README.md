# [Lightning Memory-Mapped Database](https://www.symas.com/lmdb)
[GitLab](https://git.openldap.org/openldap/openldap/), [GitHub](https://github.com/LMDB/lmdb), [Wikipedia](https://en.wikipedia.org/wiki/Lightning_Memory-Mapped_Database)

LMDB 由商业公司 Symas 维护，在 Shopify 的生产系统中有使用。

[Documentation](http://www.lmdb.tech/doc/index.html):
- [Getting Started](http://www.lmdb.tech/doc/starting.html)
- [API](http://www.lmdb.tech/doc/group__mdb.html)

特性：
- 支持并行读取，但不支持并行写入。
- 写事务开销较大，单条写入性能很低。如果数据更新的频率较高，应尽量合并写入。

## Bindings
- Rust: [heed](https://docs.rs/heed) ([GitHub](https://github.com/meilisearch/heed))

  Note that the environment won't be closed by `drop()`, see [Close environment safely](https://github.com/meilisearch/heed/pull/64) for details.

## Database sizes
[Symas OpenLDAP Knowledge Base - LMDB Database File Sizes and Memory Utilization](https://kb.symas.com/lmdb-database-file-sizes-and-memory-utilization.html)

[mdb_env_set_mapsize()](http://www.lmdb.tech/doc/group__mdb.html#gaa2506ec8dab3d969b0e609cd82e619e5)

由于 LMDB 是基于内存映射文件实现的，无法动态调整数据库容量，只能在关闭所有连接后重新打开数据库来调整容量。这意味着如果在批量插入数据时容量耗尽，就必须放弃之前插入的所有数据，在调整容量后从头开始插入，大幅增加插入耗时。

尽管 NTFS 支持稀疏文件，但 LMDB 在 Windows 上的实现[并不支持使用稀疏文件](https://github.com/lmdbjava/lmdbjava/issues/126)，如果想要较小的硬盘占用，就不能通过预留大量空间的方法来避免这一问题，而是需要在插入大量数据前对容量增幅进行超量预估，并进行相应调整。