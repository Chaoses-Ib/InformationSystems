# User-space File Systems
- Drivers
  - [Projected File System](#projected-file-system)
  - [WinFsp: Windows File System Proxy](#winfsp)
  - [Dokany: User mode file system library for windows with FUSE Wrapper](#dokany)
  - [Callback Technologies: Software Components for Virtual File Systems and File Access Monitoring and Control](https://www.callback.com/)
  - [cxfuse: Crossmeta FUSE Windows Port](https://github.com/crossmeta/cxfuse) (inactive)

- Reparse points
  - [Cloud files](#cloud-files)

- WebDAV
  - [`userspacefs`](https://pypi.org/project/userspacefs/)

    [Driverless User Space File Systems for Windows, macOS, and Linux](https://thelig.ht/user-space-file-systems/)

- SMB

- Directory Opus VFS plugins

> 还挺多的，官方的 ProjFS、Cloud Files、WebDAV、SMB，第三方的有 WinFsp、Dokany。官方的功能各有各的局限，第三方是套的文件系统驱动，控制比较大，不过就得安装他们签的驱动。DO 的 VFS 插件勉强也算一个。

[Linux Fu: User Space File Systems --- Now For Windows, Too! | Hackaday](https://hackaday.com/2021/08/31/linux-fu-user-space-file-systems-now-for-windows-too/)

## Projected File System
[Windows Projected File System (ProjFS) | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/projfs/projected-file-system)

[Projected File System -- Pavel Yosifovich](https://scorpiosoftware.net/2024/02/20/projected-file-system/) ([r/programming](https://www.reddit.com/r/programming/comments/1avperf/projected_file_system/), [r/windowsdev](https://www.reddit.com/r/windowsdev/comments/1avpf4t/projected_file_system/))

[It's not possible to intercept a "write" request to a projected file - Issue #30 - microsoft/ProjFS-Managed-API](https://github.com/microsoft/ProjFS-Managed-API/issues/30)
> I too found this limitation of projfs quite surprising and one could argue the name "projected file system" is misleading, it's more of a lazy/on-demand cloning/import api.
> Its use seems to be limited to "using the local filesystem as a cache for slow backing stores".

Bindings:
- .NET: [ProjFS Managed API: A managed-code API for the Windows Projected File System](https://github.com/microsoft/ProjFS-Managed-API)
- Python: [pyprojfs: Windows Projected File System for Python](https://github.com/danielhodson/pyprojfs)

Linux: [libprojfs: Linux projected filesystem library](https://github.com/github/libprojfs)

## Cloud files
[Cloud Sync Engines - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/cfapi/cloud-files-api-portal)

## [WinFsp](https://github.com/winfsp/winfsp)
- .NET
- [Rust](https://github.com/SnowflakePowered/winfsp-rs)

The author is formerly at Microsoft.

## [Dokany](https://github.com/dokan-dev/dokany)
- [.NET](https://github.com/dokan-dev/dokan-dotnet)
- [Rust](https://github.com/dokan-dev/dokan-rust)

[Dokany -- User mode file system library for windows with FUSE Wrapper | Hacker News](https://news.ycombinator.com/item?id=12554024)

[\[question\] ReadDirectoryChanges/FileSystemwatcher => notify manually ? - Issue #532 - dokan-dev/dokany](https://github.com/dokan-dev/dokany/issues/532)

## File systems
- [Cryptomator: Multi-platform transparent client-side encryption of your files in the cloud](https://github.com/cryptomator/cryptomator)

ProjFS:
- [VFS For Git: Virtual File System for Git: Enable Git at Enterprise Scale](https://github.com/Microsoft/VFSForGit)
- [ObjMgrProjFS: Projected File System Sample (Object Manager Namespace)](https://github.com/zodiacon/ObjMgrProjFS)
- [Registry File System (RegFS) sample](https://github.com/Microsoft/Windows-classic-samples/tree/main/Samples/ProjectedFileSystem)

[WinFSP](https://winfsp.dev/doc/Known-File-Systems/):
- [SSHFS-Win: SSHFS For Windows](https://github.com/winfsp/sshfs-win)
- [HUBFS: File system for GitHub & GitLab](https://github.com/winfsp/hubfs)
- [WinSpd: Windows Storage Proxy Driver - User mode disk storage](https://github.com/winfsp/winspd)
- [rar2fs: FUSE file system for reading RAR archives](https://github.com/hasse69/rar2fs)
- [redditfs: ls -l /r/programming](https://github.com/billziss-gh/redditfs)
- [WordpressDrive: Windows Userspace Filesystem based on WinFsp that presents a Wordpress Site as a Windows Drive.](https://github.com/printpagestopdf/WordpressDrive)

Dokany:
- [MemProcFS: An easy and convenient way of viewing physical memory as files in a virtual file system.](https://github.com/ufrisk/MemProcFS)
- [KxVirtualFileSystem: A Dokany2-based user mode Virtual File System implementation](https://github.com/Karandra/KxVirtualFileSystem)