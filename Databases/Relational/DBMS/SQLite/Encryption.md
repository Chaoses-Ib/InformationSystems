# Encryption
SQLite 没有实现加密，不过预留了自定义实现的接口。

## SQLite Encryption Extension
[SQLite Encryption Extension: Documentation](https://www.sqlite.org/see/doc/release/www/index.wiki)

[How To Compile And Use SEE](https://www.sqlite.org/see/doc/release/www/readme.wiki)

- 激活：

  ```c
  sqlite3_activate_see("7bb07b8d471d642e");
  ```
  ```sql
  PRAGMA activate_extensions='see-7bb07b8d471d642e';
  ```

- `sqlite3_open()`

- `sqlite3_key_v2()`

  ```cpp
  int sqlite3_key_v2(
    sqlite3 *db,         /* The connection from sqlite3_open() */
    const char *zDbName, /* Which ATTACHed database to key */
    const void *pKey,    /* The key */
    int nKey             /* Number of bytes in the key */
  );
  ```
  ```sql
  PRAGMA key='your-secret-key';
  ```
  ```sql
  PRAGMA hexkey='796f75722d7365637265742d6b6579';
  ```
  ```sql
  -- the text passphrase is hashed to compute the actual encryption key
  PRAGMA textkey='your-secret-key';
  ```

  用相应的 rekey 来修改 key

	> The key may begin with a prefix to specify which algorithm to use. The prefix must be exactly one of "rc4:", "aes128:", or "aes256:". The default is "aes128".

  注意，在 hexkey 中使用 prefix 时，prefix 也必须被 hex 编码。

- ATTACH

  ```sql
  ATTACH DATABASE 'file2.db' AS two KEY 'xyzzy';
  ```
  If the `KEY` clause is omitted, the same key is used that is currently in use by the main database.

## 逆向
动态库十分简单，不再赘述，静态库可用如下方法：

- key 必须在 open 之后，建表之前，因此如果找不到 `sqlite3_key()` 的话，可以从 create table 文本或者 open 特征入手。

- `sqlite3_libversion()` 获取版本号，例如 "3.22.0"，再 BinDiff。

  [Run-Time Library Version Numbers](https://www.sqlite.org/c3ref/libversion.html)

- 测试工具推荐使用 SQLiteStudio，支持 SQLCipher、wxSQLite3 和 System.Data.SQLite 加密。

## SQLCipher
[SQLCipher - Zetetic](https://www.zetetic.net/sqlcipher/)

Uses openSSL's libcrypto to implement.

## wxSQLite3
[utelle/wxsqlite3: wxSQLite3 - SQLite3 database wrapper for wxWidgets (including SQLite3 encryption extension)](https://github.com/utelle/wxsqlite3)

C++ 包装依赖 wxWidgets，直接用 SQLite API 的话不需要。

## SQLite3 Multiple Ciphers
[Overview | SQLite3 Multiple Ciphers](https://utelle.github.io/SQLite3MultipleCiphers/)

[utelle/SQLite3MultipleCiphers: SQLite3 encryption extension with support for multiple ciphers](https://github.com/utelle/SQLite3MultipleCiphers)