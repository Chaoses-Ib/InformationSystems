#import "@local/ib:0.1.0": *
#title[Blocks]
= SSD
#q[SSD layout In contrast to the hard disk, a SSD consists of semiconductor memory building blocks, it contains no mechanical parts.
The smallest unit of an SSD is a page, which is composed of several memory cells, and is usually 4 KB in size.
Several pages on the SSD are summarized to a block.
A block is the smallest unit of access on a SSD.
Currently, 128 pages are mostly combined into one block; therefore, a block contains 512 KB.]
#footnote[#a[boot - SSD Block Sizing - Super User][https://superuser.com/questions/976271/ssd-block-sizing]]

#q[For practical use just align all your data structures (partitions, payload of LUKS containers, LVM logical volumes) to 1 or 2 MiB boundaries.
If Windows considers that aligning partitions to 1 MiB is enough you can bet that any SSD manufacturer will make sure that their products work well with such a configuration.]
#footnote[#a[Is there a way to find out SSD page size on Linux/Unix? What is "physical block" in fdisk output? - Unix & Linux Stack Exchange][https://unix.stackexchange.com/questions/334804/is-there-a-way-to-find-out-ssd-page-size-on-linux-unix-what-is-physical-block]]
