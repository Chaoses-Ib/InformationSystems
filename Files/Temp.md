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

APIs:
- [`GetTempPathW()`](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-gettemppathw)
  - `TMP`, `TEMP`, `USERPROFILE`, the Windows directory
- [`GetTempPath2W()`](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-gettemppath2w)
  - `SYSTEM`: `C:\Windows\SystemTemp`
  - Non-`SYSTEM`: behave the same as `GetTempPath()`

[Temp File Cleaner - Wikipedia](https://en.wikipedia.org/wiki/Temp_File_Cleaner)

#### Sessions
> By default, in windows server machines, when you login to the machines using Remote Desktop Session, it will create a temporary sub directory in the temp folder and redirects to this when we tried to access temp folder using `%TEMP%`.

e.g. `C:\Users\ADMINI~1\AppData\Local\Temp\1`

[Why does the name of my TEMP directory keep changing? - The Old New Thing](https://devblogs.microsoft.com/oldnewthing/20110125-00/?p=11673)

[Temporary Directories for RDP sessions on windows -- DevOPs Diary](https://devopsdiaryblog.wordpress.com/2017/09/08/temporary-directories-for-rdp-sessions-on-windows/)

[The %TEMP% folder with logon session ID is deleted - Windows Server | Microsoft Learn](https://learn.microsoft.com/en-us/troubleshoot/windows-server/shell-experience/temp-folder-with-logon-session-id-deleted)
> In Windows Server that has Desktop Experience installed, the `%TEMP%` folder that includes the session ID is deleted if you remain logged on to the computer for more than seven days. Therefore, some applications that have to access `%TEMP%` don't work correctly after that time.
- Only if `%TEMP%` folder is empty? But if it's empty why delete it?
- Storage Sense

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
  - [`env::override_temp_dir()`](https://docs.rs/tempfile/latest/tempfile/env/fn.override_temp_dir.html) (library-level)
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
