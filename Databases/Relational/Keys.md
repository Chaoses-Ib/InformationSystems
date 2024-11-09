# Keys
## Primary keys
[Wikipedia](https://en.wikipedia.org/wiki/Primary_key)

## Sequential keys
Sequential keys (auto increment keys):
- [SQLite Autoincrement](https://www.sqlite.org/autoinc.html)
  - > If no `ROWID` is specified on the insert, or if the specified `ROWID` has a value of `NULL`, then an appropriate `ROWID` is created automatically.
  - Start from 0.
    - [SQLite Forum: Start rowid from 0](https://sqlite.org/forum/forumpost/2fa5843fce?t=h)
  - > If the `AUTOINCREMENT` keyword appears after `INTEGER PRIMARY KEY`, that changes the automatic `ROWID` assignment algorithm to prevent the reuse of `ROWID`s over the lifetime of the database. In other words, the purpose of `AUTOINCREMENT` is to prevent the reuse of `ROWID`s from previously deleted rows.

## Random keys
- RNG
  
  [python - how do you auto generate a random ID for an SQLite database table - Stack Overflow](https://stackoverflow.com/questions/72926478/how-do-you-auto-generate-a-random-id-for-an-sqlite-database-table)

- UUID
  
  [Using UUIDs in SQLite - Stack Overflow](https://stackoverflow.com/questions/17277735/using-uuids-in-sqlite)

- Sequential keys + encryption

  [sql - Generating cryptographic secure IDs instead of sequential identity / auto increment - Stack Overflow](https://stackoverflow.com/questions/57085075/generating-cryptographic-secure-ids-instead-of-sequential-identity-auto-increm)

  [php - How to encrypt primary keys in a consistent way - Stack Overflow](https://stackoverflow.com/questions/5279155/how-to-encrypt-primary-keys-in-a-consistent-way)

- Sequential keys + encoding
  - [hashids.net: A small .NET package to generate YouTube-like hashes from one or many numbers. Use hashids when you do not want to expose your database ids to the user.](https://github.com/ullmark/hashids.net)
  - Sqids
    - [sqids-dotnet: Official .NET port of Sqids. Generate short unique IDs from numbers.](https://github.com/sqids/sqids-dotnet)
    - [sqids/sqids-rust: Official Rust port of Sqids. Generate short unique IDs from numbers.](https://github.com/sqids/sqids-rust)

[The Evils of Sequential IDs. 3 reasons not to use Sequential IDs as... | by Jefferey Cave | Medium](https://jefferey-cave.medium.com/the-evils-of-sequential-ids-2d1b18b50fdb)

Discussion:
- 2021-01 [UUID vs int for primary key - Which is better (with auto increment), especially if you are scared you'll run out of ids? : r/PostgreSQL](https://www.reddit.com/r/PostgreSQL/comments/kzv50w/uuid_vs_int_for_primary_key_which_is_better_with/)
- 2022-09 [UUID vs Sequential ID as primary key : r/PostgreSQL](https://www.reddit.com/r/PostgreSQL/comments/xbspxs/uuid_vs_sequential_id_as_primary_key/)
- 2023-08 [Is it bad practice to expose database auto-incrementing IDs to the client? : r/dotnet](https://www.reddit.com/r/dotnet/comments/15ubri1/is_it_bad_practice_to_expose_database/)

## String keys
- Performance
- Database size
- [Using text as a primary key in SQLite table bad? - Stack Overflow](https://stackoverflow.com/questions/23157411/using-text-as-a-primary-key-in-sqlite-table-bad)