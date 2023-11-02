# SQL Injection
[实战渗透浅谈--一次巧合偶然的sql注入_woi_thc的博客 - CSDN博客](https://blog.csdn.net/qq_29437513/article/details/121632865)

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
- [Access](../../DBMS/Access/README.md#sql)

## Information sources
Quick reference:
- [SQL injection cheat sheet | Web Security Academy](https://portswigger.net/web-security/sql-injection/cheat-sheet)