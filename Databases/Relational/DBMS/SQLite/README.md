# [SQLite](https://www.sqlite.org/index.html)
[GitHub](https://github.com/sqlite/sqlite), [Wikiepdia](https://en.wikipedia.org/wiki/SQLite)

[Replacing Elasticsearch with Rust and SQLite](https://nickb.dev/blog/replacing-elasticsearch-with-rust-and-sqlite/)

[Performance/Avoid SQLite In Your Next Firefox Feature - MozillaWiki](https://wiki.mozilla.org/Performance/Avoid_SQLite_In_Your_Next_Firefox_Feature)

[libSQL: A fork of SQLite that is both Open Source, and Open Contributions.](https://github.com/tursodatabase/libsql)

Distributed:
- [rqlite: The lightweight, distributed relational database built on SQLite.](https://github.com/rqlite/rqlite)
- [dqlite: Embeddable, replicated and fault-tolerant SQL engine.](https://github.com/canonical/dqlite)
- [SQLSync: A collaborative offline-first wrapper around SQLite. It is designed to synchronize web application state between users, devices, and the edge.](https://github.com/orbitinghail/sqlsync)
- [cr-sqlite: Convergent, Replicated SQLite. Multi-writer and CRDT support for SQLite](https://github.com/vlcn-io/cr-sqlite)

## The amalgamation
The amalgamation is the recommended way of using SQLite in a larger application.

[The SQLite Amalgamation](https://www.sqlite.org/amalgamation.html)

[SQLite Download Page](https://www.sqlite.org/download.html)

## Bindings
- [Tencent/WCDB: A cross-platform database framework developed by WeChat.](https://github.com/Tencent/wcdb)
  - Languages: C++, Java, Kotlin, Swift, Objective-C.
  - 集成了数据库加密（SQLCipher）、修复、防注入、schema 升级、全文搜索、迁移、压缩。
  - 虽然 README 有英文，但文档实际上只有中文。

### C++
- [SQLiteCpp: A smart and easy to use C++ SQLite3 wrapper.](https://github.com/SRombauts/SQLiteCpp)
- [sqlite\_modern\_cpp: The C++14 wrapper around sqlite library](https://github.com/SqliteModernCpp/sqlite_modern_cpp) (inactive)
- [sqlite\_orm: ❤️ SQLite ORM light header only library for modern C++](https://github.com/fnc12/sqlite_orm)

### Rust
- [Rusqlite: Ergonomic bindings to SQLite for Rust](https://github.com/rusqlite/rusqlite)
- [sqlite: Interface to SQLite](https://github.com/stainless-steel/sqlite)
- [Diesel: A safe, extensible ORM and Query Builder for Rust](https://github.com/diesel-rs/diesel)
- [SQLx: 🧰 The Rust SQL Toolkit. An async, pure Rust SQL crate featuring compile-time checked queries without a DSL. Supports PostgreSQL, MySQL, and SQLite.](https://github.com/launchbadge/sqlx)

[Comparison of sqlite crates? : r/rust](https://www.reddit.com/r/rust/comments/uxvyxw/comparison_of_sqlite_crates/)
> In terms of performance is rusqulite the solution with the smallest overhead, followed by diesel, which is minimally slower. SQLx and anything build on top is significantly less slower, at least according to benchmarks I've seen. Sometimes its as much as factor 10 slower.

## Python
- [aiosqlite: asyncio bridge to the standard sqlite3 module](https://github.com/omnilib/aiosqlite)
- [sqlitedict: Persistent dict, backed by sqlite3 and pickle, multithread-safe.](https://github.com/piskvorky/sqlitedict)

### JS
- [SQL.JS: A javascript library to run SQLite on the web.](https://github.com/sql-js/sql.js)
- [Prisma: Next-generation ORM for Node.js & TypeScript | PostgreSQL, MySQL, MariaDB, SQL Server, SQLite, MongoDB and CockroachDB](https://github.com/prisma/prisma)

### Go
- [sqlc: Generate type-safe code from SQL](https://github.com/sqlc-dev/sqlc)

## Foreign key
```sql
PRAGMA foreign_keys = 1
```
[SQLite Syntax for Creating Table with Foreign Key - Stack Overflow](https://stackoverflow.com/questions/18387209/sqlite-syntax-for-creating-table-with-foreign-key)

## Unsupported features
- `RIGHT` and `FULL OUTER JOIN`
  
- Complete `ALTER TABLE` support

  > Only the `RENAME TABLE`, `ADD COLUMN`, `RENAME COLUMN`, and `DROP COLUMN` variants of the `ALTER TABLE` command are supported. Other kinds of `ALTER TABLE` operations such as `ALTER COLUMN`, `ADD CONSTRAINT`, and so forth are omitted.

  例如 `ALTER TABLE Student RENAME Snam TO Sname;`

- Complete trigger support

  > `FOR EACH ROW` triggers are supported but not `FOR EACH STATEMENT` triggers.

- Writing to VIEWs

  不支持 `INSERT`、`UPDATE` 和 `DELETE`，不支持 `WITH CHECK OPTION`。

- `GRANT` and `REVOKE`

[SQL Features That SQLite Does Not Implement](https://www.sqlite.org/omitted.html)

## Files
[Temporary Files Used By SQLite](https://www.sqlite.org/tempfiles.html)

## Connections
[Opening A New Database Connection](https://www.sqlite.org/c3ref/open.html)

[Can multiple applications or multiple instances of the same application access a single database file at the same time?](https://sqlite.org/faq.html#q5)
> Multiple processes can have the same database open at the same time. Multiple processes can be doing a `SELECT` at the same time. But only one process can be making changes to the database at any moment in time, however.
>
> You should avoid putting SQLite database files on NFS if multiple processes might try to access the file at the same time.

[Can I read and write to a SQLite database concurrently from multiple connections? - Stack Overflow](https://stackoverflow.com/questions/10325683/can-i-read-and-write-to-a-sqlite-database-concurrently-from-multiple-connections)
> Beginning with version 3.7.0, a new “Write Ahead Logging” (WAL) option is available, in which reading and writing can proceed concurrently. By default, WAL is not enabled. To turn WAL on, refer to the SQLite documentation.

## Thread-safety
[Using SQLite In Multi-Threaded Applications](https://www.sqlite.org/threadsafe.html)
> SQLite supports three different threading modes:
> - Single-thread. In this mode, all mutexes are disabled and SQLite is unsafe to use in more than a single thread at once.
> - Multi-thread. In this mode, SQLite can be safely used by multiple threads provided that no single database connection nor any object derived from database connection, such as a prepared statement, is used in two or more threads at the same time.
> - Serialized. In serialized mode, API calls to affect or use any SQLite database connection or any object derived from such a database connection can be made safely from multiple threads. The effect on an individual object is the same as if the API calls had all been made in the same order from a single thread. The name "serialized" arises from the fact that SQLite uses mutexes to serialize access to each object.
>
> The default mode is serialized.

Why SQLite doesn't provide a thread-safe mode by using multi-thread mode and a connection pool? Isn't it more efficient than serialized mode?

Rusqlite:
- `Conncetion` is `Send + !Sync` and `!Clone`. 

  [Share Connection into several threads - Issue #188 - rusqlite/rusqlite](https://github.com/rusqlite/rusqlite/issues/188)

  - [r2d2-sqlite: r2d2 connection pool for sqlite](https://github.com/ivanceras/r2d2-sqlite)

    `SqliteConnectionManager` is `Send + Sync` but `!Clone`. But `r2d2::Pool` is `Send + Sync` and `Clone`.

  - [tokio-rusqlite: Asynchronous handle for rusqlite library.](https://github.com/programatik29/tokio-rusqlite)

## Transactions
- Rollback journals
- [Write-ahead logs](https://www.sqlite.org/wal.html)
  - Although it is said that "WAL mode works as efficiently with large transactions as does rollback mode", WAL can still be 15~40% slower than rollback mode for large transactions.

[On the IO characteristics of the SQLite Transactions](https://oslab.kaist.ac.kr/wp-content/uploads/esos_files/publication/conferences/international/On%20the%20IO%20characteristics%20of%20the%20SQLite%20Transactions.pdf?ckattempt=1)

## Virtual tables
[The Virtual Table Mechanism Of SQLite](https://www.sqlite.org/vtab.html)

- [XLite: Query Excel spredsheets (.xlsx, .xls, .ods) using SQLite](https://github.com/x2bool/xlite)

## Indexes
- [sqlite\_blaster: Create huge Sqlite indexes at breakneck speeds](https://github.com/siara-cc/sqlite_blaster)

## Statements
[SQL Language Expressions](https://www.sqlite.org/lang_expr.html)

[sql - What are valid table names in SQLite? - Stack Overflow](https://stackoverflow.com/questions/3694276/what-are-valid-table-names-in-sqlite)

- The SQL standard requires double-quotes around identifiers and single-quotes around string literals.
  - `"this is a legal SQL column name"`
  - `'this is an SQL string literal'`

  [Double-quoted String Literals Are Accepted](https://www.sqlite.org/quirks.html#double_quoted_string_literals_are_accepted)

### Parameters
- Parameters may not be used for column or table names, or as values for constraints or default values.

  [Can I use parameters for the table name in sqlite3? - Stack Overflow](https://stackoverflow.com/questions/5870284/can-i-use-parameters-for-the-table-name-in-sqlite3)

- `?`, `?NNN`

- `:AAAA`, `@AAAA`, `$AAAA`

- No variable length argument support
- `SQLITE_MAX_VARIABLE_NUMBER` defaults to 32766 (prior to v3.22 it is 999)

## SELECT
[The SQLite Query Optimizer Overview](https://www.sqlite.org/optoverview.html)

### OFFSET
[Scrolling Cursor](https://www2.sqlite.org/cvstrac/wiki?p=ScrollingCursor)
> Do not leave queries open waiting for the user input. Run a query to fill up the screen with as much information as it will hold then `reset()` or `finalize()` the query statment. Get in, grab your data, then get out. Later on, when the user decides to scroll up or down (which will usually be eons of time later from the point of view of your CPU), run another query to refresh the screen with new data.
> 
> There a couple of problems with this approach. First off, since neither `sqlite3_reset()` nor `sqlite3_finalize()` are called on the statement, the database is locked and other processes are unable to update it. But perhaps more seriously is that there is not a good way to respond when the user presses the "Up" button to scroll back up. There is no `sqlite3_step_backwards()` function in SQLite. It is normally at this point in the reasoning process that the programmer gets on the mailing list asking for how to "scroll backwards".

SQLite 的 `OFFSET` 实际上只是忽略了指定数量的结果，最差的情况下需要遍历所有结果。SQLite 官方不建议用 `OFFSET` 来实现滚动窗口（翻页），而是用 `WHERE` 比较来实现。

> Do not try to implement a scrolling window using `LIMIT` and `OFFSET`. Doing so will become sluggish as the user scrolls down toward the bottom of the list.
> 
> Another error that crops up frequently is programmers trying to implement a scrolling window using `LIMIT` and `OFFSET`. The idea here is that you first just remember the index of the top entry in the display and run a query like this:
> ```sql
> SELECT title FROM tracks
>  WHERE singer='Madonna'
>  ORDER BY title
>  LIMIT 5 OFFSET :index
> ```
> The index is initialized to 0. To scroll down just increment the index by 5 and rerun the query. To scroll up, decrement the index by 5 and rerun.
> 
> The above will work actually. The problem is that it gets slow when the index gets large. The way `OFFSET` works in SQLite is that it causes the `sqlite3_step()` function to ignore the first `:index` breakpoints that it sees. So, for example, if `:index` is 1000, you are really reading in 1005 entries and ignoring all but the last 5. The net effect is that scrolling starts to become sluggish as you get lower and lower in the list.
> 
> Actually, depending on how big your list is and how fast your machine runs, you might easily get away with using `OFFSET` this way. `OFFSET` will often work OK on a workstation. But on battery powered devices with slow CPUs and slower mass storage, using the `OFFSET` approach usually breaks down when the list becomes large.

如果需要支持任意页数跳转，不能直接使用 `WHERE`，使用子查询也可能会比 `OFFSET` 更快。
- 利用 index：
  
  ```sql
  select * from Table where rowid in (
  select rowid from Table limit %size offset %start)
  ```

也可以交替使用 `WHERE` 和 `OFFSET`，在跳转上下页时使用 `WHERE`，在跳转任意页时使用 `OFFSET`。

[Sqlite Query Optimization (using Limit and Offset) - Stack Overflow](https://stackoverflow.com/questions/12266025/sqlite-query-optimization-using-limit-and-offset)

[Stop using offset for pagination - Why it's grossly inefficient : r/programming](https://www.reddit.com/r/programming/comments/knlp8a/stop_using_offset_for_pagination_why_its_grossly/)

## Bulk-inserting
- Transactions

  [Maximum number of inserts per transaction - Stack Overflow](https://stackoverflow.com/questions/16575424/maximum-number-of-inserts-per-transaction)

- Prepared statements

[Squeezing Performance from SQLite: Insertions | by Jason Feinstein | Medium](https://medium.com/@JasonWyatt/squeezing-performance-from-sqlite-insertions-971aff98eef2)

[Towards Inserting One Billion Rows in SQLite Under A Minute - blag](https://avi.im/blag/2021/fast-sqlite-inserts/) ([Hacker News](https://news.ycombinator.com/item?id=27872575))

## Memory usage
SQLite 在默认配置下的 memory usage 很低，约 5~13 MiB，基本与数据库和 transaction 的规模无关。

## 统计量
[function - Standard Deviation for SQLite - Stack Overflow](https://stackoverflow.com/questions/2298339/standard-deviation-for-sqlite)
```sql
SELECT AVG((t.row - sub.a) * (t.row - sub.a)) as var from t, 
    (SELECT AVG(row) AS a FROM t) AS sub;
```

## Extensions
[Run-Time Loadable Extensions](https://www.sqlite.org/loadext.html)

- `load_extension()` only loads the extension into the specified connection.

Extensions:
- [sqlean: The ultimate set of SQLite extensions](https://github.com/nalgeon/sqlean)
- [sqlite-vss: A SQLite extension for efficient vector search, based on Faiss!](https://github.com/asg017/sqlite-vss)

## Tools
- Navicat

- [DB Browser for SQLite](https://github.com/sqlitebrowser/sqlitebrowser)

- [SQLiteStudio](https://sqlitestudio.pl/)

  支持 SQLCipher、wxSQLite3 和 System.Data.SQLite 加密

- [DB Browser for SQLite](https://sqlitebrowser.org/)

  只支持 SQLCipher 加密

- [sqliteviz: Instant offline SQL-powered data visualisation in your browser](https://github.com/lana-k/sqliteviz)

- [xeus-sql: Jupyter kernel for SQL databases](https://github.com/jupyter-xeus/xeus-sql)

Replication:
- [Litestream: Streaming replication for SQLite.](https://github.com/benbjohnson/litestream)

Servers:
- [Soul: 🕉 A SQLite REST and realtime server](https://github.com/thevahidal/soul)
- [tuql: Automatically create a GraphQL server from a SQLite database or a SQL file](https://github.com/bradleyboy/tuql)