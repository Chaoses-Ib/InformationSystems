# File Change Monitoring
## Change journals
- NTFS: [Change Journals](Systems/NTFS/Change%20Journals.md)
- Linux

  [A filesystem "change journal" and other topics [LWN.net]](https://lwn.net/Articles/755277/)

## Linux
- inotify
  
  [inotify with NFS - Stack Overflow](https://stackoverflow.com/questions/4231243/inotify-with-nfs)

- fanotify

  [fanotify Support? - Issue #497 - notify-rs/notify](https://github.com/notify-rs/notify/issues/497)

## Windows
- [File system filter drivers](https://learn.microsoft.com/en-us/windows-hardware/drivers/ifs/about-file-system-filter-drivers)
- [ReadDirectoryChangesW()](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-readdirectorychangesw)

  Network drives:
  > `ReadDirectoryChangesW` works with network drives, but only if the remote server supports the functionality. Drives shared from other Windows-based computers will correctly generate notifications. Samba servers may or may not generate notifications, depending on whether the underlying operating system supports the functionality. ~~Network Attached Storage (NAS) devices usually run Linux, so won't support notifications.~~ High-end SANs are anybody's guess.

  > Monitoring SAMBA servers (eg NAS) will actually work in many cases. The more modern Linux operating systems upon which these are based, and the more modern versions of SAMBA, will all support notifications. It can be hit and miss. I have found a number of NAS boxes where it works OK.

  Changes between calls:
  > When you first call ReadDirectoryChangesW, the system allocates a buffer to store change information. This buffer is associated with the directory handle until it is closed and its size does not change during its lifetime. Directory changes that occur between calls to this function are added to the buffer and then returned with the next call. If the buffer overflows, the entire contents of the buffer are discarded and the lpBytesReturned parameter contains zero.

- [FindFirstChangeNotificationW()](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-findfirstchangenotificationw)
- [SHChangeNotifyRegister()](https://learn.microsoft.com/en-us/windows/win32/api/shlobj_core/nf-shlobj_core-shchangenotifyregister)

[Understanding ReadDirectoryChangesW - Part 1](https://qualapps.blogspot.com/2010/05/understanding-readdirectorychangesw.html)
- [Understanding ReadDirectoryChangesW - Part 2](https://qualapps.blogspot.com/2010/05/understanding-readdirectorychangesw_19.html)

## Libraries
C++:
- [fswatch: A cross-platform file change monitor with multiple backends: Apple OS X File System Events, *BSD kqueue, Solaris/Illumos File Events Notification, Linux inotify, Microsoft Windows and a stat()-based backend.](https://github.com/emcrisostomo/fswatch)

Rust:
- [Notify: 🔭 Cross-platform filesystem notification library for Rust.](https://github.com/notify-rs/notify)
  
  - [`notify_debouncer_mini`](https://docs.rs/notify-debouncer-mini/latest/notify_debouncer_mini/)
  - [`notify_debouncer_full`](https://docs.rs/notify-debouncer-full/latest/notify_debouncer_full/)
    - 重复 `Rename`, 递归 `Remove`, 重复 `Create`, `Modify` after `Create`, 重复 [`Modify`](https://github.com/notify-rs/notify/blob/main/notify-debouncer-full/test_cases/emit_continuous_modify_content_events.hjson)
    ```rust
    let thread = std::thread::Builder::new()
        .name("notify-rs debouncer loop".to_string())
        .spawn(move || loop {
            if stop_c.load(Ordering::Acquire) {
                break;
            }
            std::thread::sleep(tick);
            let send_data;
            let errors;
            {
                let mut lock = data_c.lock().unwrap();
                send_data = lock.debounced_events();
                errors = lock.errors();
            }
            if !send_data.is_empty() {
                event_handler.handle_event(Ok(send_data));
            }
            if !errors.is_empty() {
                event_handler.handle_event(Err(errors));
            }
        })?;
    ```
    ```rust
    if now.saturating_duration_since(event.time) >= self.timeout {
        ...
    }
    ```
    Cannot fetch on demand. 只能设置固定的周期，会影响实时性。

    In-memory and will lose events on abort.

  [Known issues](https://docs.rs/notify/latest/notify/#known-problems):
  - Network file systems
  
    [I use notify to watch a path which is mount by nfs，notify didn't work and no error return - Issue #475 - notify-rs/notify](https://github.com/notify-rs/notify/issues/475)

    [Recursive changes aren't detected in a shared directory - Issue #384 - notify-rs/notify](https://github.com/notify-rs/notify/issues/384)
  - [Rename Event, How to be one Event - Issue #376 - notify-rs/notify](https://github.com/notify-rs/notify/issues/376)

    [Rename event notification RenameMode error - Issue #385 - notify-rs/notify](https://github.com/notify-rs/notify/issues/385)

  - [Investigate ways to minimise the amount of PathBufs - Issue #194 - notify-rs/notify](https://github.com/notify-rs/notify/issues/194)

  Tools:
  - [watchexec: Executes commands in response to file modifications](https://github.com/watchexec/watchexec)
    - [Watchexec library](https://github.com/watchexec/watchexec/tree/main/crates/lib)
      - [throttle_collect()](https://github.com/watchexec/watchexec/blob/6c245d3aff31d9764ef98be7f31fe8337cb44635/crates/lib/src/action/worker.rs#L113)

.NET:
- [VS Code FileWatcher for Windows](https://github.com/Microsoft/vscode-filewatcher-windows)
  - [d2phap/FileWatcherEx: The file watcher on Windows.](https://github.com/d2phap/FileWatcherEx)    

Go:
- [fsnotify: Cross-platform file system notifications for Go.](https://github.com/fsnotify/fsnotify)
  - [Windows USN Journals · Issue #53 · fsnotify/fsnotify](https://github.com/fsnotify/fsnotify/issues/53)
- [syncthing-inotify: File watcher intended for use with Syncthing (Linux, BSD, Windows, OSX)](https://github.com/syncthing/syncthing-inotify) (deprecated)

Python:
- [Watchdog: Python library and shell utilities to monitor filesystem events.](https://github.com/gorakhargosh/watchdog)

## Tools
- [Everything](Windows/README.md#everything)
- [FileMonitor: 文件变化实时监控工具(代码审计/黑盒/白盒审计辅助工具)](https://github.com/TheKingOfDuck/FileMonitor)