# Indexes
## Unique indexes
> For the purposes of unique indices, all NULL values are considered different from all other NULL values and are thus unique. This is one of the two possible interpretations of the SQL-92 standard (the language in the standard is ambiguous). The interpretation used by SQLite is the same and is the interpretation followed by PostgreSQL, MySQL, Firebird, and Oracle. Informix and Microsoft SQL Server follow the other interpretation of the standard, which is that all NULL values are equal to one another.

[Is there any performance difference between UNIQUE INDEX and INDEX with the same cardinality on MySQL? - Database Administrators Stack Exchange](https://dba.stackexchange.com/questions/269293/is-there-any-performance-difference-between-unique-index-and-index-with-the-same)
> `INSERT` checks for uniqueness before acknowledging the insert. This slows down the response time (a little) for `INSERTs`. A plain `INDEX` is delayed and does not actually get performed until later. See "Change buffering". This speeds up non-unique index maintenance (a little).
> 
> A `SELECT`, when using a non-unique index will (unless something else stops it), will read rows until the value is different. With a `UNIQUE` index, it knows to stop after one row is found. (Again, a minor performance difference.)

[Does an UNIQUE constraint remove the need for an explicit index in Sqlite? - Stack Overflow](https://stackoverflow.com/questions/19357490/does-an-unique-constraint-remove-the-need-for-an-explicit-index-in-sqlite)
> `UNIQUE` and `PRIMARY KEY` constraints indeed create an internal index to speed up their lookups, so you do not need to create your own.

## SQLite
[CREATE INDEX](https://www.sqlite.org/lang_createindex.html)

[Partial Indexes](https://www.sqlite.org/partialindex.html)

[Query Planning](https://www.sqlite.org/queryplanner.html)

[The SQLite Query Optimizer Overview](https://www.sqlite.org/optoverview.html)

[sqlite - What is an automatic covering index? - Stack Overflow](https://stackoverflow.com/questions/20524686/what-is-an-automatic-covering-index)
> "Automatic" means that SQLite creates a temporary index that is used only for this query, and deleted afterwards. This happens when the cost of creating the index is estimated to be smaller than the cost of looking up records in the table without the index.
> 
> (A [covering index](http://www.sqlite.org/queryplanner.html#covidx) is an index that contains all the columns to be read, which means that the record corresponding to the index entry does not need to be looked up in the table.)

[Choosing the Right Index in SQLite](https://blog.sqlitecloud.io/choosing-the-right-index-in-sqlite)

### Multi-column indexes
[Query Planning](https://www.sqlite.org/queryplanner.html#_multi_column_indices)
> Hence, a good rule of thumb is that your database schema should never contain two indices where one index is a prefix of the other. Drop the index with fewer columns. SQLite will still be able to do efficient lookups with the longer index.

[sqlite - Does a multi-column index work for single column selects too? - Stack Overflow](https://stackoverflow.com/questions/796359/does-a-multi-column-index-work-for-single-column-selects-too)
> The first key in a multi key index can work just like a single key index but any subsequent keys will not.
> 
> As for how much faster the composite index is depends on your data and how you structure your index and query, but it is usually significant. The indexes essentially allow Sqlite to do a binary search on the fields.

> SQLite will NOT use the second column of an index if the first column was an inequality expression (eg customer>33 ). (most database engine would, tough).
