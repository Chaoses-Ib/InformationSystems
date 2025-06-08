# Paths
## Windows
Prefixes:
- Disk: `C:`
- UNC: `\\server\share`
- Device namespace: `\\.\COM42`
- Verbatim: `\\?\`
- Verbatim disk: `\\?\C:`
- Verbatim UNC: `\\?\UNC\server\share`

[Prefix in std::path - Rust](https://doc.rust-lang.org/nightly/std/path/enum.Prefix.html)

```rust
let path = Path::new("Z:");
println!("{:?}", path);
// "Z:"
println!("{:?}", fs::read_dir(path).unwrap().collect_vec());
// [Ok(DirEntry("Z:A")), Ok(DirEntry("Z:B"))]
println!("{:?}", fs::read_dir(path).unwrap().map(|d| fs::read_dir(d.unwrap().path()).unwrap().collect_vec())).collect_vec();
// [[Ok(DirEntry("Z:A\\1.txt")), Ok(DirEntry("Z:A\\2.txt"))], [Ok(DirEntry("Z:B\\3.txt"))]]
```

## Libraries
### Rust
- [std::path](https://doc.rust-lang.org/std/path/index.html)
- [camino: Like Rust's `std::path::Path`, but UTF-8.](https://github.com/camino-rs/camino)
- [chipsenkbeil/typed-path: Provides typed variants of Path and PathBuf for Unix and Windows](https://github.com/chipsenkbeil/typed-path)

  [\[typed-path\] New crate to parse and manipulate paths for unix and windows agnostic of compiled target : r/rust](https://www.reddit.com/r/rust/comments/wx3j81/typedpath_new_crate_to_parse_and_manipulate_paths/)
- Forward slashes
  - [rhysd/path-slash: Tiny Rust library to convert a file path from/to slash path](https://github.com/rhysd/path-slash)
  - typed-path
  - [unix\_path - Rust](https://docs.rs/unix_path/latest/unix_path/) (discontinued)
- [directories-rs: a mid-level library that provides config/cache/data paths, following the respective conventions on Linux, macOS and Windows](https://github.com/dirs-dev/directories-rs#basedirs)

## Security
[security - Is there a safe / sanitised filename function in Rust - Stack Overflow](https://stackoverflow.com/questions/43973219/is-there-a-safe-sanitised-filename-function-in-rust)

Rust:
- [sanitize-filename](https://github.com/kardeiz/sanitize-filename)
  - Name can be empty after `sanitize()`
- [sanitise\_file\_name](https://docs.rs/sanitise-file-name/latest/sanitise_file_name/) ([GitLab](https://gitlab.com/chris-morgan/sanitise-file-name))
- [tower-sanitize-path: Tower middleware to sanitize paths on requests](https://github.com/shuttle-hq/tower-sanitize-path)
- [filerefine: 🧹 FileRefine is a Rust-based CLI tool that renames files in a directory to remove unwanted or problematic characters from filenames.](https://github.com/trinhminhtriet/filerefine)