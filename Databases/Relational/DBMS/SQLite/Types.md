# Datatypes
[Datatypes In SQLite](https://www.sqlite.org/datatype3.html)

SQLite 是动态类型，创建表时指定的列类型只作为 type affinity，除了 `INTERGER PRIMARY KEY`，它会让列变成 `rowid` 的别名。

## Storage classes
- `NULL`
- `INTEGER`

  The value is a signed integer, stored in 0, 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.

- `REAL`

  The value is a floating point value, stored as an 8-byte IEEE floating point number.

- `TEXT`

  The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE).

- `BLOB`

### `BLOB`
[Internal Versus External BLOBs](https://www.sqlite.org/intern-v-extern-blob.html)
> We deduce the following rules of thumb from the matrix above:
> - A database page size of 8192 or 16384 gives the best performance for large BLOB I/O.
> - For BLOBs smaller than 100KB, reads are faster when the BLOBs are stored directly in the database file. For BLOBs larger than 100KB, reads from a separate file are faster.

## Type affinity
判别机制很狗屎，"FLOATING PO<u>INT</u>" 会被判定成 `INTEGER`。

### `NUMERIC`
> A column with `NUMERIC` affinity may contain values using all five storage classes.
> - When text data is inserted into a `NUMERIC` column, the storage class of the text is converted to `INTEGER` or `REAL` (in order of preference) if the text is a well-formed integer or real literal, respectively.
> - If the TEXT value is a well-formed integer literal that is too large to fit in a 64-bit signed integer, it is converted to `REAL`.
> - For conversions between `TEXT` and `REAL` storage classes, only the first 15 significant decimal digits of the number are preserved.
> - If the `TEXT` value is not a well-formed integer or real literal, then the value is stored as `TEXT`.
> - Hexadecimal integer literals are not considered well-formed and are stored as TEXT. (This is done for historical compatibility with versions of SQLite prior to version 3.8.6 2014-08-15 where hexadecimal integer literals were first introduced into SQLite.)
> - If a floating point value that can be represented exactly as an integer is inserted into a column with `NUMERIC` affinity, the value is converted into an integer.
>
>   A string might look like a floating-point literal with a decimal point and/or exponent notation but as long as the value can be expressed as an integer, the `NUMERIC` affinity will convert it into an integer. Hence, the string `3.0e+5` is stored in a column with `NUMERIC` affinity as the integer `300000`, not as the floating point value `300000.0`.
> - No attempt is made to convert `NULL` or `BLOB` values.

A column that uses `INTEGER` affinity behaves the same as a column with `NUMERIC` affinity.

A column with `REAL` affinity behaves like a column with `NUMERIC` affinity except that it forces integer values into floating point representation. (As an internal optimization, small floating point values with no fractional component and stored in columns with `REAL` affinity are written to disk as integers in order to take up less space and are automatically converted back into floating point as the value is read out. This optimization is completely invisible at the SQL level and can only be detected by examining the raw bits of the database file.)

[SQLite Forum: The NUMERIC data type?](https://sqlite.org/forum/forumpost/6540c75cf6a7a3cb)

## Decimal
- `INTEGER`/`TEXT`/`BLOB` + user code

  [→Base-10 (decimal) floating-point Arithmetic](https://github.com/Chaoses-Ib/ComputationalMathematics/blob/main/Arithmetic/Floating-point/README.md#base-10-decimal)

- [The `decimal.c` extension](https://www.sqlite.org/floatingpoint.html#the_decimal_c_extension)

- [SQLite3 Decimal](https://chiselapp.com/user/lifepillar/repository/sqlite3decimal/index)

  [SQLite Forum: About the newly added decimal extension](https://sqlite.org/forum/forumpost/1166699aab)

## Collating sequences
`TEXT` 排序方案，内建的只有三种：

- `BINARY`

  `memcmp`

- `NOCASE`

  `strnicmp`，大写转小写，终止零终止。

- `RTRIM`

[Define New Collating Sequences](https://www.sqlite.org/c3ref/create_collation.html)