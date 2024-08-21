# File Systems
[Wikipedia](https://en.wikipedia.org/wiki/File_system)

A **file** is simply a linear array of bytes, each of which you can read or write. Each file has some kind of **low-level name**, usually a number of some kind; often, the user is not aware of this name. For historical reasons, the low-level name of a file is often referred to as its **inode number**.

A **directory**, like a file, also has a low-level name (i.e., an inode number), but its contents are quite specific: it contains a list of `(user-readable name, low-level name)` pairs. Each entry in a directory refers to either files or other directories. By placing directories within other directories, users are able to build an arbitrary **directory tree** (or **directory hierarchy**), under which all files and directories are stored.

The file system provides a convenient way to name all the files we are interested in. Names are important in systems as the first step to accessing any resource is being able to name it.[^three]

## File ID
Windows:
- [`BY_HANDLE_FILE_INFORMATION`](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/ns-fileapi-by_handle_file_information)
  - `dwVolumeSerialNumber`: u32
  - `nFileIndexHigh`: u32
  - `nFileIndexLow`: u32

  > The identifier that is stored in the `nFileIndexHigh` and `nFileIndexLow` members is called the file ID. Support for file IDs is file system-specific. File IDs are not guaranteed to be unique over time, because file systems are free to reuse them. In some cases, the file ID for a file can change over time.

  > In the FAT file system, the file ID is generated from the first cluster of the containing directory and the byte offset within the directory of the entry for the file. Some defragmentation products change this byte offset. (Windows in-box defragmentation does not.) Thus, a FAT file ID can change over time. Renaming a file in the FAT file system can also change the file ID, but only if the new file name is longer than the old one.

  > In the NTFS file system, a file keeps the same file ID until it is deleted. You can replace one file with another file without changing the file ID by using the [ReplaceFile](https://learn.microsoft.com/en-us/windows/desktop/api/winbase/nf-winbase-replacefilea) function. However, the file ID of the replacement file, not the replaced file, is retained as the file ID of the resulting file.

  > The ReFS file system, introduced with Windows Server 2012, includes 128-bit file identifiers. To retrieve the 128-bit file identifier use the [GetFileInformationByHandleEx](https://learn.microsoft.com/en-us/windows/desktop/api/winbase/nf-winbase-getfileinformationbyhandleex) function with **FileIdInfo** to retrieve the [FILE\_ID\_INFO](https://learn.microsoft.com/en-us/windows/desktop/api/winbase/ns-winbase-file_id_info) structure. The 64-bit identifier in this structure is not guaranteed to be unique on ReFS.

  Supported by SMB 3.0, from Windows 8 and Windows Server 2012.

- [`FILE_ID_INFO`](https://learn.microsoft.com/en-us/windows/win32/api/winbase/ns-winbase-file_id_info) (Windows Server 2012)
  - `VolumeSerialNumber`: u64
  - `FileId`: u128

Rust:
- [Expose Windows VolumeSerialNumber and FileIndex/FileId in std::os::windows::fs::MetadataExt - Issue #56180 - rust-lang/rust](https://github.com/rust-lang/rust/issues/56180)
  - [Tracking issue for `fs::Metadata` extensions on Windows based on handle information - Issue #63010 - rust-lang/rust](https://github.com/rust-lang/rust/issues/63010)
- [file\_id](https://docs.rs/file-id/latest/file_id/)
- [`winapi_util::file::Information`](https://docs.rs/winapi-util/latest/winapi_util/file/struct.Information.html#method.file_index)
  - [same-file: Cross platform Rust library for checking whether two file paths are the same file.](https://github.com/BurntSushi/same-file)

## Index nodes
One of the most important on-disk structures of a file system is the **inode**, which is the generic name that is used in many file systems to describe the structure that holds the metadata for a given file, such as its length, permissions, and the location of its constituent blocks. The name inode is short for index node, the historical name given to it in UNIX and possibly earlier systems, used because these nodes were originally arranged in an array, and the array indexed into when accessing a particular inode.[^three]

Pointers:
- Multi-level index

  Most files are small. This imbalanced design reflects such a reality; if most files are indeed small, it makes sense to optimize for this case.

  Examples: ext2, ext3, UNIX file system.
- Extends

  Examples: ext4.

## Times
- Windows: [File Times - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/sysinfo/file-times)

  [.net - Windows-compatible filesystems' file time resolutions - Stack Overflow](https://stackoverflow.com/questions/31519880/windows-compatible-filesystems-file-time-resolutions)

File systems:
- NTFS: 100ns
  - > The NTFS file system delays updates to the last access time for a file by up to 1 hour after the last access.
- FAT
  - Create time: 10ms
  - Write time: 2s
  - Access time: 1d
- exFAT: 10ms
- Live File System: 1us
- SMB
  - [`dos filetime resolution`](https://www.samba.org/samba/docs/using_samba/ch11.html): 2s

    > If set to yes, Samba rounds file times to the closest 2-second boundary. This option exists primarily to satisfy a quirk in Windows that prevents Visual C++ from correctly recognizing that a file has not changed. We recommend using this option only if you are using Microsoft Visual C++ on a Samba share that supports opportunistic locking.

    > Under the DOS and Windows FAT filesystem, the finest granularity on time resolution is two seconds. Setting this parameter for a share causes Samba to round the reported time down to the nearest two second boundary when a query call that requires one second resolution is made to smbd(8).
    > 
    > This option is mainly used as a compatibility option for Visual C++ when used against Samba shares. If oplocks are enabled on a share, Visual C++ uses two different time reading calls to check if a file has changed since it was last read. One of these calls uses a one-second granularity, the other uses a two second granularity. As the two second call rounds any odd second down, then if the file has a timestamp of an odd number of seconds then the two timestamps will not match and Visual C++ will keep reporting the file has changed. Setting this option causes the two timestamps to match, and Visual C++ is happy.

  [timestamp (or something) problems with Samba share](https://www.linuxquestions.org/questions/showthread.php?s=2dd4e3cfdd8c127ef6adb0d221fd1574&p=4096450#post4096450)

  [How can I get high-precision timestamps (better than 1s) with Samba? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/55567/how-can-i-get-high-precision-timestamps-better-than-1s-with-samba)

- WebDAV: 1s

  [WebDAV mounts loses precision, only gives up to second precision - Suspected Bug - rclone forum](https://forum.rclone.org/t/webdav-mounts-loses-precision-only-gives-up-to-second-precision/35487)

Rust:
- [`std::fs::File::set_times()`](https://doc.rust-lang.org/stable/std/fs/struct.File.html#method.set_times)
  - Not support directories.
- [filetime: Accessing file timestamps in a platform-agnostic fashion in Rust](https://github.com/alexcrichton/filetime)
  - `emulate_second_only_system`

[Reduce time stamp precision - Issue #12 - rfjakob/cshatag](https://github.com/rfjakob/cshatag/issues/12)

## POSIX
[2.5 Standard I/O Streams](https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/functions/V2_chap02.html#tag_15_05)

Creating files:
```c
int fd = open("foo", O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR);
```

The older way of creating a file is to call `creat()`:
```c
int fd = creat("foo"); // option: add second flag to set permissions
```

Because `open()` can create a file, the usage of `creat()` has somewhat fallen out of favor; however, it does hold a special place in UNIX lore. Specifically, when Ken Thompson was asked what he would do differently if he were redesigning UNIX, he replied: “I’d spell creat with an e.”[^three]


[^three]: Operating Systems: Three Easy Pieces