#import "@local/ib:0.1.0": *
#title[File Backup]
#a[List of backup software - Wikipedia][https://en.wikipedia.org/wiki/List_of_backup_software]

- File transfer + Retention + Task scheduler
  - rclone
    #footnote[#a[Can we use Rclone as incremental backup tool? - Help and Support - rclone forum][https://forum.rclone.org/t/can-we-use-rclone-as-incremental-backup-tool/32529]]
    #footnote[#a[Rclone as back up tool? : r/rclone][https://www.reddit.com/r/rclone/comments/s4o0bm/rclone_as_back_up_tool/]]
- File synchronization + Retention (+ Task scheduler)
  - Syncthing
- restic
  - rustic
- Kopia
- Duplicati
- BorgBackup
- BackupPC
- FreeFileSync
- VCS + Task scheduler
  - Git

#a[Borg, Kopia, Restic: backup and resource utilization | Cognitive Overhead][https://www.patpro.net/blog/index.php/2024/03/23/3674-borg-kopia-restic-backup-and-resource-utilization/comment-page-1/]
- Restic ≈ Kopia > Borg

#a[Kopia vs Restic comparison - restic forum][https://forum.restic.net/t/kopia-vs-restic-comparison/2893]
- #q[Overall, kopia has better support for eventual consistency and parallel operations (lock-free).
  Also has better performance in terms of speed and compression too.
  I really appreciate that kopia has an API and SDK but yes, it is a more recent project.]
- #q[I’ve been experimenting with building what is now Kopia for >5 years now (btw it used to be called “FREDI” which stood for “fast, remote, encrypted, deduplicated, incremental” backup).
  Initially it was meant to be more of a personal research project than a practical tool.
  I’ve been working for Google Cloud since 2012 and I became fascinated with the potential for very cheap and virtually unlimited and highly-available storage.
  I wanted to build not just a cloud backup utility, but first and foremost a properly-layered, fully client-side encrypted, multi-user, content addressable storage without a dedicated server (so only using GCS or S3).
  You can still see remnants of it in https://github.com/kopia/repo]

#a[restic vs BorgBackup vs Kopia for Linux server backups? --- LowEndTalk][https://lowendtalk.com/discussion/173809/restic-vs-borgbackup-vs-kopia-for-linux-server-backups]

#a[Kopia, Restic and Rclone performance analysis : r/unRAID][https://www.reddit.com/r/unRAID/comments/1b4z743/kopia_restic_and_rclone_performance_analysis/?show=original]

#a[Struggling between restic and kopia : r/selfhosted][https://www.reddit.com/r/selfhosted/comments/10tj3sx/struggling_between_restic_and_kopia/]

#a[Kopia is brilliant : r/selfhosted][https://www.reddit.com/r/selfhosted/comments/1g80czc/kopia_is_brilliant/]
- #q[What aspects of Kopia did you think were lacking in comparison to restic?]

  #q[Mainly the ability to have multiple data sources and target repositories. I don't know if it has been added but when i tried it there was no way to set up multiple repos in the WebGui, you had to kind of botch something together with a script which i wasn't a big fan of if it is something important like my backups. It also felt unfinished with a few bugs i encountered so i decided to try something more mature with more possibilities for custom use cases which restic definitly offers.]

#a[Backup - Restic vs Kopia : r/homelab][https://www.reddit.com/r/homelab/comments/1ndwbdd/backup_restic_vs_kopia/]

#a[各位来分享一下自己的个人数据备份方案吧 - V2EX][https://v2ex.com/t/1154883]
- #q[网盘确实不能使用 restic ，随便丢一个包整个就炸了，特别是国内网盘对于加密的长文件名称有额外的削弱]

= #a[restic][https://restic.net/]
#a-badge[https://github.com/restic/restic]
#a-badge[https://wiki.archlinux.org/title/Restic]

- #a[autorestic: Config driven, easy backup cli for restic.][https://github.com/cupcakearmy/autorestic]
- #a[restic-windows-backup: Powershell scripts to run Restic backups on Windows][https://github.com/kmwoley/restic-windows-backup]

GUI:
- #a[Backrest: A web UI and orchestrator for restic backup.][https://github.com/garethgeorge/backrest]
  - ```pwsh scoop install extras/backrest```
- #a[restic-browser: A GUI to browse and restore restic backup repositories.][https://github.com/emuell/restic-browser]

== #a[rustic][https://rustic.cli.rs/]
#a-badge[https://github.com/rustic-rs/rustic]
#a-badge[https://docs.rs/rustic_core/]

#q[Fast, encrypted, and deduplicated backups powered by Rust]

- OpenDAL
- #a[Hooks][https://rustic.cli.rs/docs/commands/misc/hooks.html]
- #a[Comparison rustic and restic - rustic user documentation][https://rustic.cli.rs/docs/comparison-restic.html]

  #a[Simple comparison of borg, restic and rustic (2024) - bebehei][https://archive.ph/So9vG]
- #a[Add support for hard links. - Issue \#16][https://github.com/rustic-rs/rustic_core/issues/16]

#a[rustic 使用说明][https://blog.duyao.de/post/rustic-walk-through/]

= Kopia
#a-badge[https://github.com/kopia/kopia]

- ```pwsh scoop install main/kopia```
  - ```pwsh scoop install extras/kopiaui```

#a[Anyone using kopia backup? : r/selfhosted][https://www.reddit.com/r/selfhosted/comments/1q318rn/anyone_using_kopia_backup/]

#a[备份工具 kopia 应用][https://blog.duyao.de/post/backup-tool-kopia-walk-through/]

= Duplicati
#a-badge[https://en.wikipedia.org/wiki/Duplicati]
#a-badge[https://github.com/duplicati/duplicati]

- LGPL

= #a[FreeFileSync][https://freefilesync.org/]
#a-badge[https://en.wikipedia.org/wiki/FreeFileSync]
#a-badge[https://github.com/hkneptune/FreeFileSync]

- GPLv3
- #q[The FreeFileSync standard and Donation Edition are for *private use* only.

  *Commercial use*, government use, and other non-private uses require
  the purchase of the FreeFileSync Business Edition.]
