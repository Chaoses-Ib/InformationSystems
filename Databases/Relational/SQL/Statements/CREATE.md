# CREATE
## CREATE TABLE
- [How to create a table with no columns in SQLite? - Stack Overflow](https://stackoverflow.com/questions/4567180/how-to-create-a-table-with-no-columns-in-sqlite)
  
  > Zero-column tables aren't supported in SQLite. Or in the SQL standard either.

  In SQLite, even virtual tables (FTS5) must have at least one column.

- `CREATE VIRTUAL TABLE IF NOT EXISTS` will not update the schema if the table already exists.