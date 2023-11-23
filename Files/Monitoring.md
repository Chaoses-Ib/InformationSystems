# File Change Monitoring
## Change journals
- NTFS: [USN Journal](https://en.wikipedia.org/wiki/USN_Journal)
- Linux

  [A filesystem "change journal" and other topics [LWN.net]](https://lwn.net/Articles/755277/)

## Libraries
C++:
- [fswatch: A cross-platform file change monitor with multiple backends: Apple OS X File System Events, *BSD kqueue, Solaris/Illumos File Events Notification, Linux inotify, Microsoft Windows and a stat()-based backend.](https://github.com/emcrisostomo/fswatch)

Rust:
- [Notify: 🔭 Cross-platform filesystem notification library for Rust.](https://github.com/notify-rs/notify)
- NTFS
  - [ntfs: An implementation of the NTFS filesystem in a Rust crate, usable from firmware level up to user-mode.](https://github.com/ColinFinck/ntfs)
  - [MFT: A parser for the MFT (Master File Table) format](https://github.com/omerbenamram/mft)
  - [usn-journal: An idiomatic Rust wrapper for the USN Journal on Windows](https://github.com/codeprentice-org/usn-journal)
  - [Change Journal: A unified change journal-like API for Linux and Windows that lets you monitor entire filesystems, mount points, and/or volumes for file change events. It uses fanotify on Linux and the USN Journal on Windows.](https://github.com/codeprentice-org/change-journal)

.NET:
- [VS Code FileWatcher for Windows](https://github.com/Microsoft/vscode-filewatcher-windows)
  - [d2phap/FileWatcherEx: The file watcher on Windows.](https://github.com/d2phap/FileWatcherEx)    

Go:
- [fsnotify: Cross-platform file system notifications for Go.](https://github.com/fsnotify/fsnotify)
  - [Windows USN Journals · Issue #53 · fsnotify/fsnotify](https://github.com/fsnotify/fsnotify/issues/53)
- [syncthing-inotify: File watcher intended for use with Syncthing (Linux, BSD, Windows, OSX)](https://github.com/syncthing/syncthing-inotify) (deprecated)

## Tools
- [FileMonitor: 文件变化实时监控工具(代码审计/黑盒/白盒审计辅助工具)](https://github.com/TheKingOfDuck/FileMonitor)