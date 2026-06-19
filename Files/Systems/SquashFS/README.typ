#import "@local/ib:0.1.0": *
#title[SquashFS]
#a-badge[https://en.wikipedia.org/wiki/SquashFS]
#a-badge[https://docs.kernel.org/filesystems/squashfs.html]
#a-badge[https://wiki.gentoo.org/wiki/SquashFS]

- Used by Snap and AppImage.

#a[Full system backup with SquashFS - ArchWiki][https://wiki.archlinux.org/title/Full_system_backup_with_SquashFS]

= Performance
- Block size: 128 KiB by default.

- Compression algorithms
  #footnote[#a[Best way to compress mksquashfs? - Puppy Linux Discussion Forum][https://forum.puppylinux.com/viewtopic.php?t=9319]]
  - `gzip` by default.
  - `zstd` is used by Arch.
    #footnote[#a[What compression do you use in squashfs/kernel?][https://www.linuxquestions.org/questions/linux-software-2/what-compression-do-you-use-in-squashfs-kernel-4175673464/]]

```sh
mksquashfs -comp zstd -Xcompression-level 22 dir image.sqfs
```

#q[In my testing with OS installs that depend on squashfs+xz, there is a significant lzma hit for decompression, resulting in significant latencies.
And the higher the compression level used, the more the hit when decompressing.
While compression computational hit for zstd is in the same ballpark as xz to achieve the same compression ratio,
(a) decompression computational cost is far less with zstd, translating into faster reads;
(b) is fairly consistent regardless of compression level.

Another factor for squashfs is the block size.
The bigger it is, the better the compression ratio, but the greater the read amplification.]
#footnote[#a[Ubuntu 20.04 LTS' snap obsession has snapped me off of it | Hacker News][https://news.ycombinator.com/item?id=23052108]]

#a[Squashfs performance effect on snap startup time - snapd - snapcraft.io][https://forum.snapcraft.io/t/squashfs-performance-effect-on-snap-startup-time/13920]

#a[Squashfs Compression and Container Startup times | Pegasus Docs][https://pegasus.dfki.de/posts/squashfs-compression/]

#a[Squashfs is a terrible storage format - snapd - snapcraft.io][https://forum.snapcraft.io/t/squashfs-is-a-terrible-storage-format/9466]

#a[SquashFS Optimization Achieves 15,277x Performance In Developer Benchmark - Phoronix][https://www.phoronix.com/news/SquashFS-Faster-Sparse-Copy]

== Cache
#q[
Blocks in Squashfs are compressed.
To avoid repeatedly decompressing recently accessed data Squashfs uses two small metadata and fragment caches.

The cache is not used for file datablocks, these are decompressed and cached in the page-cache in the normal way.
The cache is used to temporarily cache fragment and metadata blocks which have been read as a result of a metadata (i.e. inode or directory) or fragment access.
Because metadata and fragments are packed together into blocks (to gain greater compression) the read of a particular piece of metadata or fragment will retrieve other metadata/fragments which have been packed with it, these because of locality-of-reference may be read in the near future.
Temporarily caching them ensures they are available for near future access without requiring an additional read and decompress.

In the future this internal cache may be replaced with an implementation which uses the kernel page cache.
Because the page cache operates on page sized units this may introduce additional complexity in terms of locking and associated race conditions.
]

== vs. DwarFS
#a[DwarFS vs. SquashFS - Porteus][https://forum.porteus.org/viewtopic.php?t=11718]

#q[writer 库也写好了，用了最简单的 rabin cdc + sha256 hash map 去重，块分小点效果能比上游更好一点。懒得写 CLI ，就放着库算了，感觉没什么必要和上游竞争。 \
bench: linux-6.7-src + zstd22 
- squashfs 194M
- dwarfs upstream 152M
- dwarfs-rs 139M
- tar.zst 135M （唯一不支持 mount 和多线程压缩的； `--ultra -T0 -22` 只能用两三个线程，不信自己试）
对 telegram export 这种文件之间只有全同没有部分相同的输入，三者输出没有显著大小差异。

感觉大部分情况可能无脑 squashfs 就差不多了，除非可以预见 block dedup 会很工作的场景，可以上 dwarfs 。#strike[有点白写了的感觉。]

不论如何，我是非常不建议现在这个年代还自用[\*] tar 了。
想要打带 \*nix metadata 的包，最无脑的选择大概确实是 squashfs 了，设计比较现代，还有 kernel 领头支持。
dwarfs 在合适场景也可以考虑，牺牲随机读取速度换体积，但支持度和实现数量差点。
要更 portable 的纯数据的话选择就更多了，在此不表。 \
\#暴论 我觉得在硬盘上 `.sqfs-nocompress.zst` 都比 `.tar.zst` 好（实际上前者能压缩得更小）；即使你真的有磁带机， tar 在这个时代也不是最优选择了。 \
XRef: https://t.me/kenvixmeow/31 \
[\*]: 指目的是存储/归档，而不是分发。分发会有更多的兼容考量， tar 有一席之地，虽然我也不认为它合适这个场景。

看了下 dwarfs readme 里的对比，我收回前言， erofs 性能体积和压缩速度全部都是倒数第一。我自己测试了一下，还是 linux-6.7-src+zstd22 
erofs 376M ，跑满 16 核耗时 8min53s ；相对的 sqfs 和 dwarfs 都是 65s 上下。
]

= Tools
#a[squashfs-tools: tools to create and extract Squashfs filesystems][https://github.com/plougher/squashfs-tools]
- `mksquashfs`
  #a-badge[https://man.archlinux.org/man/extra/squashfs-tools/mksquashfs.1.en]

- ```sh mount -o loop ~/home.sqfs ~/tmp```

== Windows
- WSL
- 7-Zip
  #footnote[#a[python 2.7 - How to handle squashfs in Windows - Stack Overflow][https://stackoverflow.com/questions/36478351/how-to-handle-squashfs-in-windows]]

= Distributions
- Ubuntu Core
- Puppy Linux
  #footnote[#a[Are Immutable Linux Distros right for you? | Hacker News][https://news.ycombinator.com/item?id=42493123]]
- TrueNAS
- Talos Linux: #a[How to Understand Talos Linux SquashFS Root Filesystem][https://oneuptime.com/blog/post/2026-03-03-understand-talos-linux-squashfs-root-filesystem/view]

#footnote[#a[ELI5 Difference between Immutable/Atomic Distro Approaches? : r/linuxquestions][https://www.reddit.com/r/linuxquestions/comments/1qco3n3/eli5_difference_between_immutableatomic_distro/]]
#footnote[#a[Can I use squashfs to create a distro? : r/linuxquestions][https://www.reddit.com/r/linuxquestions/comments/16cf4mn/can_i_use_squashfs_to_create_a_distro/]]
