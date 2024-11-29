# tar
[Wikipedia](https://en.wikipedia.org/wiki/Tar_(computing))

## Libraries
Rust:
- [tar-rs: Tar file reading/writing for Rust](https://github.com/alexcrichton/tar-rs)
- [tar-parser.rs: tar file parser written in rust using nom](https://github.com/Berrysoft/tar-parser.rs)

## Tools
- tar
  - `scoop install tar`
- [Windows tar](#windows)
- 7-Zip: `7z -ttar`
  - Deflate, ...
- Directory Opus: No compression

### Windows
- 支持 Deflate (zlib)
- Windows 11 24H2 的 tar 支持了 LZMA、bzip2 和 zstd
- Case insensitive
- `-h, --dereference` is not supported

Windows 21H2 (20348.2700):
```sh
tar(bsdtar): manipulate archive files
First option must be a mode specifier:
  -c Create  -r Add/Replace  -t List  -u Update  -x Extract
Common Options:
  -b #  Use # 512-byte records per I/O block
  -f <filename>  Location of archive (default \\.\tape0)
  -v    Verbose
  -w    Interactive
Create: tar -c [options] [<file> | <dir> | @<archive> | -C <dir> ]
  <file>, <dir>  add these items to archive
  -z, -j, -J, --lzma  Compress archive with gzip/bzip2/xz/lzma
  --format {ustar|pax|cpio|shar}  Select archive format
  --exclude <pattern>  Skip files that match pattern
  -C <dir>  Change to <dir> before processing remaining files
  @<archive>  Add entries from <archive> to output
List: tar -t [options] [<patterns>]
  <patterns>  If specified, list only entries that match
Extract: tar -x [options] [<patterns>]
  <patterns>  If specified, extract only entries that match
  -k    Keep (don't overwrite) existing files
  -m    Don't restore modification times
  -O    Write entries to stdout, don't restore to disk
  -p    Restore permissions (including ACLs, owner, file flags)
bsdtar 3.5.2 - libarchive 3.5.2 zlib/1.2.5.f-ipp
```

Windows 24H2 (26100.2033):
```sh
tar.exe(bsdtar): manipulate archive files
First option must be a mode specifier:
  -c Create  -r Add/Replace  -t List  -u Update  -x Extract
Common Options:
  -b #  Use # 512-byte records per I/O block
  -f <filename>  Location of archive (default \\.\tape0)
  -v    Verbose
  -w    Interactive
Create: tar.exe -c [options] [<file> | <dir> | @<archive> | -C <dir> ]
  <file>, <dir>  add these items to archive
  -z, -j, -J, --lzma  Compress archive with gzip/bzip2/xz/lzma
  --format {ustar|pax|cpio|shar}  Select archive format
  --exclude <pattern>  Skip files that match pattern
  -C <dir>  Change to <dir> before processing remaining files
  @<archive>  Add entries from <archive> to output
List: tar.exe -t [options] [<patterns>]
  <patterns>  If specified, list only entries that match
Extract: tar.exe -x [options] [<patterns>]
  <patterns>  If specified, extract only entries that match
  -k    Keep (don't overwrite) existing files
  -m    Don't restore modification times
  -O    Write entries to stdout, don't restore to disk
  -p    Restore permissions (including ACLs, owner, file flags)
bsdtar 3.7.2 - libarchive 3.7.2 zlib/1.2.13.1-motley liblzma/5.4.3 bz2lib/1.0.8 libzstd/1.5.5
```