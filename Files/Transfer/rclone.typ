#import "@local/ib:0.1.0": *
#show: ib
#title[#a[rclone][https://rclone.org/]]
#a-badge[https://github.com/rclone/rclone]

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
- [ ] #a[Add support for Syncthing as a backend - Issue \#5874][https://github.com/rclone/rclone/issues/5874]

#a[any one compare the performance of rclone vs SFTP in term of uploading speed to a server with same file same env. (everything the same except using rclone vs SFTP) : r/sysadmin][https://www.reddit.com/r/sysadmin/comments/1055kv8/any_one_compare_the_performance_of_rclone_vs_sftp/]

= CLI
- #a[`sync`][https://rclone.org/commands/rclone_sync/]
- #a[`ls`][https://rclone.org/commands/rclone_ls/]
  - ```sh --max-depth 1```

      #a[Is there any way to have "ls" not recurse to all my files? - Help and Support - rclone forum][https://forum.rclone.org/t/is-there-any-way-to-have-ls-not-recurse-to-all-my-files/1457]
  - `ls` is files only and `lsd` is directories only?

= GUI
- #a[kapitainsky/RcloneBrowser: Simple cross platform GUI for rclone. Supports macOS, GNU/Linux, BSD family and Windows.][https://github.com/kapitainsky/RcloneBrowser]
  (discontinued)
