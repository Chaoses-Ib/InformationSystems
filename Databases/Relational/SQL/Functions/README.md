# Functions
[FUNCTIONS - SQLZOO](https://sqlzoo.net/wiki/FUNCTIONS)

|  | MySQL | Oracle | PostgreSQL | SQL Server | SQLite
| --- | --- | --- | --- | --- | ---
| `s1 + s2` | `CONCAT(s1, s2)` | `s1 \|\| s2` | `s1 \|\| s2` | √ |
| `ABS(f)` | √ | √ | √ | √ |
| [`CASE`](https://sqlzoo.net/wiki/`CASE`) | √ | √ | √ | √ |
| `CAST` |  |  |  |  |
| `CONCAT(s1, s2…)` | √ | `s1 \|\| s2` | `s1 \|\| s2` | `s1 + s2` |
| `INSTR(s1, sn) -> i` | √ | √ | `POSITION(s2 IN s1)` | `PATINDEX('%'+s2+'%', s1)` | √
| `LEFT(s, n)` | √ | `SUBSTR(s, 1, i)` | `SUBSTR(s, 1, i)`<br />`SUBSTRING(s, 1, i)`<br />`SUBSTRING(s FROM 1 FOR i)` | √ |
| `LEN(s)` | `LENGTH(s)` | `LENGTH(s)` | `LENGTH(s)` | √ |
| `LENGTH(s)` | √ | √ | √ | `LEN(s)` |
| `ROUND(f, p)` | √ | √ | √ | √ |
| `PATINDEX('%s1%', s2)` | `POSITION(s1 IN s2)` | `INSTR(s2,s1)` | `POSITION(s1 IN s2)` | √ |
| `POSITION(s1 IN s2)` | √ | `INSTR(s2, s1)` | √ | `PATINDEX('%'+s1+'%', s2)` |
| `REPLACE(f, s1, s2)` | √ | √ | √ | √ |
| `SUBSTR(s, i, j)` | √ | √ | √ | `SUBSTRING(s, i, j)` |
| `SUBSTRING(s, i, j)` | √ | `SUBSTR(s, i, j)` | √ | √ |
| `SUBSTRING(s FROM i FOR j)` | √ | `SUBSTR(s, i, j)` | √ | `SUBSTRING(s, i, j)` |

- SQLite: [Built-In Scalar SQL Functions](https://sqlite.org/lang_corefunc.html)

## Count
### Performance
[sql - Is `count(*)` constant time in SQLite, and if not what are alternatives? - Stack Overflow](https://stackoverflow.com/questions/18807304/is-count-constant-time-in-sqlite-and-if-not-what-are-alternatives)
> SQLite has a special optimization for `COUNT(*)` without a `WHERE` clause, where it goes through the table's B-tree pages and counts entries without actually loading the records. However, this still requires that all the table's data (except overflow pages for large records) is visited, so the runtime is still O(n).

> I have a table with ~900M rows. select `count(*)` took 28.5 seconds. select `max(rowid)` took 0.003 seconds.

> While agreeing with the other answers that it is not constant time, one interesting and non-obvious performance improvement for `select count(*)` is to **add an index if you don't have one**. This can be on any arbitrary column, and on my system reduces the time of the query by 75% (ish).
```sh
sqlite> select count(*) from TestTable;
15035000
CPU Time: user 0.483603 sys 4.368028

sqlite> explain query plan select count(*) from TestTable;
0|0|0|SCAN TABLE TestTable (~1000000 rows)

sqlite> create index test_index on TestTable(Pointer);

sqlite> select count(*) from TestTable;
15035000
CPU Time: user 0.140401 sys 0.748805

sqlite> explain query plan select count(*) from TestTable;
0|0|0|SCAN TABLE TestTable USING COVERING INDEX test_index(~1000000 rows)
```

[sql - What is the most efficient way to count rows in a table in SQLite? - Stack Overflow](https://stackoverflow.com/questions/4474873/what-is-the-most-efficient-way-to-count-rows-in-a-table-in-sqlite/34628367)

[sql - Increase performance of `SELECT COUNT(*)` with `WHERE` clause in SQLite? - Stack Overflow](https://stackoverflow.com/questions/66175295/increase-performance-of-select-count-with-where-clause-in-sqlite)

## Strings
SQLite:
- [The `LIKE`, `GLOB`, `REGEXP`, `MATCH`, and extract operators](https://www.sqlite.org/lang_expr.html)
  
  [sql - How to search for a substring in SQLite? - Stack Overflow](https://stackoverflow.com/questions/3671761/how-to-search-for-a-substring-in-sqlite)

- `lower(X)`, `upper(X)`

- `format(FORMAT,...)`

- `quote(X)`

  > The `quote(X)` function returns the text of an SQL literal which is the value of its argument suitable for inclusion into an SQL statement. Strings are surrounded by single-quotes with escapes on interior quotes as needed. BLOBs are encoded as hexadecimal literals. Strings with embedded `NUL` characters cannot be represented as string literals in SQL and hence the returned string literal is truncated prior to the first `NUL`.

- No `startswith()`, `endswith()`