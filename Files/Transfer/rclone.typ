#import "@local/ib:0.1.0": *
#show: ib
#title[#a[rclone][https://rclone.org/]]
#a-badge[https://github.com/rclone/rclone]
#a-badge(body: [Changelog])[https://rclone.org/changelog/]

#q[rsync for cloud storage]

#q[Supports over 50 cloud, protocol and virtual backends including S3 buckets, Google Drive, Microsoft OneDrive, and other high-latency file storage.
Capabilities include sync, cache, encrypt, compress and mount.]

- MIT
- 58 MiB
- #a[Config][https://rclone.org/commands/rclone_config/]
  - #a[`rclone obscure`][https://rclone.org/commands/rclone_obscure/]
- Batch sync?

#a[Unpopular opinion: Rclone is bloated and confusing to use : r/selfhosted][https://www.reddit.com/r/selfhosted/comments/qbtwcg/unpopular_opinion_rclone_is_bloated_and_confusing/]

= Protocols
- Non-cloud protocols:
  - Local
  - #a[SFTP][https://rclone.org/sftp/]
  - SMB / CIFS
  - FTP
  - WebDAV
  - #a[HTTP][https://rclone.org/http/] (readonly)
  - HDFS
- #a[Archive][https://rclone.org/archive/]
- [ ] #a[Add support for Syncthing as a backend - Issue \#5874][https://github.com/rclone/rclone/issues/5874]

#a[any one compare the performance of rclone vs SFTP in term of uploading speed to a server with same file same env. (everything the same except using rclone vs SFTP) : r/sysadmin][https://www.reddit.com/r/sysadmin/comments/1055kv8/any_one_compare_the_performance_of_rclone_vs_sftp/]

= CLI
- #a[File metadata][https://rclone.org/docs/#metadata] (permissions and attributes)

  rclone #q[does not currently preserve permissions and attributes].
  - ```sh --metadata, -M```

    Doesn't work when copying from Windows to Linux.
  - With SSH.
  
  #a[Preservation Of Permissions with Copy/Sync - Feature - rclone forum][https://forum.rclone.org/t/preservation-of-permissions-with-copy-sync/35575]

  #a[Changing the permission of files - Help and Support - rclone forum][https://forum.rclone.org/t/changing-the-permission-of-files/12363]

- Progress / Speed
  - ```sh --progress, -P```
  - ```sh --interactive, -i```

  #a[Progress Bar & Stats | Rclone CLI][https://rcloneui.com/docs/cli/tips/progress-bar]

  - #a[Interaction between ```sh --log-file```, ```sh --progress```, and ```sh --stats``` - Feature - rclone forum][https://forum.rclone.org/t/interaction-between-log-file-progress-and-stats/22287]
  - #a[Get instant transfer speed - Help and Support - rclone forum][https://forum.rclone.org/t/get-instant-transfer-speed/25142]
  - #a[```sh --progress``` and ```sh --interactive``` are not completely compatible - Feature - rclone forum][https://forum.rclone.org/t/progress-and-interactive-are-not-completely-compatible/28305]

== Commands
- #a[`sync`][https://rclone.org/commands/rclone_sync/]
- #a[`ls`][https://rclone.org/commands/rclone_ls/]
  - ```sh --max-depth 1```

      #a[Is there any way to have "ls" not recurse to all my files? - Help and Support - rclone forum][https://forum.rclone.org/t/is-there-any-way-to-have-ls-not-recurse-to-all-my-files/1457]
  - `ls` is files only and `lsd` is directories only?

= #a[Mount][https://rclone.org/commands/rclone_mount/]
- Windows: WinFsp
- VFS layer
  
  Single-writer / SPMC:
  ```pwsh
  --dir-cache-time 1y
  --poll-interval 0
  --buffer-size 0
  --cache-dir "D:\Temp"
  --vfs-cache-mode full
  --vfs-cache-max-age 1y
  --vfs-cache-poll-interval 1y
  --vfs-write-back 1h
  ```

  #a[Question about caching mode and/or buffer size related to reading large files on a mounted drive - Help and Support - rclone forum][https://forum.rclone.org/t/question-about-caching-mode-and-or-buffer-size-related-to-reading-large-files-on-a-mounted-drive/38604/2]

  #a[Fix Plex Buffering Fast with RcloneView --- Tune Mounts, VFS Cache, and Network Limits | RcloneView Support Center][https://rcloneview.com/support/blog/plex-buffering-fix-rcloneview]

- ```sh --buffer-size 16M```

  #a[```sh --buffer-size``` defaults? - Help and Support - rclone forum][https://forum.rclone.org/t/buffer-size-defaults/13775]

  #a[What's the suitable value to set for buffer-size with vfs-read-ahead? - Help and Support - rclone forum][https://forum.rclone.org/t/whats-the-suitable-value-to-set-for-buffer-size-with-vfs-read-ahead/39971]
  - #q[Some users have been experimenting with the size of `--buffer-size` and for the VFS with `full` the optimum value may actually be `--buffer-size 0`.
    The default is `16M` so I wouldn't make it bigger than that.]

= GUI
- #a[kapitainsky/RcloneBrowser: Simple cross platform GUI for rclone. Supports macOS, GNU/Linux, BSD family and Windows.][https://github.com/kapitainsky/RcloneBrowser]
  (discontinued)
