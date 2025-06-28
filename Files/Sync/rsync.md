# rsync
[Wikipedia](https://en.wikipedia.org/wiki/Rsync), [GitHub](https://github.com/RsyncProject/rsync)

- Cannot detect conflict, renames or moves
- SSH / daemon

  > There are two different ways for rsync to contact a remote system: using a remote-shell program as the transport (such as ssh or rsh) or contacting an rsync daemon directly via TCP.

  SSH mode still needs rsync to be installed on the target.
  
  [Does rsync have to be installed on the remote server? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/quesftions/324869/does-rsync-have-to-be-installed-on-the-remote-server)

  [Does rsync require both source host and destination host to run rsync as client, server, or daemon? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/339409/does-rsync-require-both-source-host-and-destination-host-to-run-rsync-as-client)

  [c - rsync in non-daemon - Stack Overflow](https://stackoverflow.com/questions/12074279/rsync-in-non-daemon)

  [networking - What is the need for rsync server in daemon mode - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/26182/what-is-the-need-for-rsync-server-in-daemon-mode)
- Auth
  - `sshpass`
  - Daemon + `RSYNC_PASSWORD`/`--password-file`

  [ssh - How to avoid password prompt with rsync (and without using public keys)? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/111526/how-to-avoid-password-prompt-with-rsync-and-without-using-public-keys)

  [How to pass password automatically for rsync SSH command? - Stack Overflow](https://stackoverflow.com/questions/3299951/how-to-pass-password-automatically-for-rsync-ssh-command)
- [CLI](https://linux.die.net/man/1/rsync)
- Windows: [cwRsync](https://itefix.net/cwrsync)
  - 11 MiB
- [osync: A robust two way (bidirectional) file sync script based on rsync with fault tolerance, POSIX ACL support, time control and near realtime sync](https://github.com/deajan/osync)

GUI:
- luckyBackup
- OCaml: Unison

[Why no one recommends rsync, rclone, etc? : r/DataHoarder](https://www.reddit.com/r/DataHoarder/comments/1hed3hx/why_no_one_recommends_rsync_rclone_etc/)

## [rclone](https://rclone.org/)
[GitHub](https://github.com/rclone/rclone)

> rsync for cloud storage

> Supports over 50 cloud, protocol and virtual backends including S3 buckets, Google Drive, Microsoft OneDrive, and other high-latency file storage. Capabilities include sync, cache, encrypt, compress and mount.

- Protocols
  - Non-cloud protocols: local, [SFTP](https://rclone.org/sftp/), SMB / CIFS, FTP, WebDAV, [HTTP](https://rclone.org/http/) (readonly), HDFS
  - [Add support for Syncthing as a backend - Issue #5874](https://github.com/rclone/rclone/issues/5874)
- MIT
- 58 MiB
- [Config](https://rclone.org/commands/rclone_config/)
  - [rclone obscure](https://rclone.org/commands/rclone_obscure/)
- CLI
  - [`sync`](https://rclone.org/commands/rclone_sync/)
  - [`ls`](https://rclone.org/commands/rclone_ls/)
    - `--max-depth 1`

      [Is there any way to have "ls" not recurse to all my files? - Help and Support - rclone forum](https://forum.rclone.org/t/is-there-any-way-to-have-ls-not-recurse-to-all-my-files/1457)
    - `ls` is files only and `lsd` is directories only?
- Batch sync?

[Unpopular opinion: Rclone is bloated and confusing to use : r/selfhosted](https://www.reddit.com/r/selfhosted/comments/qbtwcg/unpopular_opinion_rclone_is_bloated_and_confusing/)

[any one compare the performance of rclone vs SFTP in term of uploading speed to a server with same file same env. (everything the same except using rclone vs SFTP) : r/sysadmin](https://www.reddit.com/r/sysadmin/comments/1055kv8/any_one_compare_the_performance_of_rclone_vs_sftp/)

### GUI
- [kapitainsky/RcloneBrowser: Simple cross platform GUI for rclone. Supports macOS, GNU/Linux, BSD family and Windows.](https://github.com/kapitainsky/RcloneBrowser) (discontinued)

## rsync vs. rclone
[Rclone - Wikipedia](https://en.wikipedia.org/wiki/Rclone#Rclone_or_rsync)
> Rsync transfers files with other computers that have rsync installed. It operates at the block, rather than file level and has a delta algorithm so that it only needs to transfer changes in files. Rsync preserves file attributes and permissions. Rclone has a wider range of content management capabilities, and types of backend it can address, but only works at a whole file / object level. It does not currently preserve permissions and attributes. Rclone is designed to have some tolerance of intermittent and unreliable connections or remote services. Its transfers are optimised for high latency networks. Rclone decides which of those whole files / objects to transfer after obtaining checksums, to compare, from the remote server. Where checksums are not available, rclone can use object size and timestamp.
>
> Rsync is single threaded. Rclone is multi threaded with a user definable number of simultaneous transfers.
>
> Rclone can pipe data between two completely remote locations, sometimes without local download. During an rsync transfer, one side must be a local drive.

[Rclone + Chunker = Rsync? - Feature - rclone forum](https://forum.rclone.org/t/rclone-chunker-rsync/44198)
> I like to think about rclone as rsync for the cloud. And as rsync does not provide any cloud connectivity (beyond ssh) similarly rclone does not provide many features needed to effectively sync files locally (metadata, privileges) etc.

[Rclone: rsync for cloud storage | Hacker News](https://news.ycombinator.com/item?id=12398303)

[Can rClone replace rsync? : r/rclone](https://www.reddit.com/r/rclone/comments/vzto6g/can_rclone_replace_rsync/)

[Rclone与Rsync性能比较：终极测试结果](https://www.wanpeng.life/2246.html)

[\[Storage\] Investigate using rclone sync to replace gsutil rsync - Issue #2771 - skypilot-org/skypilot](https://github.com/skypilot-org/skypilot/issues/2771)

[Rclone transfer rate slower than rsync - Help and Support - rclone forum](https://forum.rclone.org/t/rclone-transfer-rate-slower-than-rsync/34967)
> Slowdowns like this are often caused by rclone checking the checksums. You can turn this off with `--ignore-checksum`, but I can see from your log it only took 6 seconds.
