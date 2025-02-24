# [SQLite](https://www.sqlite.org/index.html)
[GitHub](https://github.com/sqlite/sqlite), [Wikiepdia](https://en.wikipedia.org/wiki/SQLite)

[Replacing Elasticsearch with Rust and SQLite](https://nickb.dev/blog/replacing-elasticsearch-with-rust-and-sqlite/)

[Performance/Avoid SQLite In Your Next Firefox Feature - MozillaWiki](https://wiki.mozilla.org/Performance/Avoid_SQLite_In_Your_Next_Firefox_Feature)

[SQLite的文艺复兴 - BMPI](https://www.bmpi.dev/dev/renaissance-sqlite/) ([V2EX](https://www.v2ex.com/t/910008), [知乎](https://zhuanlan.zhihu.com/p/601510076))

[Many Small Queries Are Efficient In SQLite](https://www.sqlite.org/np1queryprob.html)

[libSQL: A fork of SQLite that is both Open Source, and Open Contributions.](https://github.com/tursodatabase/libsql)

[→Distributed SQLite](Distributed.md)

## The amalgamation
The amalgamation is the recommended way of using SQLite in a larger application.

[The SQLite Amalgamation](https://www.sqlite.org/amalgamation.html)

[SQLite Download Page](https://www.sqlite.org/download.html)

## Bindings
- [Tencent/WCDB: A cross-platform database framework developed by WeChat.](https://github.com/Tencent/wcdb)
  - Languages: C++, Java, Kotlin, Swift, Objective-C.
  - 集成了数据库加密（SQLCipher）、修复、防注入、schema 升级、全文搜索、迁移、压缩。
    - Thread-local connections
    - Not support custom types: [C++ 模型绑定 - Tencent/wcdb Wiki](https://github.com/Tencent/wcdb/wiki/C++-%e6%a8%a1%e5%9e%8b%e7%bb%91%e5%ae%9a)
    - [数据库升级](https://github.com/Tencent/wcdb/wiki/C++-%e6%a8%a1%e5%9e%8b%e7%bb%91%e5%ae%9a#%E6%95%B0%E6%8D%AE%E5%BA%93%E5%8D%87%E7%BA%A7)
    - [数据迁移](https://github.com/Tencent/wcdb/wiki/C++-%E6%95%B0%E6%8D%AE%E8%BF%81%E7%A7%BB)
    - [可中断事务 (PauseableTransaction)](https://github.com/Tencent/wcdb/wiki/C++-%E9%AB%98%E7%BA%A7%E6%8E%A5%E5%8F%A3#%E5%8F%AF%E4%B8%AD%E6%96%AD%E4%BA%8B%E5%8A%A1)
    - Functions: `Expression::function(StringView::makeConstant(funcName)).invoke().arguments({ a, b })`
  - Dependencies: SQLCipher (OpenSSL), zstd
  - Binary size: 5 MB (Windows x64, about 3 MB larger than SQLite only)
  - 虽然 README 有英文，但文档实际上只有中文。

  Build:
  ```sh
  git clone https://github.com/Tencent/wcdb.git
  cd wcdb
  git submodule update --init sqlcipher zstd
  cd src
  mkdir build
  cd build
  cmake .. -DBUILD_SHARED_LIBS=OFF
  ```
  MSBuild:
  ```xml
  <AdditionalIncludeDirectories>$(SolutionDir)wcdb\src\build\export_headers</AdditionalIncludeDirectories>
  <AdditionalDependencies>$(SolutionDir)\wcdb\tools\prebuild\openssl\windows\win64\libssl.lib;$(SolutionDir)\wcdb\tools\prebuild\openssl\windows\win64\libcrypto.lib;Crypt32.lib;$(SolutionDir)\wcdb\tools\prebuild\zlib\windows\win64\zlibstatic.lib</AdditionalDependencies>
  ```
  - CRT: With `-DBUILD_SHARED_LIBS=OFF`, the CRT of `WCDB` and `zstd` is `/MD`, but the CRT of `sqlcipher` is `/MD`. 

### C++
- [SQLiteCpp: A smart and easy to use C++ SQLite3 wrapper.](https://github.com/SRombauts/SQLiteCpp)
  - Threading mode: Multi-thread
  - Only basic functions. No connection pool, statement cache.
- [sqlite\_modern\_cpp: The C++14 wrapper around sqlite library](https://github.com/SqliteModernCpp/sqlite_modern_cpp) (inactive)
- [sqlite\_orm: ❤️ SQLite ORM light header only library for modern C++](https://github.com/fnc12/sqlite_orm)
- [SQLiteWrapper: An easy-to-use, extensible and lightweight C++17 wrapper for SQLite](https://github.com/trailofbits/sqlite_wrapper) (discontinued)
  - Thread-local connections
- [LibzdbL Database Connection Pool Library](https://tildeslash.com/libzdb/)

### Rust
- [Rusqlite: Ergonomic bindings to SQLite for Rust](https://github.com/rusqlite/rusqlite)
  - `Transaction`
    - `Transaction::new()` takes `&mut Connection` and then the original connection cannot be used
    - `Transaction::new_unchecked()` takes `&Connection`
    - `Transaction` can deref to `Connection`
  - [`ParamsFromIter`](https://docs.rs/rusqlite/latest/rusqlite/struct.ParamsFromIter.html)
    - `a.iter().map(|v| v as &dyn rusqlite::ToSql).chain(b.iter().map(|v| v as &dyn rusqlite::ToSql))`
  - `named_params!` will cause `InvalidParameterName` if any parameter is not used in the SQL
  - [rusqlite\_migration: ↕️ Simple database schema migration library for rusqlite, written with performance in mind.](https://github.com/cljoly/rusqlite_migration)
  - [rusqlite::types](https://docs.rs/rusqlite/latest/rusqlite/types/index.html)
  - Serde/JSON
    - `Value::String("a")` will be converted to `"\"a\""`
  
      [Support for Number (Integer/Float) and Null in `serde_json` - Issue #882](https://github.com/rusqlite/rusqlite/issues/882)
  
      [ToSql for `serde_json::value` deserializes incorrectly for strings - Issue #1312](https://github.com/rusqlite/rusqlite/issues/1312)
    - [serde\_rusqlite: Serialize/deserialize rusqlite rows](https://github.com/twistedfall/serde_rusqlite)
      - 不太简洁，优势在于网络应用通常本来就会定义 Serde traits。
  - [Exemplar: A boilerplate eliminator for rusqlite.](https://github.com/Colonial-Dev/exemplar)
    - 仍然有不少缺陷，但已经是最好的选择了。
    - 不支持插入时省略 struct 中的 rowid 再用 `last_insert_rowid()` 获取，需要修改 rowid 类型为 `Option<i64>`，或者单独创建一个 struct
    - 不支持标准 enum 语法，只能使用 [`sql_enum!`](https://docs.rs/exemplar/latest/exemplar/macro.sql_enum.html)

    [r/rust](https://www.reddit.com/r/rust/comments/179d5k3/exemplar_a_boilerplate_eliminator_for_rusqlite/)
  - [rusqlite-model: Model trait and derive implementation for rusqlite](https://github.com/OJFord/rusqlite-model)
  - [rust-pretty-sqlite: Simple, Minimalistic Pretty Prints for SQLite using rusqlite](https://github.com/jeremychone/rust-pretty-sqlite)
  - [MaxBondABE/rusqlite\_utils: Lightweight, low-level utilities for `rusqlite`.](https://github.com/MaxBondABE/rusqlite_utils) (discontinued)

- [sqlite: Interface to SQLite](https://github.com/stainless-steel/sqlite)

- [microrm: Lightweight SQLite ORM - Kestrel's git](https://git.flying-kestrel.ca/kestrel/microrm)
  - No migration support

- [nanosql: Tiny, strongly-typed data mapper for SQLite and Rust](https://github.com/H2CO3/nanosql)

[→DBMS](../README.md#rust)

Discussions:
- 2022-05 [Comparison of sqlite crates? : r/rust](https://www.reddit.com/r/rust/comments/uxvyxw/comparison_of_sqlite_crates/)
  
  > In terms of performance is rusqulite the solution with the smallest overhead, followed by diesel, which is minimally slower. SQLx and anything build on top is significantly less slower, at least according to benchmarks I've seen. Sometimes its as much as factor 10 slower.

### Python
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

- SQLite will fail to create the db if the parent directory doesn't exist.

## Thread-safety
[Using SQLite In Multi-Threaded Applications](https://www.sqlite.org/threadsafe.html)
> SQLite supports three different threading modes:
> - Single-thread. In this mode, all mutexes are disabled and SQLite is unsafe to use in more than a single thread at once.
> - Multi-thread. In this mode, SQLite can be safely used by multiple threads provided that no single database connection nor any object derived from database connection, such as a prepared statement, is used in two or more threads at the same time.
> - Serialized. In serialized mode, API calls to affect or use any SQLite database connection or any object derived from such a database connection can be made safely from multiple threads. The effect on an individual object is the same as if the API calls had all been made in the same order from a single thread. The name "serialized" arises from the fact that SQLite uses mutexes to serialize access to each object.
>
> The default mode is serialized.

Why SQLite doesn't provide a thread-safe mode by using multi-thread mode and a connection pool? Isn't it more efficient than serialized mode?

[mqudsi/sqlite-readers-writers: An SQLite benchmark for concurrent readers and writers](https://github.com/mqudsi/sqlite-readers-writers)

Rusqlite:
- `Conncetion` is `Send + !Sync` and `!Clone`. 

  [Share Connection into several threads - Issue #188 - rusqlite/rusqlite](https://github.com/rusqlite/rusqlite/issues/188)

  - [r2d2-sqlite: r2d2 connection pool for sqlite](https://github.com/ivanceras/r2d2-sqlite)
    - `cargo add r2d2-sqlite r2d2`
    - `SqliteConnectionManager` is `Send + Sync` but `!Clone`. But `r2d2::Pool` is `Send + Sync` and `Clone`.

  - [tokio-rusqlite: Asynchronous handle for rusqlite library.](https://github.com/programatik29/tokio-rusqlite)

## Transactions
- Rollback journals
  - `DELETE` / `TRUNCATE` / `PERSIST`
  - `MEMORY`
  - 1000 insertions: 10s → 15ms

- [Write-ahead logs](https://www.sqlite.org/wal.html)
  - Although it is said that "WAL mode works as efficiently with large transactions as does rollback mode", WAL can still be 15~40% slower than rollback mode for large transactions.

[On the IO characteristics of the SQLite Transactions](https://oslab.kaist.ac.kr/wp-content/uploads/esos_files/publication/conferences/international/On%20the%20IO%20characteristics%20of%20the%20SQLite%20Transactions.pdf?ckattempt=1)

### Savepoints
[Savepoints](https://www.sqlite.org/lang_savepoint.html)

> `SAVEPOINT`s are a method of creating transactions, similar to `BEGIN` and `COMMIT`, except that the `SAVEPOINT` and `RELEASE` commands are named and may be nested.

## Virtual tables
[The Virtual Table Mechanism Of SQLite](https://www.sqlite.org/vtab.html)

- [sqlite-lines: A SQLite extension for reading large files line-by-line (NDJSON, logs, txt, etc.)](https://github.com/asg017/sqlite-lines)
- [sqlite-xsv: the fastest CSV SQLite extension, written in Rust](https://github.com/asg017/sqlite-xsv)
- [XLite: Query Excel spredsheets (.xlsx, .xls, .ods) using SQLite](https://github.com/x2bool/xlite)
- [sqlite-http: A SQLite extension for making HTTP requests purely in SQL](https://github.com/asg017/sqlite-http)

## Indexes
- [sqlite\_blaster: Create huge Sqlite indexes at breakneck speeds](https://github.com/siara-cc/sqlite_blaster)

## Statements
[Query Language Understood by SQLite](https://www.sqlite.org/lang.html)
- [SQL Language Expressions](https://www.sqlite.org/lang_expr.html)
- [Built-In Scalar SQL Functions](https://www.sqlite.org/lang_corefunc.html)

BNF:
- [sqlite-bnf: Machine readable BNF form of the sqlite grammar and a script which generates it from published sqlite website](https://github.com/AlecKazakova/sqlite-bnf)

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

  [select - SQLite: bind list of values to "WHERE col IN ( :PRM )" - Stack Overflow](https://stackoverflow.com/questions/4788724/sqlite-bind-list-of-values-to-where-col-in-prm)
  - Generate `?`
  - `json_each()`

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

  ~10k/s

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

Rust: [sqlite-loadable-rs: A framework for writing fast and performant SQLite extensions in Rust](https://github.com/asg017/sqlite-loadable-rs)

Extensions:
- [sqlean: The ultimate set of SQLite extensions](https://github.com/nalgeon/sqlean)

- [sqlite-vss: A SQLite extension for efficient vector search, based on Faiss!](https://github.com/asg017/sqlite-vss)
  - Only worked on Linux + MacOS machines (no Windows, WASM, mobile devices, etc.)
  - Stored vectors all in-memory
  - Various transaction-related bugs and issues
  - Extremely hard and time-consuming to compile
  - Missing common vector operations (scalar/binary quantization)
  - [Benchmarks - Issue #31](https://github.com/asg017/sqlite-vss/issues/31)

  Successors:
  - ~~[sqlite-vector: A SQLite extension for working with float and binary vectors. Work in progress!](https://github.com/asg017/sqlite-vector)~~
  - [sqlite-vec: Work-in-progress vector search SQLite extension that runs anywhere.](https://github.com/asg017/sqlite-vec)

    [I'm writing a new vector search SQLite Extension | Alex Garcia's Blog](https://alexgarcia.xyz/blog/2024/building-new-vector-search-sqlite/index.html) ([Hacker News](https://news.ycombinator.com/item?id=40243168))

- [sqlite-regex: A fast regular expression SQLite extension, written in Rust](https://github.com/asg017/sqlite-regex)

- [sqlite-path: A SQLite extension for parsing, generating, and querying paths](https://github.com/asg017/sqlite-path)

[asg017/sqlite-ecosystem: An overview of all my SQLite extensions, and a roadmap for future extensions and tooling!](https://github.com/asg017/sqlite-ecosystem)

[sqlite-package-manager](https://github.com/asg017/sqlite-package-manager)

## Tools
- Navicat

- [DB Browser for SQLite](https://github.com/sqlitebrowser/sqlitebrowser)

- [SQLiteStudio](https://sqlitestudio.pl/)

  支持 SQLCipher、wxSQLite3 和 System.Data.SQLite 加密

- [DB Browser for SQLite](https://sqlitebrowser.org/)

  只支持 SQLCipher 加密

- [sqliteviz: Instant offline SQL-powered data visualisation in your browser](https://github.com/lana-k/sqliteviz)

- [xeus-sql: Jupyter kernel for SQL databases](https://github.com/jupyter-xeus/xeus-sql)

- [simonw/sqlite-utils: Python CLI utility and library for manipulating SQLite databases](https://github.com/simonw/sqlite-utils)

Replication:
- [Litestream: Streaming replication for SQLite.](https://github.com/benbjohnson/litestream)

Servers:
- [Soul: 🕉 A SQLite REST and realtime server](https://github.com/thevahidal/soul)
- [tuql: Automatically create a GraphQL server from a SQLite database or a SQL file](https://github.com/bradleyboy/tuql)
- [Postlite: Postgres wire compatible SQLite proxy.](https://github.com/benbjohnson/postlite) (discontinued)