# Keys
## Primary keys
[Wikipedia](https://en.wikipedia.org/wiki/Primary_key)

Auto increment:
- [SQLite Autoincrement](https://www.sqlite.org/autoinc.html)
  - > If no `ROWID` is specified on the insert, or if the specified `ROWID` has a value of `NULL`, then an appropriate `ROWID` is created automatically.
  - Start from 0.
    - [SQLite Forum: Start rowid from 0](https://sqlite.org/forum/forumpost/2fa5843fce?t=h)
  - > If the `AUTOINCREMENT` keyword appears after `INTEGER PRIMARY KEY`, that changes the automatic `ROWID` assignment algorithm to prevent the reuse of `ROWID`s over the lifetime of the database. In other words, the purpose of `AUTOINCREMENT` is to prevent the reuse of `ROWID`s from previously deleted rows.

String:
- Performance
- Database size
- [Using text as a primary key in SQLite table bad? - Stack Overflow](https://stackoverflow.com/questions/23157411/using-text-as-a-primary-key-in-sqlite-table-bad)