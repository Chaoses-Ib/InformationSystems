# DBMS
## Bindings
### Rust
- [Diesel: A safe, extensible ORM and Query Builder for Rust](https://github.com/diesel-rs/diesel)
  - [Schema in Depth](https://diesel.rs/guides/schema-in-depth.html)
  - [diesel\_migrations](https://docs.rs/diesel_migrations/latest/diesel_migrations/)

    [How are people running their migrations in production? - Issue #559 - diesel-rs/diesel](https://github.com/diesel-rs/diesel/issues/559)

    [Diesel Table Scheme Migration : r/rust](https://www.reddit.com/r/rust/comments/16sj6af/diesel_table_scheme_migration/)

    [Diesel specific, is migration necessary? : r/rust](https://www.reddit.com/r/rust/comments/xhlizd/diesel_specific_is_migration_necessary/)
    > If the structs are not precisely the same as the tables then you start getting weird nonsensical error messages

- [SQLx: 🧰 The Rust SQL Toolkit. An async, pure Rust SQL crate featuring compile-time checked queries without a DSL. Supports PostgreSQL, MySQL, and SQLite.](https://github.com/launchbadge/sqlx)
  - [SeaORM: 🐚 An async & dynamic ORM for Rust](https://github.com/SeaQL/sea-orm)
    - [Migration](https://www.sea-ql.org/SeaORM/docs/next/migration/setting-up-migration/)

- [ormlite: An ORM in Rust for developers that love SQL.](https://github.com/kurtbuilds/ormlite)
  - > It auto-generates migrations from Rust structs. To my knowledge, it is the only Rust ORM with this capability.
  - > Currently, the CLI only supports Postgres.

- [Butane: An ORM for Rust with a focus on simplicity and on writing Rust, not SQL](https://github.com/Electron100/butane)

- [rbatis: Rust Compile Time ORM robustness,async, pure Rust Dynamic SQL](https://github.com/rbatis/rbatis) (Chinese)

- [barrel: 🛢 A database schema migration builder for Rust](https://github.com/rust-db/barrel) (discontinued)

[diesel-rs/metrics: Performance statistic collection for rusts database connection crates](https://github.com/diesel-rs/metrics)

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