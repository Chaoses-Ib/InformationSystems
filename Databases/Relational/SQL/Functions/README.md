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

## Strings
SQLite:
- [The `LIKE`, `GLOB`, `REGEXP`, `MATCH`, and extract operators](https://www.sqlite.org/lang_expr.html)
  
  [sql - How to search for a substring in SQLite? - Stack Overflow](https://stackoverflow.com/questions/3671761/how-to-search-for-a-substring-in-sqlite)

- `lower(X)`, `upper(X)`

- `format(FORMAT,...)`

- `quote(X)`

  > The `quote(X)` function returns the text of an SQL literal which is the value of its argument suitable for inclusion into an SQL statement. Strings are surrounded by single-quotes with escapes on interior quotes as needed. BLOBs are encoded as hexadecimal literals. Strings with embedded `NUL` characters cannot be represented as string literals in SQL and hence the returned string literal is truncated prior to the first `NUL`.

- No `startswith()`, `endswith()`