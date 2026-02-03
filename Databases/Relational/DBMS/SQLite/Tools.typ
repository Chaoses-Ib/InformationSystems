#import "@local/ib:0.1.0": *
#title[SQLite Tools]
= CLI
- SQLite official
  - `sqlite3`, `sqldiff`, `sqlite3_analyzer`, `sqlite3_rsync`
  - Debian: ```sh apt install sqlite3 sqlite3-tools```
  - Scoop: ```pwsh scoop install main/sqlite```

  #a[sqlite count rows of tables identified by subquery - Stack Overflow][https://stackoverflow.com/questions/21630539/sqlite-count-rows-of-tables-identified-by-subquery]

Python:
- #a[simonw/sqlite-utils: Python CLI utility and library for manipulating SQLite databases][https://github.com/simonw/sqlite-utils]
- #a[xeus-sql: Jupyter kernel for SQL databases][https://github.com/jupyter-xeus/xeus-sql]

= GUI
- #a[SQLiteStudio][https://sqlitestudio.pl/]
  #a-badge[https://github.com/pawelsalawa/sqlitestudio]
  - 支持 SQLCipher、wxSQLite3 和 ```cs System.Data.SQLite``` 加密。
  - Scoop: ```pwsh scoop install sqlitestudio```
  - Linux
    - Debian:
      ```sh apt install libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0```

      #a[Linux maintaining compliance - Issue \#3871][https://github.com/pawelsalawa/sqlitestudio/issues/3871]
      - #a[Set in Ubuntu repository - Issue \#5178][https://github.com/pawelsalawa/sqlitestudio/issues/5178]

      #a[3.3.2 fail start on debian due to xcb - Discussion \#4046][https://github.com/pawelsalawa/sqlitestudio/discussions/4046]

      #a[Cannot Run on Ubuntu or Remove - Discussion \#5251][https://github.com/pawelsalawa/sqlitestudio/discussions/5251]

- #a[DB Browser for SQLite][https://sqlitebrowser.org/]
  #a-badge[https://github.com/sqlitebrowser/sqlitebrowser]
  - 只支持 SQLCipher 加密。
  - Scoop: ```pwsh scoop install sqlitebrowser```
  - Debian: ```sh apt install sqlitebrowser```

- DBeaver
  - SSH tunnel
  - Scoop: ```pwsh scoop install extras/dbeaver```

  #a[SQLite | DBeaver Documentation][https://dbeaver.com/docs/dbeaver/Database-driver-SQLite/]

- #a[Navicat for SQLite][https://www.navicat.com/en/products/navicat-for-sqlite]
  - HTTP tunnel

#a[SQLite GUI : r/sqlite][https://www.reddit.com/r/sqlite/comments/xpsfes/sqlite_gui/]

#a[I just want to edit. Which tool should I use? : r/sqlite][https://www.reddit.com/r/sqlite/comments/zsmh8f/i_just_want_to_edit_which_tool_should_i_use/]

= Web
- →SQLite Remote UI
- #a[sqliteviz: Instant offline SQL-powered data visualisation in your browser][https://github.com/lana-k/sqliteviz]
