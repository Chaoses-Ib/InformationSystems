# [Syncthing](https://syncthing.net/)
[GitHub](https://github.com/syncthing/syncthing), [Wikipedia](https://en.wikipedia.org/wiki/Syncthing)

- MPL v2
- `scoop instlal syncthing`

  > To start syncthing automatically, use a method described at [Starting Syncthing Automatically](https://docs.syncthing.net/users/autostart.html#windows).
- 20 MiB, 70 MiB memory usage, 0.01% CPU usage

> Distributed peer-to-peer sync with automatic NAT traversal. Custom topology (star, full-mesh, mixed). Encryption.

[Getting Started](https://docs.syncthing.net/intro/getting-started.html)

[Configuration Tuning](https://docs.syncthing.net/users/tuning.html)

[Usage reporting](https://data.syncthing.net/) (Grafana)

## Folders
- Folder path supports `~`
- Shared folder path defaults to `~\{Folder ID}`
  - `scoop\persist\example`
  - Use together with Auto Accept
- [Folder type](https://docs.syncthing.net/users/foldertypes.html)
  - Send & Receive
  - Send Only
  - Receive Only
  - Receive Encrypted: [Untrusted (Encrypted) Devices](https://docs.syncthing.net/users/untrusted.html)

    Suitable for backup purposes.

- Links

  > Symbolic links (synced, except on Windows, but never followed)

  [Add an option to follow symlinks instead of syncing them "as is" - Issue #1776 - syncthing/syncthing](https://github.com/syncthing/syncthing/issues/1776)

  [How does Synchting handle symbolic links? - General - Syncthing Community Forum](https://forum.syncthing.net/t/how-does-synchting-handle-symbolic-links/21985)

  [Option to follow directory junctions / symbolic links? - Feature - Syncthing Community Forum](https://forum.syncthing.net/t/option-to-follow-directory-junctions-symbolic-links/14750)
  > Despite the phrasing of the topic, the only thing that is implemented is following junction points. Symlinks are not followed and there are no plans to ever do so.

[Optimizing Rescan Interval setting - Support - Syncthing Community Forum](https://forum.syncthing.net/t/optimizing-rescan-interval-setting/1200)

## [File versioning](https://docs.syncthing.net/users/versioning.html)
- Trash Can File Versioning
- Simple File Versioning
- Staggered File Versioning

  ["Staggered File Versioning" - what does it do exactly? - Support - Syncthing Community Forum](https://forum.syncthing.net/t/staggered-file-versioning-what-does-it-do-exactly/11440)
- External File Versioning

[Staggered File Versioning, synchronize/backup only twice a month? : r/Syncthing](https://www.reddit.com/r/Syncthing/comments/158o1hu/staggered_file_versioning_synchronizebackup_only/)

## Devices
- Device discovery: [Syncthing Discovery Server](https://docs.syncthing.net/users/stdiscosrv.html)
  - https://discovery-lookup.syncthing.net/v2/?noannounce
  - https://discovery-announce-v4.syncthing.net/v2/?nolookup
  - https://discovery-announce-v6.syncthing.net/v2/?nolookup
  - UDP port 21027
- [Firewall Setup](https://docs.syncthing.net/users/firewall.html)
  - QUIC works even in the presence of a firewall

    [Switching from tcp://:port to quic://port - Support - Syncthing Community Forum](https://forum.syncthing.net/t/switching-from-tcp-port-to-quic-port/14361)
- [Relaying](https://docs.syncthing.net/users/relaying.html)
  - [Syncthing Relay Server](https://docs.syncthing.net/users/strelaysrv.html)
  - https://relays.syncthing.net/endpoint
- [Security Principles](https://docs.syncthing.net/users/security.html)

  > Parties doing surveillance on your network (whether that be corporate IT, the NSA or someone else) will be able to see that you use Syncthing, and your device IDs [are OK to share anyway](https://docs.syncthing.net/users/faq.html#should-i-keep-my-device-ids-secret), but the actual transmitted data is protected as well as we can. Knowing your device ID can expose your IP address, using global discovery.

## CLI
- `syncthing --no-console` only works with ConHost, not WT
- `--gui-address` defaults to probe a random port at the first startup
- Startup: `conhost syncthing --no-console --no-browser --gui-address http://127.0.0.1:8443`

## [GUI](https://docs.syncthing.net/users/contrib.html#gui-wrappers)
- Syncthing web UI
- [syncthingtray: Tray application and Dolphin/Plasma integration for Syncthing](https://github.com/Martchus/syncthingtray)
  - Qt
  - 0.06 GiB without built-in web view
  - `scoop install syncthingtray`

Windows:
- [SyncTrayzor: Windows tray utility / filesystem watcher / launcher for Syncthing](https://github.com/canton7/SyncTrayzor) (discontinued)
  - 2019-08-11~ v1.1.24
  - `scoop install synctrayzor`
    - `logs` is not persisted
  - 0.2 GiB (`libcef.dll`)
  - +0.37 GiB memory usage
  - Webview
  - Logs
  - Startup
  - Conflict resolver

## Data
Windows: `%LOCALAPPDATA%\Syncthing`
- `%APPDATA%\SyncTrayzor`
