#import "@local/ib:0.1.0": *
#title[#a[EROFS][https://erofs.docs.kernel.org]]
#a-badge[https://en.wikipedia.org/wiki/EROFS]
#a-badge[https://docs.kernel.org/filesystems/erofs.html]

- Used by Android 13,
  #footnote[https://www.reddit.com/r/Android/comments/utu32k/android_13_launch_devices_will_use_huaweis_erofs/]
  #footnote[#a[Modifying Android EroFS Partitions to Remove Encryption and More | by Ravindu Deshan | Medium][https://ravindu644.medium.com/modifying-android-erofs-partitions-to-remove-encryption-and-more-32e167da6440]]
  Fedora 42.
  #footnote[#a[Fedora 42 Is Looking At Switching To EROFS For Its Live Media - Phoronix][https://www.phoronix.com/news/Fedora-42-Considers-EROFS]
  #a-badge[https://www.phoronix.com/forums/forum/software/distributions/1519308-fedora-42-is-looking-at-switching-to-erofs-for-its-live-media]]
  
#a[An introduction to EROFS [LWN.net]][https://lwn.net/Articles/934047/]

#a[Add EROFS filesystem as an alternative format - snapd - snapcraft.io][https://forum.snapcraft.io/t/add-erofs-filesystem-as-an-alternative-format/33487]

= Performance
#a[EROFS vs. SquashFS: A Gentle Benchmark][https://sigma-star.at/blog/2022/07/squashfs-erofs/]

#a[🙋 Frequently Asked Questions --- EROFS filesystem project][https://erofs.docs.kernel.org/en/latest/faq.html]

```sh
mkfs.erofs -zzstd,22 -C65536 -T0 -Efragments,ztailpacking,dedupe,force-inode-compact foo.erofs dir/
```
- `zstd,15` for faster compressing and decompressing.
  - `msvc-wine`: 3.4G $->$ 481M

- Large `-C` (than 4096) and `all-fragments`
  #footnote[#a[Switch EROFS live generation from `-Eall-fragments` to `-Efragments` - Issue \#1991 - coreos/fedora-coreos-tracker][https://github.com/coreos/fedora-coreos-tracker/issues/1991]]
  can degrade runtime performance,
  but `ztailpacking`,
  #footnote[#a[EROFS-Utils 1.5 Released With ZTailPacking, FSCK Extraction - Phoronix][https://www.phoronix.com/news/EROFS-Utils-1.5-Released]]
  `fragments` and `dedupe` are undocumented.

- Android
  #footnote[#a["mkfs.erofs " - Search][https://cs.android.com/search?q=%22mkfs.erofs%20%22]]
  - ```sh -z lz4hc,9```
    #footnote[#a[`build_image.py` - Android Code Search][https://cs.android.com/android/platform/superproject/+/android-latest-release:build/make/tools/releasetools/build_image.py?q=%22mkfs.erofs%22&start=41]]
  - `update_engine/payload_generator`: ```sh -z lz4hc,9```
  - `sign_android_image.sh`: ```sh mkfs.erofs -z lz4hc -C32768```
    #footnote[#a[`sign_android_image.sh` - Android Code Search][https://cs.android.com/android/platform/superproject/+/android-latest-release:external/vboot_reference/scripts/image_signing/sign_android_image.sh?q=%22mkfs.erofs%20%22]]
  - APEX: ```sh mkfs.erofs -z lz4hc -C4096 -U $(uuid.uuid5(uuid.NAMESPACE_URL, 'www.android.com')) -T0```
    #footnote[#a[apexer.py - Android Code Search][https://cs.android.com/android/platform/superproject/+/android-latest-release:system/apex/apexer/apexer.py?q=%22mkfs.erofs%20%22]]

#q[In some sense, EROFS choices result in worse compression ratios, but will gain decompress+read speed.
The compression ratios are worse by about 5-10%.
But the decompression times for EROFS are significantly faster.
The decompress+read took between 1/2 to 2/3 the time (depending on the decompression algorithm).
And it's that speed that is important for the mounting + snap-cold-start.]
#footnote[#a[Has Canonical Considered using EROFS instead of squashfs for snaps? : r/Ubuntu][https://www.reddit.com/r/Ubuntu/comments/1owyosz/has_canonical_considered_using_erofs_instead_of/]]

== Cache
#a[Page Cache Sharing Looks To Be Very Beneficial For EROFS Containers - Phoronix][https://www.phoronix.com/news/EROFS-Page-Cache-Sharing]
#a-badge[https://www.phoronix.com/forums/forum/software/general-linux-open-source/1601462-page-cache-sharing-looks-to-be-very-beneficial-for-erofs-containers]

= Libraries
- Rust: #a[erofs/erofs-rs: A userspace generic library of EROFS written in rust][https://github.com/erofs/erofs-rs]

= Tools
`erofs-utils`
#a-badge[https://github.com/erofs/erofs-utils]
:
- #a[📥 Installation --- EROFS filesystem project][https://erofs.docs.kernel.org/en/latest/install.html]

- `mkfs.erofs`
  #a-badge[https://man.archlinux.org/man/mkfs.erofs.1.en]

```sh
 -zX[,level=Y]         X=compressor (Y=compression level, Z=dictionary size, optional)
    [,dictsize=Z]      alternative compressors can be separated by colons(:)
    [:...]             supported compressors and their option ranges are:
                         lz4
                         lz4hc
                           [,level=<0-12>]              (default=9)
                         lzma
                           [,level=<0-9,100-109>]       0-9=normal, 100-109=extreme (default=6)
                           [,dictsize=<dictsize>]       (default=<auto>, max=8388608)
                         deflate
                           [,level=<0-9>]               (default=1)
                           [,dictsize=<dictsize>]       (default=32768, max=32768)
                         libdeflate
                           [,level=<0-12>]              (default=1)
                         zstd
                           [,level=<0-22>]              (default=3)
                           [,dictsize=<dictsize>]       (default=<auto>, max=1048576)
```
