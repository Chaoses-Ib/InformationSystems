# [SQLite](https://www.sqlite.org/index.html)
[GitHub](https://github.com/sqlite/sqlite)

## The amalgamation
The amalgamation is the recommended way of using SQLite in a larger application.

[The SQLite Amalgamation](https://www.sqlite.org/amalgamation.html)

[SQLite Download Page](https://www.sqlite.org/download.html)

## Bindings
C++：
- [SQLiteCpp: SQLiteC++ (SQLiteCpp) is a smart and easy to use C++ SQLite3 wrapper.](https://github.com/SRombauts/SQLiteCpp)

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

## 统计量
[function - Standard Deviation for SQLite - Stack Overflow](https://stackoverflow.com/questions/2298339/standard-deviation-for-sqlite)
```sql
SELECT AVG((t.row - sub.a) * (t.row - sub.a)) as var from t, 
    (SELECT AVG(row) AS a FROM t) AS sub;
```

## Tools
- Navicat

- [SQLiteStudio](https://sqlitestudio.pl/)

  支持 SQLCipher、wxSQLite3 和 System.Data.SQLite 加密

- [DB Browser for SQLite](https://sqlitebrowser.org/)

  只支持 SQLCipher 加密