# Compression
- [VACUUM](https://www.sqlite.org/lang_vacuum.html)
- VFSs
  - [Zipvfs](https://www.sqlite.org/zipvfs/doc/trunk/www/readme.wiki) (paid)
  - [sqlite\_zstd\_vfs: SQLite3 extension for read/write storage compression with Zstandard](https://github.com/mlin/sqlite_zstd_vfs)
    - [Windows](https://github.com/voltagex-forks/sqlite_zstd_vfs)
  - [CEVFS: Compression & Encryption VFS for SQLite 3](https://github.com/techrah/sqlite3-compression-encryption-vfs)
- [sqlite-zstd: Transparent dictionary-based row-level compression for SQLite](https://github.com/phiresky/sqlite-zstd) ([Hacker News](https://news.ycombinator.com/item?id=32303762))

  [sqlite-zstd: Transparent dictionary-based row-level compression for SQLite - An sqlite extension written in Rust to reduce the database size without losing functionality - phiresky's blog](https://phiresky.github.io/blog/2022/sqlite-zstd/)

  ![](https://github.com/phiresky/sqlite-zstd/raw/master/doc/2022-07-31-19-27-57.png)

  [Comparison to compression VFS - Issue #9 - phiresky/sqlite-zstd](https://github.com/phiresky/sqlite-zstd/issues/9)
  - 相比 VFS 实现可以自定义要压缩的列和压缩配置。

  虽然声称是透明压缩，但透明度不如 VFS 实现，并且质量上也存在一些问题：
  - [Make usable as a crate - Issue #35 - phiresky/sqlite-zstd](https://github.com/phiresky/sqlite-zstd/issues/35)
  - [Reexport rusqlite, please - Issue #27 - phiresky/sqlite-zstd](https://github.com/phiresky/sqlite-zstd/issues/27)

- [sqlite-compressions: Compression, decompression, and testing functions for SQLite: gzip, brotli, ...](https://github.com/nyurik/sqlite-compressions)