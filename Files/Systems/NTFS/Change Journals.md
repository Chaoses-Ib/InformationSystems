# Change Journals
[Wikipedia](https://en.wikipedia.org/wiki/USN_Journal)

> The change journal file, `\$Extend\$UsnJrnl`, is a sparse file in which NTFS stores records of changes to files and directories. Applications like the Windows File Replication Service (FRS) and the Windows Search service make use of the journal to respond to file and directory changes as they occur.[^winter]

[New Technologies File System (NTFS) - libyal/libfsntfs](https://github.com/libyal/libfsntfs/blob/main/documentation/New%20Technologies%20File%20System%20(NTFS).asciidoc#15-usn-change-journal)

[通过读取USN日志监控文件变动 | 记录坑的地方](https://www.qdebug.com/2020/06/02/%E9%80%9A%E8%BF%87%E8%AF%BB%E5%8F%96USN%E6%97%A5%E5%BF%97%E7%9B%91%E6%8E%A7%E6%96%87%E4%BB%B6%E5%8F%98%E5%8A%A8/)

## Renaming
A rename operation will fire both `USN_REASON_RENAME_OLD_NAME` and `USN_REASON_RENAME_NEW_NAME`.

`USN_REASON_RENAME_OLD_NAME` is necessary to process hard link renaming, but not necessary to process directory renaming. 

> Note that a problem arises where one of the hard-links is moved or renamed. In this case, the journal entries for the rename or move reflect the filename and parent file reference number of the affected link. The problem arises if you ask for only the summary "on-close" records. In such a case, you won't ever see the `USN_REASON_RENAME_OLD_NAME` record...because that USN entry never gets an associated `REASON_CLOSE` associated with it. Without this tidbit, you won't be able to easily determine which link's name or location was changed. You have to read the usn with ReadOnlyOnClose set to 0 in the `Read_Usn_Journal_Data_V0`. This is a far chattier query, but without it, you can't accurately associate the change with one link or the other.

[USN日志处理移动事件时的补充 | 记录坑的地方](https://www.qdebug.com/2021/01/25/USN%E6%97%A5%E5%BF%97%E5%A4%84%E7%90%86%E7%A7%BB%E5%8A%A8%E4%BA%8B%E4%BB%B6%E6%97%B6%E7%9A%84%E8%A1%A5%E5%85%85/)

## Standard information
- Last modification date and time
  - Write -> `USN_REASON_DATA_OVERWRITE`, `USN_REASON_DATA_EXTEND` or `USN_REASON_DATA_TRUNCATION`
  - Touch -> `USN_REASON_BASIC_INFO_CHANGE`

  However, `USN_RECORD` does not contain the new time.

  [Timestamp and `USN_REASON_BASIC_INFO_CHANGE` - @port139 Blog](https://port139.hatenablog.com/entry/2018/09/30/203343)

  [Manipulating LastWriteTime without leaving traces in the NTFS USN Journal | PSBits](https://gtworek.github.io/PSBits/lastwritetime.html)

## Hard links
- Identify: `USN_RECORD_V2.(FileReferenceNumber, ParentFileReferenceNumber, FileName)`
- Create: `USN_REASON_HARD_LINK_CHANGE`
- Delete: `USN_REASON_HARD_LINK_CHANGE`
- Rename: same as normal files

## API
> An application can configure the NTFS change journal facility by using the `DeviceIoControl` function’s `FSCTL_CREATE_USN_JOURNAL` file system control code (USN is update sequence number) to have NTFS record information about file and directory changes to an internal file called the change Mournal. A change journal is usually large enough to virtually guarantee that applications get a chance to process changes without missing any. Applications use the `FSCTL_QUERY_USN_JOURNAL` file system control code to read records from a change journal, and they can specify that the `DeviceIoControl` function not complete until new records are available.[^winter]

[Change Journals - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/fileio/change-journals)

[`USN_RECORD_V2` - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/api/winioctl/ns-winioctl-usn_record_v2)

[winapi - How to get the 'NextUSN' journal entry for a VSS snapshot? - Stack Overflow](https://stackoverflow.com/questions/10544433/how-to-get-the-nextusn-journal-entry-for-a-vss-snapshot)

## Libraries
C++:
- [libfsntfs: Library and tools to access the Windows New Technology File System (NTFS)](https://github.com/libyal/libfsntfs/)

Rust:
- ~~[usn-journal: An idiomatic Rust wrapper for the USN Journal on Windows](https://github.com/codeprentice-org/usn-journal)~~
- ~~[Change Journal: A unified change journal-like API for Linux and Windows that lets you monitor entire filesystems, mount points, and/or volumes for file change events. It uses fanotify on Linux and the USN Journal on Windows.](https://github.com/codeprentice-org/change-journal)~~

## Tools
- [fsutil usn](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/fsutil-usn)
- [Everything](../../Windows/README.md#everything)


[^winter]: Windows Internals