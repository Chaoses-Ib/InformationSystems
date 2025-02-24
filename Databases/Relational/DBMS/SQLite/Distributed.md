# Distributed SQLite
## Single-leader replication
[Distributed SQLite: Paradigm shift or hype?](https://kerkour.com/distributed-sqlite) ([Hacker News](https://news.ycombinator.com/item?id=39975596))
- Multiple readers, single writer

  > All these SQLite derivatives work more or less the same way: there is a primary database somewhere that accepts the writes, which are then asynchronously replicated in other regions, often by streaming SQLite's Write-Ahead Log which is a log of all the transactions executed on the database.

- Eventual consistency

  > LiteFS proposes an hacky solution: your application sets a [`__txid`](https://github.com/superfly/litefs/blob/main/http/proxy_server.go) Cookie (for Transaction Identifier) to track the last transaction that the regional replica has, and forward the read query to the primary database if it's too old. Now, your application is intimately tied to your database and your reverse-proxy.
  > 
  > And this is before talking about the fact that LiteFS supports roughly 100 writes per second.

- Don't support interactive transactions

  > When you introduce network latency between your application and your SQLite database, the system melts down: the database will be locked during all the time for the transaction's roundtrips and you will be limited to a few writes per second. Turso "solves" this with [batches](https://docs.turso.tech/sdk/ts/reference): you can batch multiples queries and they will be executed in a single transaction, while Cloudflare D1 "solves" the problem with batches and [stored procedures](https://blog.cloudflare.com/whats-new-with-d1).
  > 
  > What a nightmare! Now your application code spills into your database and our initial goal of simplifying application development is nothing but a long-forgotten dream. All of that for what? To save a few milliseconds to display a web page.

C++:
- [HC-tree](https://sqlite.org/hctree/doc/hctree/doc/hctree/index.html)
- [dqlite: Embeddable, replicated and fault-tolerant SQL engine.](https://github.com/canonical/dqlite)

Rust:
- [mvSQLite: Distributed, MVCC SQLite that runs on FoundationDB.](https://github.com/losfair/mvsqlite) (discontinued)

  [Turning SQLite into a distributed database](https://su3.io/posts/mvsqlite) ([Hacker News](https://news.ycombinator.com/item?id=32539360))

Go:
- [rqlite: The lightweight, distributed relational database built on SQLite.](https://github.com/rqlite/rqlite)
  - Raft
  - Rust: [tomvoet/rqlite-rs: Async Rqlite client for Rust](https://github.com/tomvoet/rqlite-rs)

- [Litestream: Streaming replication for SQLite.](https://github.com/benbjohnson/litestream)
  - If it's just for backup, why not just use any file sync tool?

- [LiteFS: Distributed SQLite](https://fly.io/docs/litefs/) ([GitHub](https://github.com/superfly/litefs))

  [How LiteFS Works - Fly Docs](https://fly.io/docs/litefs/how-it-works/)

  [I Migrated from a Postgres Cluster to Distributed SQLite with LiteFS](https://kentcdodds.com/blog/i-migrated-from-a-postgres-cluster-to-distributed-sqlite-with-litefs)

Services:
- Cloudflare
  - [Cloudflare D1](https://developers.cloudflare.com/d1/)
  - Durable Objects

    [Zero-latency SQLite storage in every Durable Object](https://blog.cloudflare.com/sqlite-in-durable-objects/)
- [Turso - Databases for All](https://turso.tech/)
- [SQLite Cloud - Share, scale and deploy SQLite databases.](https://sqlitecloud.io/)

## CRDT
- [cr-sqlite: Convergent, Replicated SQLite. Multi-writer and CRDT support for SQLite](https://github.com/vlcn-io/cr-sqlite)
- [SQLSync: A collaborative offline-first wrapper around SQLite. It is designed to synchronize web application state between users, devices, and the edge.](https://github.com/orbitinghail/sqlsync)
- [Expensify/Bedrock: Rock solid distributed database specializing in active/active automatic failover and WAN replication](https://github.com/Expensify/Bedrock)

## Block-based
- [Cloud Backed SQLite](https://sqlite.org/cloudsqlite/doc/trunk/www/index.wiki)
  - Supports Azure Blob Storage and Google Cloud Storage
- [psanford/sqlite3vfshttp: Go sqlite3 http vfs: query sqlite databases over http with range headers](https://github.com/psanford/sqlite3vfshttp)
