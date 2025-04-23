# File Synchronization
[Wikipedia](https://en.wikipedia.org/wiki/File_synchronization)

## Tools
[Comparison of file synchronization software - Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_file_synchronization_software)

C++:
- Git
  - [git-sync: Safe and simple one-script git synchronization](https://github.com/simonthum/git-sync)

  [Git for file syncing - Features - Joplin Forum](https://discourse.joplinapp.org/t/git-for-file-syncing/9474)
  > I expect bundling a git client with desktop and especially mobile would not be an easy task.

- rsync
  - Cannot detect conflict, renames or moves
  - Windows: [cwRsync](https://itefix.net/cwrsync)
    - 11 MiB

  GUI:
  - luckyBackup
  - OCaml: Unison

- [FreeFileSync](https://freefilesync.org/) ([Wikipedia](https://en.wikipedia.org/wiki/FreeFileSync))
- [Seafile: High performance file syncing and sharing, with also Markdown WYSIWYG editing, Wiki, file label and other knowledge management features.](https://github.com/haiwen/seafile)

Rust:
- [Cooklang-sync: Low hassle file-sync lib optimised for text files](https://github.com/cooklang/cooklang-sync)

  [Developing file sync library - Cooklang: recipe markup language](https://cooklang.org/blog/06-developing-file-sync-library/) ([r/opensource](https://www.reddit.com/r/opensource/comments/1h9jai4/developing_a_filesync_library/))

- [ksync: an okay file synchronisation solution, written in Rust](https://github.com/jcbsnclr/ksync) (inactive)

  [ksync - a file synchronisation solution, written in Rust : r/rust](https://www.reddit.com/r/rust/comments/15gns3t/ksync_a_file_synchronisation_solution_written_in/)

- [filesync: Rust library for syncing files between different sources](https://github.com/mistodon/filesync)
- [Optra: An engine for remote file synchronization written in Rust](https://github.com/dyule/optra)

Go:
- [→Syncthing](Syncthing.md)
  - MPL v2
  - 20 MiB

  > Distributed peer-to-peer sync with automatic NAT traversal. Custom topology (star, full-mesh, mixed). Encryption.

- rclone
  - MIT
  - 58 MiB

  > Supports over 50 cloud, protocol and virtual backends including S3 buckets, Google Drive, Microsoft OneDrive, and other high-latency file storage. Capabilities include sync, cache, encrypt, compress and mount.

.NET:
- [Microsoft Sync Framework](https://learn.microsoft.com/en-us/previous-versions/sql/synchronization/mt490616(v=msdn.10)?redirectedfrom=MSDN)
  - SyncToy

PHP:
- [ownCloud: :cloud: ownCloud web server core (Files, DAV, etc.)](https://github.com/owncloud/core)
  - [Nextcloud: ☁️ Nextcloud server, a safe home for all your data](https://github.com/nextcloud/server)
- [jamielsharief/file-sync: A HTTP based file synchronization library that uses public key authentication.](https://github.com/jamielsharief/file-sync)

Others:
- Cloudike
- Egnyte
- Gladinet
- GoDrive
- GoodSync
- MediaFire
- Beyond Compare
- Directory Opus

→IPFS

[Self-hosted file sync service like Google Drive/Dropbox that isn't Nextcloud : r/selfhosted](https://www.reddit.com/r/selfhosted/comments/wzjuqk/selfhosted_file_sync_service_like_google/)

[synchronization - .NET File Sync Library - Stack Overflow](https://stackoverflow.com/questions/150397/net-file-sync-library)

[自行搭建类似 onedrive 的服务器？ - V2EX](https://www.v2ex.com/t/824080)

### Windows
- Microsoft ActiveSync ([Wikipedia](https://en.wikipedia.org/wiki/ActiveSync))
- Briefcase
- Windows Mobile Device Center
- Microsoft Sync Framework
- Microsoft SyncToy
- Windows Live Mesh
- Windows Live Sync
- [→OneDrive](OneDrive.md)

## Services
- [→OneDrive](OneDrive.md)
  - Free storage: 5G
- Google Drive
  - Free storage: 15G
- iCloud
- Dropbox
  - Free storage: 2G
- Mega
  - Free storage: 50G
- Telegram
- Azure File Sync

  [Introduction to Azure File Sync | Microsoft Learn](https://learn.microsoft.com/en-us/azure/storage/file-sync/file-sync-introduction)

Git:
- GitHub
- ...

→VPS

[The Best Cloud Storage and File-Sharing Services for 2025 | PCMag](https://www.pcmag.com/picks/the-best-cloud-storage-and-file-sharing-services)

[Cloud storage - Wikipedia](https://en.wikipedia.org/wiki/Cloud_storage)

### China
- [坚果云](https://www.jianguoyun.com/)
  - [WebDAV](https://help.jianguoyun.com/?p=2064)

    [通过坚果云 webdav 同步数据时需要注意坚果云的请求频率限制 - V2EX](https://www.v2ex.com/t/722770)
  - [Pricing](https://www.jianguoyun.com/s/pricing): 上传 1 GiB/月, 下载 3 GiB/月 (not GB)
- 巴别鸟
- 百度网盘
  - Limited download speed
- WPS 云盘
- 360
  - 亿方云
  - 360 云盘
- 移动云

Storage only:
- 阿里云盘
- 腾讯微云
  - Free storage: 5G
- 夸克网盘
- 蓝奏云
- 123 网盘
- 115 网盘
- PikPak
- 联通云盘
- 天翼云盘
- 城通网盘
- 迅雷云盘

[盘点国内外好用的网盘软件/云存储服务 - 少数派](https://sspai.com/post/77602)

[国内外30多款网盘、同步盘、快传盘 - Charltsing - 博客园](https://www.cnblogs.com/Charltsing/p/18290832/OnlineDisk)

[2023年支持云同步的网盘，有哪些靠谱的推荐（可以付费）？ - 知乎](https://www.zhihu.com/question/515399277)
