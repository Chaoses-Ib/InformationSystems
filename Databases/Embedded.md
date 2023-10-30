# Embedded Databases
An **embedded database** system is a DBMS which is tightly integrated with an application software; it is embedded in the application.[^wiki]

## Implementations
- Relational databases
  - SQLite
- Ker-value databases
  - [LevelDB](Key-Value/DBMS/LevelDB/README.md)
    - [RocksDB](Key-Value/DBMS/LevelDB/RocksDB/README.md)
  - [Lightning Memory-Mapped Database](Key-Value/DBMS/LMDB/README.md)
- Others
  - [MapDB](https://mapdb.org/) ([GitHub](https://github.com/jankotek/mapdb))

    MapDB provides concurrent Maps, Sets and Queues backed by disk storage or off-heap-memory. It is a fast and easy to use embedded Java database engine.

[^wiki]: [Embedded database - Wikipedia](https://en.wikipedia.org/wiki/Embedded_database)