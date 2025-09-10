# RAM Drives
[Wikipedia](https://en.wikipedia.org/wiki/RAM_drive)

> Some RAM drives use a compressed file system such as cramfs to allow compressed data to be accessed on the fly, without decompressing it first. This is convenient because RAM drives are often small due to the higher price per byte than conventional hard drive storage.

[List of RAM drive software - Wikipedia](https://en.wikipedia.org/wiki/List_of_RAM_drive_software)

[MadMax - All Ramdisk slower? : r/chia](https://www.reddit.com/r/chia/comments/pse80p/madmax_all_ramdisk_slower/)

[Do RAM disks improve build time, and if yes, how exactly? : r/cpp](https://www.reddit.com/r/cpp/comments/1b2ir41/do_ram_disks_improve_build_time_and_if_yes_how/)

## Benchmarks
[Fiehn Lab - RamDisk](https://fiehnlab.ucdavis.edu/staff/kind/collector/benchmark/ramdisk)
- [RAMDISK Benchmarks](https://fiehnlab.ucdavis.edu/downloads/staff/kind/Collector/Benchmark/RamDisk/ramdisk-benchmarks.pdf)

[RAMDisk benchmarks](https://gist.github.com/hmemcpy/c7ea24fb9780c4e1810d)

[RAM Disk: Performance Comparison](https://www.starwindsoftware.com/blog/ram-disk-technology-performance-comparison/)

[Curiosity on SSDs, RAMdisks and benchmarks - Hardware Hub / Storage - Level1Techs Forums](https://forum.level1techs.com/t/curiosity-on-ssds-ramdisks-and-benchmarks/201257)

## Linux
- tmpfs ([Wikipedia](https://en.wikipedia.org/wiki/Tmpfs))
- [cramfs](https://sourceforge.net/projects/cramfs/) ([Wikipedia](https://en.wikipedia.org/wiki/Cramfs))

## Windows
- `FILE_ATTRIBUTE_TEMPORARY`

  > Files created with both `FILE_ATTRIBUTE_TEMPORARY` and `FILE_FLAG_DELETE_ON_CLOSE` are held in memory and only written to disk if the system experiences high memory pressure. In this way they behave like tmpfs, except the files are written to the specified path during low memory situations, rather than to swap space. This technique is often used by servers along with TransmitFile to render content to a buffer before sending to the client.
- [ImDisk Virtual Disk Driver](https://github.com/LTRData/ImDisk)
  - [ImDisk Toolkit](https://imdisktoolkit.com/) ([SourceForge](https://sourceforge.net/projects/imdisk-toolkit/))
    - [Massive Performance Lag on Windows 10 20H2 (build 2009)](https://sourceforge.net/p/imdisk-toolkit/discussion/general/thread/e1cf2605ed/)
- [Arsenal-Image-Mounter: Arsenal Image Mounter mounts the contents of disk images as complete disks in Microsoft Windows.](https://github.com/ArsenalRecon/Arsenal-Image-Mounter)
  - [AIM Toolkit](https://sourceforge.net/projects/aim-toolkit/)
- [ERAM: Open Source RAM Disk](https://github.com/Zero3K/ERAM)
  - Up to 4 GB

Proprietary:
- QSOFT Ramdisk
- VSuite Ramdisk
- [SoftPerfect RAM Disk](https://www.softperfect.com/products/ramdisk/)
- [Dataram RAMDisk](https://web.archive.org/web/20241004202734/http://memory.dataram.com/products-and-services/software/ramdisk)
- [ROG RAMDisk](https://web.archive.org/web/20230708134732/https://rog.asus.com/technology/republic-of-gamers-motherboard-innovations/ramdisk/)
  - 16~18334 MB
  - Dynamic allocation
  - NTFS
  - Junction
  - v2.03.00

  [The ROG RAMDisk Software - Republic of Gamers](https://rog.asus.com/articles/maximus-motherboards/the-rog-ramdisk-software/)

[RAM Disk on Windows 11 - Microsoft Q&A](https://learn.microsoft.com/en-us/answers/questions/4169254/ram-disk-on-windows-11)

## GPU
- [prsyahmi/GpuRamDrive: RamDrive that is backed by GPU Memory](https://github.com/prsyahmi/GpuRamDrive)
