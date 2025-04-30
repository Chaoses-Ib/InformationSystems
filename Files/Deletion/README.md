
# File Deletion
[Wikipedia](https://en.wikipedia.org/wiki/File_deletion)

File deletion, file removal

Rust:
- `std::fs`
- [suptejas/delete: Fast, easy deletion of files and folders with async and cross-platform support.](https://github.com/suptejas/delete)

  > removes all files and folders in subfolders recursively using tokio workers ... 2-3x faster than `std::fs::remove_dir_all`
- [Himasnhu-AT/frm: Faster file deletion written in Rust, alternative to rm](https://github.com/Himasnhu-AT/frm)
- [mverleg/file\_shred: Secure file deletion from the command line](https://github.com/mverleg/file_shred)
- [ltpp-universe/file-operation: A Rust library providing a set of utilities for common file operations such as reading, writing, and querying file metadata like size. It aims to simplify file handling in Rust projects, offering safe and efficient file manipulation methods.](https://github.com/ltpp-universe/file-operation)

## Windows
Rust:
- [andfoy/force-delete-win: Force-delete a file or folder held by other Windows processes](https://github.com/andfoy/force-delete-win)
- [uwu/win-fast-rm: The actually faster way to delete files on Windows.](https://github.com/uwu/win-fast-rm)

## Clean
- Trigger: after usage, older than, larger than, period, on change, on process start/exit, on reboot, manual
- Clean strategy
  - All (pattern-based)
  - Time-based: used, older than, from oldest
  - Size-based: from largest
  - Number-based
    - \+ time-based rotation = time-based
    - \+ size-based rotation = size-based
  - Random
- Symbolic links (and junctions)
- Async
- IO idle align
- [→Temporary Files](../Temp.md)

Rust:
- [file-clean](https://github.com/16Hexa/file-clean)
- [abhinath84/neaten: A resource cleanup application](https://github.com/abhinath84/neaten)
- [ricardodantas/folder-declutter: A folder declutter program that delete files after some pre-defined time.](https://github.com/ricardodantas/folder-declutter)
- [amachang/rmjunk: a tool to remove junk files such as `.DS_Store` and `Thumbs.db` from directories.](https://github.com/amachang/rmjunk)

## Rotation
- Rotation strategies: size-based, age-based
- Compression at rotation
- Transparent abstraction

Rust:
- [kstrafe/file-rotate: File/log rotation writer for Rust](https://github.com/kstrafe/file-rotate)
- [qjerome/firo: rotating file implementation in Rust](https://github.com/qjerome/firo)
- [trayvonpan/logroller: LogRoller is a Rust library that simplifies log writing with automatic file rotation. It efficiently manages log files by creating new ones based on size or time, ensuring your application runs smoothly without filling up disk space. Perfect for keeping logs organized and easy to manage!](https://github.com/trayvonpan/logroller/)
  - Rotation strategies: size-based, age-based
  - Automatic Gzip compression for rotated log files
- [cacache-rs: A high-performance, concurrent, content-addressable disk cache, with support for both sync and async APIs. 💩💵 but for your 🦀](https://github.com/zkat/cacache-rs)
- [rifqideveloper/file\_indexing: library for editing file fast and memory efficient](https://github.com/rifqideveloper/file_indexing)
- [rksm/simple-file-rotation](https://github.com/rksm/simple-file-rotation)
- [file\_rotator - Rust](https://docs.rs/file-rotator/latest/file_rotator/)
- [rotating-file: A rotating file with customizable rotation behavior.](https://github.com/crypto-crawler/rotating-file)
- [dateframe - crates.io: Rust Package Registry](https://crates.io/crates/dateframe)
- [bonega/backedup: A command line util for backup rotation.](https://github.com/bonega/backedup)
