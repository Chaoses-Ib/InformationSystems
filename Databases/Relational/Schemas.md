# Relational Schemas
[Database schema - Wikipedia](https://en.wikipedia.org/wiki/Database_schema)

## Migration
### Version-based
- Most ORMs
- Rust
  - [refinery: Powerful SQL migration toolkit for Rust.](https://github.com/rust-db/refinery)
  - [Geni: Standalone database migration tool which works for Postgres, MariaDB, MySQL, Sqlite and LibSQL(Turso).](https://github.com/emilpriver/geni)
  - [migrant\_lib: Embeddable migration management](https://github.com/jaemk/migrant_lib)
- Go
  - [pgroll: PostgreSQL zero-downtime migrations made easy](https://github.com/xataio/pgroll)

    [Introducing pgroll: zero-downtime, reversible, schema migrations for Postgres](https://xata.io/blog/pgroll-schema-migrations-postgres) ([Hacker News](https://news.ycombinator.com/item?id=37752366))

### Diff-based
[Simple declarative schema migration for SQLite](https://david.rothlis.net/declarative-schema-migration-for-sqlite/)

[\> without migration scripts, like editing source code. Just a quick "deploy" and... | Hacker News](https://news.ycombinator.com/item?id=39233019)

Implementations:
- C++
  - SQLite: [WCDB](DBMS/SQLite/README.md#bindings)
- Rust
  - [Renovate: Renovate is a CLI tool to help you to work on Postgres SQL migration easily.](https://github.com/tyrchen/renovate)
  - [postgres\_migrator: A postgres migration generator and runner that uses raw declarative sql.](https://github.com/blainehansen/postgres_migrator)
  - [Models: A tool for automated migrations for PostgreSQL, SQLite and MySQL.](https://github.com/tvallotton/models)
- Go
  - [sqldef: Idempotent schema management for MySQL, PostgreSQL, and more](https://github.com/sqldef/sqldef)
    - MySQL, PostgreSQL, SQLite, SQL Server
    - "found syntax error when parsing DDL ..."
      - [Issue with columns named `type` with PostgreSQL - Issue #347](https://github.com/sqldef/sqldef/issues/347)
  - [Stripe/pg-schema-diff: Go library for diffing Postgres schemas and generating SQL migrations](https://github.com/stripe/pg-schema-diff/)
  - [Atlas: Manage your database schema as code](https://github.com/ariga/atlas)
  - [Terraform: Terraform enables you to safely and predictably create, change, and improve infrastructure. It is a source-available tool that codifies APIs into declarative configuration files that can be shared amongst team members, treated as code, edited, reviewed, and versioned.](https://github.com/hashicorp/terraform)
  - [Add something like GORM's AutoMigrate - Issue #456 - uptrace/bun](https://github.com/uptrace/bun/issues/456)
- Python
  - [migra: Like diff but for PostgreSQL schemas](https://github.com/djrobstep/migra)
  - [Tusker: PostgreSQL migration management tool](https://github.com/bikeshedder/tusker)
