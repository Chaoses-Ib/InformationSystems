# [Syncthing](https://syncthing.net/)
[GitHub](https://github.com/syncthing/syncthing), [Wikipedia](https://en.wikipedia.org/wiki/Syncthing)

- MPL v2
- `scoop instlal syncthing`

  > To start syncthing automatically, use a method described at [Starting Syncthing Automatically --- Syncthing documentation](https://docs.syncthing.net/users/autostart.html#windows).
- 20 MiB, 70 MiB memory usage, 0.01% CPU usage
- Device discovery
- Folder path supports `~`
- Shared folder path defaults to `~\{Folder ID}`
  - `scoop\persist\example`
  - Use together with Auto Accept

CLI:
- `syncthing --no-console` only works with ConHost, not WT
- `--gui-address` defaults to probe a random port at the first startup
- Startup: `conhost syncthing --no-console --no-browser --gui-address http://127.0.0.1:8443`

> Distributed peer-to-peer sync with automatic NAT traversal. Custom topology (star, full-mesh, mixed). Encryption.

[Getting Started --- Syncthing documentation](https://docs.syncthing.net/intro/getting-started.html)

[Usage reporting](https://data.syncthing.net/) (Grafana)

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
