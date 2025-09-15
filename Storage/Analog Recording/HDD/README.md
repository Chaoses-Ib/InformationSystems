# Hard Disk Drives
[Wikipedia](https://en.wikipedia.org/wiki/Hard_disk_drive)

![](https://upload.wikimedia.org/wikipedia/commons/5/52/Hard_drive-en.svg)

A **platter** is a circular hard surface on which data is stored persistently by inducing magnetic changes to it. A disk may have one or more platters; each platter has 2 sides, each of which is called a **surface**. These platters are usually made of some hard material (such as aluminum), and then coated with a thin magnetic layer that enables the drive to persistently store bits even when the drive is powered off.

The platters are all bound together around the **spindle**, which is connected to a motor that spins the platters around (while the drive is powered on) at a constant (fixed) rate. The rate of rotation is often measured in **rotations per minute (RPM)**, and typical modern values are in the 7,200 RPM to 15,000 RPM range. 

Data is encoded on each surface in concentric circles of sectors; we call one such concentric circle a **track**. A single surface contains many thousands and thousands of tracks, tightly packed together, with hundreds of tracks fitting into the width of a human hair.

To read and write from the surface, we need a mechanism that allows us to either sense (i.e., read) the magnetic patterns on the disk or to induce a change in (i.e., write) them. This process of reading and writing is accomplished by the **disk head**; there is one such head per surface of the drive. The disk head is attached to a single **disk arm**, which moves across the surface to position the head over the desired track.[^three]

## Disk scheduling
Because of the high cost of I/O, the OS has historically played a role in deciding the order of I/Os issued to the disk. More specifically, given a set of I/O requests, the **disk scheduler** examines the requests and decides which one to schedule next.

Unlike job scheduler, by estimating the seek and possible rotational delay of a request, the disk scheduler can know how long each request will take, and thus (greedily) pick the one that will take the least time to service first. Thus, the disk scheduler will try to follow the principle of SJF (shortest job first) in its operation:[^three]

- Shortest seek time first (SSTF)

  SSTF is not a panacea for the following reasons:
  - First, the drive geometry is not available to the host OS; rather, it sees an array of blocks. Fortunately, this problem is rather easily fixed. Instead of SSTF, an OS can simply implement **nearest-block-first (NBF)**, which schedules the request with the nearest block address next.
  - The second problem is more fundamental: starvation.

- Elevator (SCAN)

  [Wikipedia](https://en.wikipedia.org/wiki/Elevator_algorithm)

  The algorithm, originally called **SCAN**, simply moves back and forth across the disk servicing requests in order across the tracks. Let’s call a single pass across the disk (from outer to inner tracks, or inner to outer) a sweep. Thus, if a request comes for a block on a track that has already been serviced on this sweep of the disk, it is not handled immediately, but rather queued until the next sweep (in the other direction).

  Unfortunately, SCAN and its cousins do not represent the best scheduling technology. In particular, SCAN (or SSTF even) do not actually adhere as closely to the principle of SJF as they could. In particular, they ignore rotation.

- Shortest positioning time first (SPTF)

  On modern drives, both seek and rotation are roughly equivalent (depending, of course, on the exact requests), and thus SPTF is useful and improves performance. However, it is even more difficult to implement in an OS, which generally does not have a good idea where track boundaries are or where the disk head currently is (in a rotational sense). Thus, SPTF is usually performed inside a drive.

Another important related task performed by disk schedulers is **I/O merging**.

## Interfaces
The basic interface for all modern drives is straightforward. The drive consists of a large number of **sectors** (512-byte blocks), each of which can be read or written. The sectors are numbered from $0$ to $n − 1$ on a disk with $n$ sectors. Thus, we can view the disk as an array of sectors; $0$ to $n − 1$ is thus the **address space** of the drive.

Multi-sector operations are possible; indeed, many file systems will read or write 4KB at a time (or more). However, when updating the disk, the only guarantee drive manufacturers make is that a single 512-byte write is atomic; thus, if an untimely power loss occurs, only a portion of a larger write may complete (sometimes called a **torn write**).[^three]

[Hard disk drive interface](https://en.wikipedia.org/wiki/Hard_disk_drive_interface)
- [Shugart Associates System Interface (SASI)](https://en.wikipedia.org/wiki/Shugart_Associates_System_Interface)
- [Small Computer System Interface (SCSI)](https://en.wikipedia.org/wiki/SCSI)
- [Parallel ATA (IDE)](https://en.wikipedia.org/wiki/Parallel_ATA)
- [Serial ATA (SATA)](https://en.wikipedia.org/wiki/Serial_ATA)
- [Serial Attached SCSI (SAS)](https://en.wikipedia.org/wiki/Serial_attached_SCSI)

## Form Factors
[List of disk drive form factors](https://en.wikipedia.org/wiki/List_of_disk_drive_form_factors)
- 3.5-inch
- 2.5-inch


[^three]: Operating Systems: Three Easy Pieces