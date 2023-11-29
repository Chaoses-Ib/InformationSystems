# Change Journals
[Wikipedia](https://en.wikipedia.org/wiki/USN_Journal)

> The change journal file, `\$Extend\$UsnJrnl`, is a sparse file in which NTFS stores records of changes to files and directories. Applications like the Windows File Replication Service (FRS) and the Windows Search service make use of the journal to respond to file and directory changes as they occur.[^winter]

[New Technologies File System (NTFS) - libyal/libfsntfs](https://github.com/libyal/libfsntfs/blob/main/documentation/New%20Technologies%20File%20System%20(NTFS).asciidoc#15-usn-change-journal)

## Standard information
- Last modification date and time
  - Write -> `USN_REASON_DATA_OVERWRITE`, `USN_REASON_DATA_EXTEND` or `USN_REASON_DATA_TRUNCATION`
  - Touch -> `USN_REASON_BASIC_INFO_CHANGE`

  However, `USN_RECORD` does not contain the new time.

  [Timestamp and `USN_REASON_BASIC_INFO_CHANGE` - @port139 Blog](https://port139.hatenablog.com/entry/2018/09/30/203343)

## Hard links
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
- [Everything](../../Windows/README.md#everything)


[^winter]: Windows Internals