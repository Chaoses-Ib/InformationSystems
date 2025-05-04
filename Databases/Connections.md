# Connections

## Connection pool
[Wikipedia](https://en.wikipedia.org/wiki/Connection_pool)

> A connection pool is a cache of reusable database connections managed by the client or middleware. It reduces the overhead of opening and closing connections, improving performance and scalability in database applications.

> SQL databases typically use stateful, binary protocols that maintain session-specific information, such as transaction states and prepared statements, necessitating optimized connection pooling to minimize the overhead of repeatedly establishing connections. Conversely, many mainstream NoSQL databases, like Azure Cosmos DB and Amazon DynamoDB, utilize stateless, HTTP-based protocols that handle each request independently. This architecture often reduces the need for traditional connection pooling, though reusing established connections can still offer performance benefits in high-throughput scenarios by avoiding the overhead of connection creation.

### Rust
- [r2d2: A generic connection pool for Rust](https://github.com/sfackler/r2d2)
  - `Pool`, [`Builder`](https://docs.rs/r2d2/0.8.10/r2d2/struct.Builder.html)
    - Bad defaults
    - `max_size`, the maximum number of connections managed by the pool, defaults to **just 10**
    - `min_idle`, the minimum idle connection count maintained by the pool, defaults to **0**
    - `thread_pool`, the thread pool used for asynchronous operations such as connection creation, defaults to a new pool with 3 threads
    - `test_on_check_out`, if true, the health of a connection will be verified via a call to `ConnectionManager::is_valid` before it is checked out of the pool. Defaults to true.
    - `idle_timeout`, if set, connections will be closed after sitting idle for at most 30 seconds beyond this duration. Defaults to 10 minutes
    - `max_lifetime`, if set, connections will be closed after existing for at most 30 seconds beyond this duration; If a connection reaches its maximum lifetime while checked out it will be closed when it is returned to the pool. Defaults to 30 minutes
    - `connection_timeout` defaults to 30 seconds
    - `reaper_rate` defaults to 30 seconds
  - [→r2d2-sqlite](./Relational/DBMS/SQLite/README.md#thread-safety)
