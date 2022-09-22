# SQL Injection
## Filters
Keyword:
- Case-sensitive: `SeLeCt`
- Replacement: `SELselectECT`, `UNunionION`
- Character espace: `selec\x74`, `unio\x6e`

Whitespace:
- Special whitespace: `%09`, `%0a`, `%0d`, `%a0`, `%2520`
- Comments: `/**/`
- Parentheses: `(...)`, `[...]`
- Floating-point numbers: `8E0`[^zu1k]

[^zu1k]: [sql注入针对关键字过滤的绕过技巧 - zu1k](https://zu1k.com/posts/security/web-security/bypass-tech-for-sql-injection-keyword-filtering/)

## DBMS
- [Access](DBMS/Access/README.md#sql)

## Information sources
Quick reference:
- [SQL injection cheat sheet | Web Security Academy](https://portswigger.net/web-security/sql-injection/cheat-sheet)