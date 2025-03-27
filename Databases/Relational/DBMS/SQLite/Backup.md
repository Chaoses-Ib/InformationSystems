# Backup
- File backup

  > This procedure works well in many scenarios and is usually very fast. However, this technique has the following shortcomings:
  > - Any database clients wishing to write to the database file while a backup is being created must wait until the shared lock is relinquished.
  > - It cannot be used to copy data to or from in-memory databases.
  > - If a power failure or operating system failure occurs while copying the database file the backup database may be corrupted following system recovery.

- [VACUUM INTO](https://www.sqlite.org/lang_vacuum.html#vacuuminto)

  > The advantage of using VACUUM INTO is that the resulting backup database is minimal in size and hence the amount of filesystem I/O may be reduced. Also, all deleted content is purged from the backup, leaving behind no forensic traces. On the other hand, the [backup API](https://www.sqlite.org/backup.html) uses fewer CPU cycles and can be executed incrementally.

- [Online Backup API](https://www.sqlite.org/backup.html)

  > The online backup API allows the contents of one database to be copied into another database file, replacing any original contents of the target database. The copy operation may be done incrementally, in which case the source database does not need to be locked for the duration of the copy, only for the brief periods of time when it is actually being read from. This allows other database users to continue without excessive delays while a backup of an online database is made.

- `sqlite3 db .dump`

  [sql - How to dump the data of some SQLite3 tables? - Stack Overflow](https://stackoverflow.com/questions/75675/how-to-dump-the-data-of-some-sqlite3-tables)

  [ios - How do I dump SQLite programmatically without command line - Stack Overflow](https://stackoverflow.com/questions/35523397/how-do-i-dump-sqlite-programmatically-without-command-line)

  [How do i dump the contents of an SQLite database without using the command line, but in Perl code? - Stack Overflow](https://stackoverflow.com/questions/4265700/how-do-i-dump-the-contents-of-an-sqlite-database-without-using-the-command-line)

- [sqlite3_rsync](https://www.sqlite.org/rsync.html)

WCDB:
- [元数据备份](https://github.com/Tencent/wcdb/wiki/C++-%E6%8D%9F%E5%9D%8F%E3%80%81%E5%A4%87%E4%BB%BD%E3%80%81%E4%BF%AE%E5%A4%8D#%E5%85%83%E6%95%B0%E6%8D%AE%E5%A4%87%E4%BB%BD)

  [五年沉淀，微信全平台终端数据库WCDB迎来重大升级！-腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/2406614)

[微信移动端数据库组件 WCDB 系列：数据库修复三板斧（二）-腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/1005513)
> 统计发现只有万分之一不到的用户会发生DB损坏，如果恢复方案 需要事先准备（比如备份），它必须对用户不可见，不能为了极个别牺牲全体用户的体验。
- 约 70% 为 `sqlite_master` 读取失败
