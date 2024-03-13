# Datatypes
[Datatypes In SQLite](https://www.sqlite.org/datatype3.html)

SQLite 是动态类型，创建表时指定的列类型只作为 type affinity，除了 `INTERGER PRIMARY KEY`，它会让列变成 `rowid` 的别名。

## Storage classes
- `NULL`
- `INTEGER`
- `REAL`
- `TEXT`

  只支持 UTF-8 和 UTF-16 编码
- `BLOB`

### `BLOB`
[Internal Versus External BLOBs](https://www.sqlite.org/intern-v-extern-blob.html)
> We deduce the following rules of thumb from the matrix above:
> - A database page size of 8192 or 16384 gives the best performance for large BLOB I/O.
> - For BLOBs smaller than 100KB, reads are faster when the BLOBs are stored directly in the database file. For BLOBs larger than 100KB, reads from a separate file are faster.

## Type affinity
判别机制很狗屎，"FLOATING PO<u>INT</u>" 会被判定成 `INTEGER`。

## Collating sequences
`TEXT` 排序方案，内建的只有三种：

- `BINARY`

  `memcmp`

- `NOCASE`

  `strnicmp`，大写转小写，终止零终止。

- `RTRIM`

[Define New Collating Sequences](https://www.sqlite.org/c3ref/create_collation.html)