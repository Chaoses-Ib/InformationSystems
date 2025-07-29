# Microsoft Access
## [SQL](https://learn.microsoft.com/en-us/office/client-developer/access/desktop-database-reference/microsoft-access-sql-reference)
Feature | Syntax
--- | ---
Limit | `TOP`
Subquery | ✔️
Union | ✔️
Stacked query | ❌
Comment | `%00`/`%16%`

Feature | Function
--- | ---
Length | [Len/LenB(string/variable)](https://support.microsoft.com/en-us/office/len-function-8282adcf-4e26-4ebd-87ed-73af04b0cf36)
Substring | [Mid/MidB(string, start[, length])](https://support.microsoft.com/en-us/office/mid-function-427e6895-822c-44ee-b34a-564a28f2532c)
Character → code | [Asc/AscB/AscM(string)](https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/asc-function)
Character ← code | [Chr/ChrB/ChrW(code)](https://support.microsoft.com/en-us/office/chr-function-94e7d144-8ba7-4082-8519-e5dd1b451b85)
If | [Iif(expr, truepart, falsepart)](https://support.microsoft.com/en-us/office/iif-function-32436ecf-c629-48a3-9900-647539c764e3)
Execute | [Shell(path, show)](https://support.microsoft.com/en-us/office/shell-function-ff2e4b1b-712d-4e34-aea6-6832eadd3c63) (disabled by default)

SQL injection:
- [MS Access SQL Injection Cheat Sheet](https://slaxcore.tistory.com/entry/MS-Access-SQL-Injection-Cheat-Sheet)
- [MS Access SQL Injection Cheat Sheet - Version 0.2](http://nibblesec.org/files/MSAccessSQLi/MSAccessSQLi.html)
- [WSTG - Latest | OWASP Foundation](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/07-Input_Validation_Testing/05.5-Testing_for_MS_Access)

## Tools
- Microsoft Access
  - Export: Excel, CSV, XML, PDF/XPS

- [mdbtools: MDB Tools - Read Access databases on \*nix](https://github.com/mdbtools/mdbtools)
  - Linux only
    - `apt install mdbtools`
    - [How do I install it on windows ? - Issue #107](https://github.com/mdbtools/mdbtools/issues/107)
      - [lsgunth/mdbtools-win: MDBTools built for 32bit windows using MSYS2](https://github.com/lsgunth/mdbtools-win)
  - `mdb-export`
    - CSV
    - SQL: `mdb-export --insert=sqlite db.mdb TABLE > TABLE.sql`
  - Can bypass passwords?
  - Backends: [mdbtools/src/libmdb/backend.c](https://github.com/mdbtools/mdbtools/blob/c6486ce68c9dee2663eeed3148d549515da69258/src/libmdb/backend.c#L148-L155)

  Python:
  - [polars\_access\_mdbtools: A library for reading tables from an Access database into Polars dataframes, using mdbtools](https://github.com/DeflateAwning/polars_access_mdbtools)

- [mdb2sqlite: Conversion tool used to convert microsoft access database to sqlite.](https://github.com/arturasn/mdb2sqlite)

- [MDB Viewer Plus - Open and edit MDB/Accdb files.](http://www.alexnolan.net/software/mdb_viewer_plus.htm)
  - 支持密码
  - Cannot export
  
  ```pwsh
  scoop bucket add hoilc_scoop-lemon https://github.com/hoilc/scoop-lemon
  scoop install hoilc_scoop-lemon/mdbplus
  ```

- [AccessLook: 免费Access数据库浏览和导出工具 | 下载中心 - 常用工具](http://www.webxml.com.cn/d/38644F4748762B4C7461593D.aspx)
  - .NET，不依赖 Access
  - 导出 SQL, XML, CSV
  - 不支持密码

- [whellcome/MSAccessToSQL: This project provides a Python-based utility to export the structure and data of MS Access databases into an SQL script](https://github.com/whellcome/MSAccessToSQL)
  - 不支持密码
  - 兼容性一般

[如何从Access导出数据-百度经验](https://jingyan.baidu.com/article/c275f6baf5d91fa23d7567ea.html)

[Convert MS Access to SQL? : r/MSAccess](https://www.reddit.com/r/MSAccess/comments/ldfhg6/convert_ms_access_to_sql/)

[How to export an entire Access database to SQL Server? - Stack Overflow](https://stackoverflow.com/questions/1307512/how-to-export-an-entire-access-database-to-sql-server)
