# Temporary Files
[Wikipedia](https://en.wikipedia.org/wiki/Temporary_file)

[Temporary folder - Wikipedia](https://en.wikipedia.org/wiki/Temporary_folder)

[tmpfs - Wikipedia](https://en.wikipedia.org/wiki/Tmpfs)

## OS
> The behavior of temporary files and temporary file cleaners differ by
operating system:

### Windows
> On Windows, temporary files are, by default, created in per-user temporary
file directories so only an application running as the same user would be
able to interfere (which they could do anyways). However, an application
running as the same user can still _accidentally_ re-create deleted
temporary files if the number of random bytes in the temporary file name is
too small.

[Temp File Cleaner - Wikipedia](https://en.wikipedia.org/wiki/Temp_File_Cleaner)

### macOS
> Like on Windows, temporary files are created in per-user temporary file
directories by default so calling `NamedTempFile::new()` should be
relatively safe.

### Linux
> Unfortunately, most _Linux_ distributions don't create per-user temporary
file directories. Worse, systemd's tmpfiles daemon (a common temporary file
cleaner) will happily remove open temporary files if they haven't been
modified within the last 10 days.

## Libraries
### Rust
- [`std::env::temp_dir`](https://doc.rust-lang.org/std/env/fn.temp_dir.html)
- [tempfile: Temporary file library for rust](https://github.com/Stebalien/tempfile)
  - Delete on drop / closing handle (file only)
  - `TempDir` and `temp_dir.path().join()` have no borrow relation, possibly lead to dangling path
- [temp_dir](https://docs.rs/temp-dir/0.1.14/temp_dir/), [temp_file](https://docs.rs/temp-file/0.1.9/temp_file/)
  - Delete on drop
  - Depends only on `std`
  - `forbid(unsafe_code)`
  - > Nicer API, in my opinion

  [temp-dir: Simple temporary directory with cleanup : r/rust](https://www.reddit.com/r/rust/comments/ma6y0x/tempdir_simple_temporary_directory_with_cleanup/)
- [rust-lang-deprecated/tempdir: Temporary directory management for Rust](https://github.com/rust-lang-deprecated/tempdir) (discontinued)
  - Delete on drop

  > tempdir seems to use completely deterministic information for its naming (pid and counter), so it might also be less secure as attackers can rather easily guess what temp filenames will be, which can be leveraged into arbitrary writes.
- [temp\_testdir: Simple temp dir manager for testing](https://github.com/la10736/temp_testdir)
- [test\_dir: Fast creation of file structure for testing purpose in Rust.](https://github.com/rpacholek/test_dir)
  - `.create()`
