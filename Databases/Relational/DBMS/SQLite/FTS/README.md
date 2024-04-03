# Full-text Search
[SQLite FTS5 Extension](https://www.sqlite.org/fts5.html)

> The FTS index is an ordered key-value store where the keys are document terms or term prefixes and the associated values are "doclists". A doclist is a packed array of varints that encodes the position of each instance of the term within the FTS5 table. The position of a single term instance is defined as the combination of:
> - The rowid of the FTS5 table row it appears in,
> - The index of the column the term instance appears in (columns are numbered from left to right starting from zero), and
> - The offset of the term within the column value (i.e. the number of tokens that appear within the column value before this one).

> Instead of using a single data structure on disk to store the full-text index, FTS5 uses a series of b-trees. Each time a new transaction is committed, a new b-tree containing the contents of the committed transaction is written into the database file. When the full-text index is queried, each b-tree must be queried individually and the results merged before being returned to the user.

```sql
-- This table contains most of the full-text index data.
-- id = segid << 38 | is_doclist_index << 37 | height << 32 | pgno
CREATE TABLE %_data(id INTEGER PRIMARY KEY, block BLOB);

-- This table contains the remainder of the full-text index data. 
-- It is almost always much smaller than the %_data table. 
CREATE TABLE %_idx(segid, term, pgno, PRIMARY KEY(segid, term)) WITHOUT ROWID;

-- Contains the values of persistent configuration parameters.
CREATE TABLE %_config(k PRIMARY KEY, v) WITHOUT ROWID;

-- Contains the size of each column of each row in the virtual table
-- in tokens. This shadow table is not present if the "columnsize"
-- option is set to 0.
CREATE TABLE %_docsize(id INTEGER PRIMARY KEY, sz BLOB);

-- Contains the actual data inserted into the FTS5 table. There
-- is one "cN" column for each indexed column in the FTS5 table.
-- This shadow table is not present for contentless or external 
-- content FTS5 tables. 
CREATE TABLE %_content(id INTEGER PRIMARY KEY, c0, c1...);
```

[Structure of FTS5 Index in SQLite](https://darksi.de/13.sqlite-fts5-structure/)

虽然文档大小不会影响倒查索引本身的性能，但为了支持更新和删除文档，FTS 需要保存文档本身，因此文档大小也会影响数据库的性能：[`BLOB`](../Types.md#blob)。

[微信全文搜索优化之路 - 掘金](https://juejin.cn/post/6844903504419504135)

## Contentless tables
[External Content and Contentless Tables](https://www.sqlite.org/fts5.html#external_content_and_contentless_tables)

```sql
CREATE VIRTUAL TABLE f1 USING fts5(a, b, c, content='');
```
(If there is no value after `content`, it will be recognized as a normal column instead of an option.)

- Contentless tables
  
  Contentless tables do not support `UPDATE` or `DELETE` statements, or `INSERT` statements that do not supply a non-NULL value for the rowid field.

  `INSERT INTO {table}({table}) VALUES('delete-all');`

- Contentless-delete tables

  ```sql
  CREATE VIRTUAL TABLE f1 USING fts5(a, b, c, content='', contentless_delete=1);
  ```
  - Support both `DELETE` and "`INSERT OR REPLACE INTO`" statements.
  - Support `UPDATE` statements, but only if new values are supplied for all user-defined columns of the fts5 table.

    ```sql
    UPDATE f1 SET a=?, b=?, c=? WHERE rowid=?;
    ```
  - Not support the FTS5 delete command.

  Unless backwards compatibility is required, new code should prefer contentless-delete tables to contentless tables.

- Contentless tables do not support `REPLACE` conflict handling. `REPLACE` and `INSERT OR REPLACE` statements are treated as regular `INSERT` statements. Rows may be deleted from a contentless table using an FTS5 delete command.

- Full-text queries and some auxiliary functions can still be used, but no column values apart from the `rowid` may be read from the table.
  - Since `rowid` can only be integers, the client must be able to locate the original documents with integers.
  - `bm25()` (`rank`) can be used with contentless tables.

[Contentless SQLite FTS4 Tables for Large Immutable Documents - The Guinea Pig in the Cocoa Mine](http://cocoamine.net/blog/2015/09/07/contentless-fts4-for-large-immutable-documents/)

## Query
[Full-text Query Syntax](https://www.sqlite.org/fts5.html#full_text_query_syntax)

FTS 的搜索性能较好，在匹配索引很少时可以在一毫秒内完成查询，对于 0.3 GB 的数据也能在 200ms 内完成查询，不过要注意进行 `LIMIT`，否则在返回大量结果时耗时会比较长。

FTS5 还支持比较复杂的匹配语法，比如通过前缀匹配词组、匹配连续词组、按顺序匹配词组、多词组距离限制、逻辑运算符。

## Prefix queries
[FTS5 Prefix Queries](https://www.sqlite.org/fts5.html#fts5_prefix_queries)

- SQLite FTS 内置有 prefix 查询支持，不需要 prefix 索引，但也可以选择按字符数建立一个或多个 prefix 索引来提高性能。
- 相比查询单个 token，查询 prefix 可能需要几倍到几十倍的时间。不过由于查询耗时本身在毫秒级，查询 prefix 耗时并不长。
  - 相比以 prefix 开头的 token 种类数，token 出现的次数本身对性能的影响更大。比如以 "n" 为 prefix 进行查询时，有 108 种 token，耗时是 70x；而以 "a" 为 prefix 进行查询时，只有 40 种 token，但耗时是 130x。
- 和查询单个 token 一样，如果不进行 LIMIT，查询结果较多的 prefix 时可能需要普通查询上千倍的时间。
- 建立 prefix 索引能够降低 prefix 查询 5~50ms 的耗时（进行 LIMIT 时为 5~15ms），但会增加 30% 左右的构建耗时，15~45% 的数据库体积。
- 另外，如果中文使用了单字分词，不需要使用 prefix 查询。对中文使用 prefix 查询会略微降低性能。

建议对于英文在只输入了一个字母时不进行查询，在输入了更多字母或已经输入了其它词时再进行查询。后两种情况的 prefix 查询耗时都不高，没有必要建立 prefix 索引。

### Prefix indexes
> By default, FTS5 maintains a single index recording the location of each token instance within the document set. This means that querying for complete tokens is fast, as it requires a single lookup, but querying for a prefix token can be slow, as it requires a range scan. For example, to query for the prefix token `abc*` requires a range scan of all tokens greater than or equal to `abc` and less than `abd`.
> 
> A prefix index is a separate index that records the location of all instances of prefix tokens of a certain length in characters used to speed up queries for prefix tokens. For example, optimizing a query for prefix token `abc*` requires a prefix index of three-character prefixes.
> 
> To add prefix indexes to an FTS5 table, the "prefix" option is set to either a single positive integer or a text value containing a white-space separated list of one or more positive integer values. A prefix index is created for each integer specified. If more than one "prefix" option is specified as part of a single `CREATE VIRTUAL TABLE` statement, all apply.

```sql
-- Two ways to create an FTS5 table that maintains prefix indexes for
-- two and three character prefix tokens.
CREATE VIRTUAL TABLE ft USING fts5(a, b, prefix='2 3');
CREATE VIRTUAL TABLE ft USING fts5(a, b, prefix=2, prefix=3);
```

具体实现不明，无法用工具在 tables 或 indexes 中查看到。

## Merge operation
- `automerge`

  > In order to prevent the number of b-trees in the database from becoming too large (slowing down queries), smaller b-trees are periodically merged into single larger b-trees containing the same data. By default, this happens automatically within `INSERT`, `UPDATE` or `DELETE` statements that modify the full-text index. The `automerge` parameter determines how many smaller b-trees are merged together at a time. Setting it to a small value can speed up queries (as they have to query and merge the results from fewer b-trees), but can also slow down writing to the database (as each `INSERT`, `UPDATE` or `DELETE` statement has to do more work as part of the automatic merging process).

  > The maximum allowed value for the `automerge` parameter is 16. The default value is 4.

- `optimize`

  ```sql
  INSERT INTO ft(ft) VALUES('optimize');
  ```
  也可能反过来导致数据库增大。

## Bulk-inserting
```sql
INSERT INTO ft(ft, rank) VALUES('automerge', 0);
INSERT INTO ft(ft, rank) VALUES('crisismerge', 100000000);
INSERT ...
INSERT INTO ft(ft) VALUES('optimize');
INSERT INTO ft(ft, rank) VALUES('automerge', 4);
INSERT INTO ft(ft, rank) VALUES('crisismerge', 16);
```
SQLite FTS5 的内部结构使用了 [segment b-tree](https://www.sqlite.org/fts5.html#segment_b_tree_format)，和 RocksDB 的 LSM tree 一样需要不定期 merge 来保持性能。不过和 RocksDB 不同，虽然禁止 FTS5 自动 merge 可以加速 bulk-inserting，但不进行 optimize 会导致查询性能大幅下降；而进行 optimize 虽然又会导致 bulk-inserting 的总时间接近于不禁止自动 merge，但 optimize 后的查询性能要高于自动 merge，因此总体还是提升了性能。

## Sorting
[Sorting by Auxiliary Function Results](https://www.sqlite.org/fts5.html#sorting_by_auxiliary_function_results)

只 `COUNT(*)` 的话只需要正常查询 5%~33% 的时间，主要是排序比较耗时。

### BM25
[Okapi BM25 - Wikipedia](https://en.wikipedia.org/wiki/Okapi_BM25)

> The difference between reading from the `rank` column and using the `bm25()` function directly within the query is only significant when sorting by the returned value.
> ```sql
> -- The following queries are logically equivalent. But the second may
> -- be faster, particularly if the caller abandons the query before
> -- all rows have been returned (or if the queries were modified to 
> -- include LIMIT clauses).
> SELECT * FROM fts WHERE fts MATCH ? ORDER BY bm25(fts);
> SELECT * FROM fts WHERE fts MATCH ? ORDER BY rank;
> ```

BM25 is smaller-better.

`bm25()` can only be used on the entire table, not on a single column. But the weigets of every column can be set separately.
- [SQLite Forum: FTS5: calculating column weight dynamically?](https://sqlite.org/forum/info/4e3fa41c48087701)
- [rads/sqlite-okapi-bm25: 📑 SQLite extension to add the Okapi BM25 ranking algorithm](https://github.com/rads/sqlite-okapi-bm25)

Is `rank` persistent or calculated on the fly? On the fly.

## Extensions
[微信团队分享：微信移动端的全文检索多音字问题解决方案-腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/1198371)
- [Simple tokenizer: 支持中文和拼音的 SQLite fts5 全文搜索扩展 ｜ A SQLite3 fts5 tokenizer which supports Chinese and PinYin](https://github.com/wangfenjin/simple)

  [Simple: 一个支持中文和拼音搜索的 sqlite fts5插件 :: Wang Fenjin](https://www.wangfenjin.com/posts/simple-tokenizer/)

  - 构建性能在数据量较少时可以接受，约 5~20 MiB/s。
  - 不索引拼音的情况下，FTS 数据库的大小约为原始数据的 1.5~2.5 倍；索引拼音后约为 3.5~4.5 倍。
  - 是否索引拼音对搜索性能影响不大，不过会小幅提高搜索时的内存峰值。
  - 由于 `simple_query()` 会将连续字母当作拼音进行拆分，它对含字母查询的性能影响很大，并且查询越长影响越大。如果要支持拼音搜索，推荐只对中文用户开启。

### Tokenizers
FTS5 features three built-in tokenizer modules:
- The **unicode61** tokenizer, based on the Unicode 6.1 standard. This is the default.
- The **ascii** tokenizer, which assumes all characters outside of the ASCII codepoint range (0-127) are to be treated as token characters.
- The **porter** tokenizer, which implements the [porter stemming algorithm](https://tartarus.org/martin/PorterStemmer).

Custom tokenizers:
```c
typedef struct Fts5Tokenizer Fts5Tokenizer;
typedef struct fts5_tokenizer fts5_tokenizer;
struct fts5_tokenizer {
  int (*xCreate)(void*, const char **azArg, int nArg, Fts5Tokenizer **ppOut);
  void (*xDelete)(Fts5Tokenizer*);
  int (*xTokenize)(Fts5Tokenizer*, 
      void *pCtx,
      int flags,            /* Mask of FTS5_TOKENIZE_* flags */
      const char *pText, int nText, 
      int (*xToken)(
        void *pCtx,         /* Copy of 2nd argument to xTokenize() */
        int tflags,         /* Mask of FTS5_TOKEN_* flags */
        const char *pToken, /* Pointer to buffer containing token */
        int nToken,         /* Size of token in bytes */
        int iStart,         /* Byte offset of token within input text */
        int iEnd            /* Byte offset of end of token within input text */
      )
  );
};

/* Flags that may be passed as the third argument to xTokenize() */
#define FTS5_TOKENIZE_QUERY     0x0001
#define FTS5_TOKENIZE_PREFIX    0x0002
#define FTS5_TOKENIZE_DOCUMENT  0x0004
#define FTS5_TOKENIZE_AUX       0x0008

/* Flags that may be passed by the tokenizer implementation back to FTS5
** as the third argument to the supplied xToken callback. */
#define FTS5_TOKEN_COLOCATED    0x0001      /* Same position as prev. token */
```