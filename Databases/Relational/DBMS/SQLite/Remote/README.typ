#import "@local/ib:0.1.0": *
#title[SQLite Remote]
- #a[TrailBase: An open, sub-millisecond, single-executable Firebase alternative with type-safe APIs, built-in WebAssembly runtime, realtime subscriptions, auth, and admin UI built on Rust, SQLite & Wasmtime.][https://github.com/trailbaseio/trailbase]
  - Filter expression

#a[Exposing SQLite db over network : r/sqlite][https://www.reddit.com/r/sqlite/comments/1kx22sd/exposing_sqlite_db_over_network/]

#a[DB administration worflow on SQLite database : r/sqlite][https://www.reddit.com/r/sqlite/comments/1akm7h1/db_administration_worflow_on_sqlite_database/]

#a[qt - Access sqlite from a remote server - Stack Overflow][https://stackoverflow.com/questions/8357496/access-sqlite-from-a-remote-server]

#a[SQLite remote tunneling : DBE-1436][https://youtrack.jetbrains.com/projects/DBE/issues/DBE-1436/SQLite-remote-tunneling]

= Remote API only
- #a[thevahidal/soul: 🕉 Soul | Automatic SQLite RESTful and realtime API server | Build CRUD APIs in minutes!][https://github.com/thevahidal/soul]
  - #a[Soul Studio: Web GUI for Soul][https://github.com/thevahidal/soul-studio]
    (inactive)

- #a[proofrock/ws4sqlite: Query sqlite via json+http][https://github.com/proofrock/ws4sqlite]
  #a-badge[https://news.ycombinator.com/item?id=30636796]
  #a-badge[https://www.reddit.com/r/sqlite/comments/sp7771/a_remote_interface_for_sqlite/]

- #a[Postlite: Postgres wire compatible SQLite proxy.][https://github.com/benbjohnson/postlite]
  (discontinued)

- #a[bradleyboy/tuql: Automatically create a GraphQL server from a SQLite database or a SQL file][https://github.com/bradleyboy/tuql]
  (discontinued)

= Remote UI
- GUI + RDP
  - SQLiteStudio
  - DB Browser for SQLite

- #a[sqlite-web: Web-based SQLite database browser written in Python][https://github.com/coleifer/sqlite-web]
  - Only basic features
    - Tables, Indexes, Triggers, Views
    - Column Rename/Drop
    - Rows, Order, Edit
      - Binary data as Base64
      - No filter
    - Query
      - Bookmarks
      - Cannot edit result rows
    - Export JSON/CSV
  - ```sh SQLITE_WEB_PASSWORD='pass' uvx --from sqlite-web sqlite_web a.db -P -H 127.0.0.1 -p 8080```

- #a[Navicat for SQLite][https://www.navicat.com/en/products/navicat-for-sqlite]
  - #a[Setting up HTTP Tunnel][https://www.navicat.com/manual/online_manual/en/navicat_datamodeler/linux_manual/index.html#/import_db_http]
    - PHP server:
      `ntunnel_sqlite.php`

      #a[Where can I get the HTTP tunnel script file? -- Navicat][https://help.navicat.com/hc/en-us/articles/218283457-Where-can-I-get-the-HTTP-tunnel-script-file]
    - #strike[#a[gparmeggiani/py-navicat-http-tunnel: Python implementation of Navicat's scripts for HTTP tunnelling][https://github.com/gparmeggiani/py-navicat-http-tunnel]]

- DBeaver
  - SSH tunnel
  - ODBC/JDBC
  - ```pwsh scoop install extras/dbeaver```

  #a[SQLite | DBeaver Documentation][https://dbeaver.com/docs/dbeaver/Database-driver-SQLite/#remote-database-connection]

- #a[joelseq/sqliteadmin-go: Admin tool for interacting with an embedded SQLite database][https://github.com/joelseq/sqliteadmin-go]
  (inactive)

- #strike[DB Browser for SQLite]

  #a[DBHub.io Shutdown - DB Browser for SQLite][https://sqlitebrowser.org/blog/dbhub-shutdown/]

  #a[Remote pane: what should be shown? - Issue \#2297 - sqlitebrowser/sqlitebrowser][https://github.com/sqlitebrowser/sqlitebrowser/issues/2297]
