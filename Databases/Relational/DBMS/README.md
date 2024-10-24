# DBMS
## Bindings
- 支持多个 DBMS 对于库开发者是有利的，可以扩大潜在用户群体，但对于用户来说，通用抽象会带来更多认知开销，以及对特定 DBMS 的功能缺少支持，实际上是不利的。

Libraries:
- [Prisma: Simplify working and interacting with databases](https://www.prisma.io/)

### Rust
- [tokio-rs/Toasty: An async ORM for Rust (incubating)](https://github.com/tokio-rs/toasty)
  - [sharing experience from `loco.rs` - Issue #14](https://github.com/tokio-rs/toasty/issues/14)

  [Announcing Toasty, an async ORM for Rust | Tokio - An asynchronous Rust runtime](https://tokio.rs/blog/2024-10-23-announcing-toasty) ([r/rust](https://www.reddit.com/r/rust/comments/1gak6zq/announcing_toasty_an_async_orm_for_rust/), [Hacker News](https://news.ycombinator.com/item?id=41929565))
  > Another aspect of ease of use is minimizing boilerplate. Rust already has a killer feature for this: procedural macros. Most of you have already used Serde, so you know what a delight this can be. That said, I opted not to use procedural macros for Toasty, at least not initially.
  > 
  > Procedural macros generate a lot of hidden code at build time. This isn't a big deal for libraries like Serde because the Serde macros generate implementations of public traits (Serialize and Deserialize). Users of Serde aren't really expected to know the implementation details of those traits.

- [Diesel: A safe, extensible ORM and Query Builder for Rust](https://github.com/diesel-rs/diesel)
  - From 2015-08
  - [Schema in Depth](https://diesel.rs/guides/schema-in-depth.html)
  - [diesel\_migrations](https://docs.rs/diesel_migrations/latest/diesel_migrations/)

    > If you prefer to generate your migrations based on Rust code instead, the diesel CLI tool provides an additional `--diff-schema` on the `diesel migration generate` command that allows to generate migrations based on the current schema definition and your database.

    [How are people running their migrations in production? - Issue #559 - diesel-rs/diesel](https://github.com/diesel-rs/diesel/issues/559)

    [Diesel Table Scheme Migration : r/rust](https://www.reddit.com/r/rust/comments/16sj6af/diesel_table_scheme_migration/)

    [Diesel specific, is migration necessary? : r/rust](https://www.reddit.com/r/rust/comments/xhlizd/diesel_specific_is_migration_necessary/)
    > If the structs are not precisely the same as the tables then you start getting weird nonsensical error messages

    既然已经能 diff 代码和 schema 了，为什么不再加一个启动时自动迁移呢？

- [SQLx: 🧰 The Rust SQL Toolkit. An async, pure Rust SQL crate featuring compile-time checked queries without a DSL. Supports PostgreSQL, MySQL, and SQLite.](https://github.com/launchbadge/sqlx)
  - From 2019-06
  - Async
  - [SeaORM: 🐚 An async & dynamic ORM for Rust](https://github.com/SeaQL/sea-orm)
    - From 2021-05
    - [Migration](https://www.sea-ql.org/SeaORM/docs/next/migration/setting-up-migration/)

- [prisma-client-rust: Type-safe database access for Rust](https://github.com/Brendonovich/Prisma-Client-Rust)
  - > I don't have exact figures but I can confidently say PCR is slower than pretty much all other Rust db libraries, as the engines have a fair bit of overhead. There may be some improvements, but there's always going to be more overhead with serializing queries into Prisma's format first.

- [ormlite: An ORM in Rust for developers that love SQL.](https://github.com/kurtbuilds/ormlite)
  - > It auto-generates migrations from Rust structs. To my knowledge, it is the only Rust ORM with this capability.
  - > Currently, the CLI only supports Postgres.

- [Butane: An ORM for Rust with a focus on simplicity and on writing Rust, not SQL](https://github.com/Electron100/butane)

- [rbatis: Rust Compile Time ORM robustness,async, pure Rust Dynamic SQL](https://github.com/rbatis/rbatis) (Chinese)

- [barrel: 🛢 A database schema migration builder for Rust](https://github.com/rust-db/barrel) (discontinued)

[diesel-rs/metrics: Performance statistic collection for rusts database connection crates](https://github.com/diesel-rs/metrics)
- Diesel >> SQLx > SeaORM
- SQLite: Sync >> Async

Discussions:
- 2022-08 [Cornucopia v0.8: Generate type-checked Rust interfaces from your PostgreSQL queries. : r/rust](https://www.reddit.com/r/rust/comments/wdos9x/comment/iim7v0x/?utm_source=share&utm_medium=web2x&context=3)

  > What motivated me to write Cornucopia in the first place is actually because I had a few pet-peeves with SQLx that I thought could be ironed out using a totally different approach. Namely:
  > - SQLx' compile-time macros are intrusive. You have to commit to manage a live database yourself every time you work on a SQLx project with macros, even when you're not adding new queries or modifying your schema. If your database is unreachable, or if the database is out-of-sync, you get a large amount of errors. (I'm aware that there's an offline feature, but I didn't find it ergonomic to use as part of a normal workflow).
  > 
  > - SQLx doesn't provide native sync interfaces. Depending on your workload, async is not always faster. Cornucopia can offer both sync and async easily.
  > 
  > - SQLx uses some nullity inference heuristics that will sometimes fail due to the brittle nature of the tools Postgres exposes for nullity inference (see <https://github.com/launchbadge/sqlx/issues/1266>, <https://github.com/launchbadge/sqlx/issues/1980>). The error messages can be jarring sometimes. Cornucopia doesn't use any nullity heuristics and lets the user control column nullity manually. Its a matter of personal preference whether that is better than SQLx' behavior or not, but I personally prefer it.
  > 
  > - Generally speaking, macros don't have the facilities to provide best-in-class error reporting. Cornucopia uses `miette` to provide powerful error diagnostics to users, including linking to the file/line/col where there error occured, and generally providing errors that are both informative and nice to look at.
  > 
  > - Performance is always a hot topic, so take this with a grain of salt, but in our benchmarks, Cornucopia performs very close to the `rust-postgres` drivers, which themselves beat SQLx by a significant margin in the ubiquitous db interface benchmarks provided by Diesel (<https://github.com/diesel-rs/metrics>). Take this with a grain of salt though, since this is an indirect comparison. We'll try to provide a direct comparison with SQLx in our benchmarks as soon as possible.

- 2023-05 [What ORM do you use? : r/rust](https://www.reddit.com/r/rust/comments/13d9ayi/what_orm_do_you_use/)
- 2024-01 [Community Review on Rust Database ORM crates : r/rust](https://www.reddit.com/r/rust/comments/18vzkfi/community_review_on_rust_database_orm_crates/)
  - > Diesel is pretty nice as it's very type-safe, but you have to write your own migrations and maintain your own Rust structs corresponding to your database schema, which PCR does automatically.
  - > SeaORM and sqlx aren't very type-safe which is the main reason why I don't use them. SeaORM is [not typesafe by design](https://www.sea-ql.org/SeaORM/docs/write-test/testing/#1-type-errors-1) and while sqlx does have type-safety, it has some [longstanding issues with nullability in joins](https://github.com/launchbadge/sqlx/issues?q=is%3Aissue+is%3Aopen+left+join), among other issues where generally, it simply cannot get as much information from the database as the programmer can provide via a code-based type system.
- 2024-04 [SeaOrm vs diesel : r/rust](https://www.reddit.com/r/rust/comments/1cgm4x2/seaorm_vs_diesel/)
  - > SeaORM I've only tried within the Loco framework. I found it to be too magic for my liking, and I'm not keen on the whole read-only writable struct types. I also dislike that you need to run a database to get it to validate types at compile time.
- 2024-07 [My take on databases with Rust (sea-orm vs. diesel vs. sqlx) : r/rust](https://www.reddit.com/r/rust/comments/1e8ld5d/my_take_on_databases_with_rust_seaorm_vs_diesel/)

## .NET
- [EF Core: A modern object-database mapper for .NET. It supports LINQ queries, change tracking, updates, and schema migrations.](https://github.com/dotnet/efcore)
  - [Database Providers](https://learn.microsoft.com/en-us/ef/core/providers/)
  - [Migrations Overview](https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/)
  - [NativeAOT support](https://github.com/dotnet/efcore/issues/29754)

## Tools
- Navicat
- [SQLTools: Database management for VSCode](https://github.com/mtxr/vscode-sqltools)
- [usql: Universal command-line interface for SQL databases](https://github.com/xo/usql)
- [SQL Chat: Chat-based SQL Client and Editor for the next decade](https://github.com/sqlchat/sqlchat)