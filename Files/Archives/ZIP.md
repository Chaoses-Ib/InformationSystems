# ZIP
[Wikipedia](https://en.wikipedia.org/wiki/ZIP_(file_format))

[Specifications - libzip](https://libzip.org/specifications/)

- Compression: [DEFLATE](../../Compression/README.md#lz77--huffman-deflate), ...
  - Other compression algorithms are not widely supported
- Can contain files with the same name, though some tools don't support this
  - Support: 7-Zip, NanaZip
  - Not support: unzip (Debian), Explorer, Directory Opus, WinRAR

## Paths
- The path separator must be `/`

  > 4.4.17.1 The name of the file, with optional relative path.
  > The path stored MUST NOT contain a drive or
  > device letter, or a leading slash.  All slashes
  > MUST be forward slashes '/' as opposed to
  > backwards slashes '\' for compatibility with Amiga
  > and UNIX file systems etc.  If input came from standard
  > input, there is no file name field.  

  Implementations:
  - libarchive
    - Windows: ✔️
  - WinRAR: ✔️
  - 360压缩: `\` as two spaces

    > 🌚360压缩居然不兼容用 `\` 当路径分隔符的 zip，只支持 `/` ，win 自带的和 winrar 都兼容

  Zip paths should always use forward slashes (`/`) as separators.

  [Zip file path separator - Stack Overflow](https://stackoverflow.com/questions/60276764/zip-file-path-separator)

  [windows - Zip files expand with backslashes on Linux, no subdirectories - Super User](https://superuser.com/questions/1382839/zip-files-expand-with-backslashes-on-linux-no-subdirectories)

  [Mitigation: ZipArchiveEntry.FullName Path Separator - .NET Framework | Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/framework/migration-guide/mitigation-ziparchiveentry-fullname-path-separator)
  > Starting with apps that target the .NET Framework 4.6.1, the path separator used in the `ZipArchiveEntry.FullName` property has changed from the backslash (`\`) used in previous versions of the .NET Framework to a forward slash (`/`).

  [Only write cross platform compatible directory separators in Compress-Archive by mryanmurphy - Pull Request #62 - PowerShell/Microsoft.PowerShell.Archive](https://github.com/PowerShell/Microsoft.PowerShell.Archive/pull/62)

## File attributes
- Internal file attributes
  - Text
  - Record length control
- External file attributes (OS)
  - [Setting external file attributes - Issue #433 - zip-rs/zip2](https://github.com/zip-rs/zip2/issues/433)

## Libraries
[→Archives libraries](README.md#libraries)

### C++
- [libzip: A C library for reading, creating, and modifying zip archives.](https://github.com/nih-at/libzip)

### Rust
- ~~[zip: Zip implementation in Rust](https://github.com/zip-rs/zip)~~
  - [zip2: Zip implementation in Rust](https://github.com/zip-rs/zip2)
    - Cumbersome API
    - Smart extract: `extract_unwrapped_root_dir()`
    - Cannot remove a file directly
      - [Deletion of zip entries in-place - Issue #166](https://github.com/zip-rs/zip2/issues/166)
      - [How to delete an entry from zip archive - Issue #13](https://github.com/zip-rs/zip2/issues/13)
    - `merge_archive()` will retain files with the same name
      - [merge\_archives creating corrupted archives - Issue #271](https://github.com/zip-rs/zip2/issues/271)
    - Features
      - Without zopfli: `zip = { version = "2", default-features = false, features = ["deflate-flate2", "flate2"] }; flate2 = { version = "1", default-features = false, features = ["zlib-rs"] }`
      - [Zopfli unusable on its own - Issue #273](https://github.com/zip-rs/zip2/issues/273)
    - Binary size
      - `default-features = false, features = ["deflate"]`: 0.47 MiB
    - [Release series 2.x issue: invalid zip file with overlapped components. - Issue #249](https://github.com/zip-rs/zip2/issues/249)
    - [Yank both 2.6.0 and 2.6.1 as they both introduce a breaking change and republish as 3.0.0 - Issue #337](https://github.com/zip-rs/zip2/issues/337)
  
  Libraries:
  - [zip-extract: Extract zip archives using the zip crate.](https://github.com/MCOfficer/zip-extract)
  - [zip-extensions-rs: Provides extensions for the zip crate](https://github.com/matzefriedrich/zip-extensions-rs)
    - [Appending files and directories - Issue #18](https://github.com/matzefriedrich/zip-extensions-rs/issues/18)
    - Bad code quality

- [mtzip: A rust library for making zip files, focused on multithreading the process](https://github.com/JohnTheCoolingFan/mtzip)
  - > Because Deflate compression cannot be multithreaded, the multithreading is achieved by having the files compressed individually. This means that if you have 12 threads available but only 6 files being added to the archive, you will only use 6 threads.

- [zipit: Create and stream a zip archive into an AsyncWrite](https://github.com/scotow/zipit)
  - No compression (stored method only).
  - Only files (no directories).
  - No customizable external file attributes.
- [wasm-zip-stream: A stream style zip compressing tool running in web browsers](https://github.com/LittleSaya/wasm-zip-stream)

- [stream-unzip: A streaming unzip library for rust projects](https://github.com/jsoverson/stream-unzip)

- [vfs-zip: Virtual FileSystem abstractions for ZIP files](https://github.com/MaulingMonkey/vfs-zip) (discontinued)

[High-Level Zip Library and Rust Libraries in General : r/rust](https://www.reddit.com/r/rust/comments/w9ok61/highlevel_zip_library_and_rust_libraries_in/)

### .NET
- `System.IO.Compression`
  - [`ZipFile`](https://learn.microsoft.com/en-us/dotnet/api/system.io.compression.zipfile?view=net-8.0)
  - [`ZipArchive`](https://learn.microsoft.com/en-us/dotnet/api/system.io.compression.ziparchive)
- [ZipStorer: A Pure C# Class to Store Files in Zip](https://github.com/jaime-olivares/zipstorer)

[compression - How do I ZIP a file in C#, using no 3rd-party APIs? - Stack Overflow](https://stackoverflow.com/questions/940582/how-do-i-zip-a-file-in-c-using-no-3rd-party-apis)