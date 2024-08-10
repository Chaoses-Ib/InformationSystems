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