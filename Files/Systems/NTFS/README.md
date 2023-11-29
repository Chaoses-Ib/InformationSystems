# New Technology File System
[Wikipedia](https://en.wikipedia.org/wiki/NTFS)

- Recoverability: Atomic transactions
- Security: Security descriptors
- Data redundancy and fault tolerance: Windows layered driver
  - Volume manager: RAID 1, RAID 5
  - Dynamic Disks (Windows 7)
  - Storage Spaces (Windows 8.1)

> A volume consists of a series of files plus any additional unallocated space remaining on the disk partition. In all FAT file systems, a volume also contains areas specially formatted for use by the file system. An NTFS or ReFS volume, however, stores all file system data, such as bitmaps and directories, and even the system bootstrap, as ordinary files.[^winter]

- Windows Internals

  A bit confusing.

- [New Technologies File System (NTFS) - libyal/libfsntfs](https://github.com/libyal/libfsntfs/blob/main/documentation/New%20Technologies%20File%20System%20(NTFS).asciidoc)

## Libraries
C++:
- [libfsntfs: Library and tools to access the Windows New Technology File System (NTFS)](https://github.com/libyal/libfsntfs/)

Rust:
- [ntfs: An implementation of the NTFS filesystem in a Rust crate, usable from firmware level up to user-mode.](https://github.com/ColinFinck/ntfs)
- [MFT: A parser for the MFT (Master File Table) format](https://github.com/omerbenamram/mft)

## Unicode
### Case sensitivity
[Playing with case-insensitive file names -- My DFIR Blog](https://dfir.ru/2021/07/15/playing-with-case-insensitive-file-names/)

[Windows `Path` case mapping is inaccurate - Crystal Contrib - Crystal Forum](https://forum.crystal-lang.org/t/windows-path-case-mapping-is-inaccurate/4133)

> NTFS uses a per-volume upcase table. This table:
> 
> - is outdated;
> - contains all UTF-16 code units but treats the surrogate units as opaque characters, and they map to themselves, so there are no case mappings outside the BMP;
> - can change between OS versions;
> - is not guaranteed to be the same even on identical OS versions.

## General indexing facility
> The NTFS architecture is structured to allow indexing of any file attribute on a disk volume using a B-tree structure. (Creating indexes on arbitrary attributes is not exported to users.) This structure enables the file system to efficiently locate files that match certain criteria—for example, all the files in a particular directory. In contrast, the FAT file system indexes file names but doesn’t sort them, making lookups in large directories slow.
> 
> Several NTFS features take advantage of general indexing, including consolidated security descriptors, in which the security descriptors of a volume’s files and directories are stored in a single internal stream, have duplicates removed, and are indexed using an internal security identifier that NTFS defines.[^winter]

## Link tracking
> NTFS in Windows includes support for a service application called **distributed link-tracking**, which maintains the integrity of shell and OLE links when link targets move. Using the NTFS link-tracking support, if a link target located on an NTFS volume moves to any other NTFS volume within the originating volume’s domain, the link-tracking service can transparently follow the movement and update the link to reflect the change.
> 
> NTFS link-tracking support is based on an optional file attribute known as an object ID. An application can assign an object ID to a file by using the `FSCTL_CREATE_OR_GET_OBJECT_ID` (which assigns an ID if one isn’t already assigned) and `FSCTL_SET_OBJECT_ID` file system control codes. Object IDs are queried with the `FSCTL_CREATE_OR_GET_OBJECT_ID` and `FSCTL_GET_OBJECT_ID` file system control codes. The `FSCTL_DELETE_OBJECT_ID` file system control code lets applications delete object IDs from files.[^winter]


[^winter]: Windows Internals