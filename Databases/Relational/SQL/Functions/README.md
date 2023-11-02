# Functions
[FUNCTIONS - SQLZOO](https://sqlzoo.net/wiki/FUNCTIONS)

|  | MySQL | Oracle | PostgreSQL | SQL Server |
| --- | --- | --- | --- | --- |
| `s1 + s2` | `CONCAT(s1, s2)` | `s1 \|\| s2` | `s1 \|\| s2` | √ |
| `ABS(f)` | √ | √ | √ | √ |
| [`CASE`](https://sqlzoo.net/wiki/`CASE`) | √ | √ | √ | √ |
| `CAST` |  |  |  |  |
| `CONCAT(s1, s2…)` | √ | `s1 \|\| s2` | `s1 \|\| s2` | `s1 + s2` |
| `INSTR(s1, sn) -> i` | √ | √ | `POSITION(s2 IN s1)` | `PATINDEX('%'+s2+'%', s1)` |
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