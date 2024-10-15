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