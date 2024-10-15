# Archives
[Wikipedia](https://en.wikipedia.org/wiki/Archive_file)

> In computing, an archive file is a computer file that is composed of one or more files along with metadata. Many archive formats also support compression of member files. Archive files are used to collect multiple data files together into a single file for easier portability and storage, or simply to compress files to use less storage space. Archive files often store directory structures, error detection and correction information, comments, and some use built-in encryption.

[List of archive formats - Wikipedia](https://en.wikipedia.org/wiki/List_of_archive_formats)

[Which Compression Format to Use for Archiving - Ukiah Smith](https://ukiahsmith.com/blog/which-compression-format-to-use-for-archiving/)

[Common Compression File Formats | Scott Granneman](https://granneman.com/tech/background/compressionfileformats)

## Libraries
C++:
- [libarchive: Multi-format archive and compression library](https://github.com/libarchive/libarchive)
  - [vcpkg](https://vcpkg.io/en/package/libarchive)

  [LibarchiveFormats](https://github.com/libarchive/libarchive/wiki/LibarchiveFormats)

  Rust: [compress-tools-rs: A Swiss Army Knife for handling compressed data in Rust](https://github.com/OSSystems/compress-tools-rs)
  - > You must have `libarchive`, 3.2.0 or newer, properly installed on your system in order to use this. If building on \*nix and Windows GNU systems, `pkg-config` is used to locate the `libarchive`; on Windows MSVC, `vcpkg` will be used to locating the `libarchive`.

## Formats
- [Zap: An extremely fast alternative to zip which is written in rust.](https://github.com/SteveGremory/Zap) (inactive)
  - LZ4

  [ZAP: a VERY fast zip alternative, written in rust! : r/rust](https://www.reddit.com/r/rust/comments/yfsxn6/zap_a_very_fast_zip_alternative_written_in_rust/)