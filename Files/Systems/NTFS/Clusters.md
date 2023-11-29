# Clusters
> Internally, NTFS refers only to clusters. (However, NTFS forms low-level volume I/O operations such that clusters are sector-aligned and have a length that is a multiple of the sector size.) NTFS uses the cluster as its unit of allocation to maintain its independence from physical sector sizes. This independence allows NTFS to efficiently support very large disks by using a larger cluster factor or to support newer disks that have a sector size other than 512 bytes. On a larger volume, use of a larger cluster factor can reduce fragmentation and speed allocation, at the cost of wasted disk space.
> 
> NTFS refers to physical locations on a disk by means of **logical cluster numbers (LCNs)**. LCNs are simply the numbering of all clusters from the beginning of the volume to the end. To convert an LCN to a physical disk address, NTFS multiplies the LCN by the cluster factor to get the physical byte offset on the volume, as the disk driver interface requires.
> 
> NTFS refers to the data within a file by means of **virtual cluster numbers (VCNs)**. VCNs number the clusters belonging to a particular file from $0$ through $m$. VCNs aren’t necessarily physically contiguous, however; they can be mapped to any number of LCNs on the volume.[^winter]


[^winter]: Windows Internals