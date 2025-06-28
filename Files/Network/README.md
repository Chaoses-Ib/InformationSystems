# Network File Systems
[Wikipedia](https://en.wikipedia.org/wiki/Clustered_file_system)

Any file system operating through networks is a network file system.

Implementations:
- [File transfer based NFS](#file-transfer-based-nfs)
- [File synchronization based NFS](#file-synchronization-based-nfs)
- [Dedicated NFS](#dedicated-nfs)
- [Parallel file systems](#parallel-file-systems)
- [P2P file systems](#p2p-file-systems)

Terminology:
- Network file systems

- Remote file systems

- Clustered file systems

  > A clustered file system (CFS) is a file system which is shared by being simultaneously mounted on multiple servers.

  > Parallel file systems are a type of clustered file system that spread data across multiple storage nodes, usually for redundancy or performance.

- Shared-disk file systems

  > A shared-disk file system uses a storage area network (SAN) to allow multiple computers to gain direct disk access at the block level.

- Distributed file systems

  > Distributed file systems do not share block level access to the same storage but use a network protocol. These are commonly known as network file systems, even though they are not the only file systems that use the network to send data. Distributed file systems can restrict access to the file system depending on access lists or capabilities on both the servers and the clients, depending on how the protocol is designed.

- Network-attached storage

  > Network-attached storage (NAS) provides both storage and a file system, like a shared disk file system on top of a storage area network (SAN).

[filesystems - Distributed vs clustered vs networked file system - Super User](https://superuser.com/questions/487645/distributed-vs-clustered-vs-networked-file-system)

[Why use GlusterFS / Ceph over a SAN (storage area network)? : r/sysadmin](https://www.reddit.com/r/sysadmin/comments/ymc5gb/why_use_glusterfs_ceph_over_a_san_storage_area/)

[Dedicated NAS vs distributed file storage (glusterfs, ceph...) : r/homelab](https://www.reddit.com/r/homelab/comments/y0fzcx/dedicated_nas_vs_distributed_file_storage/)

[networking - How can I set up a low-latency shared filesystem between two or more computers? - Super User](https://superuser.com/questions/1683443/how-can-i-set-up-a-low-latency-shared-filesystem-between-two-or-more-computers)

## File transfer based NFS
[File transfer](../Transfer/README.md) + mount/transparent

- Often limited FS API
- Can be used with cloud/object storage
- With cache, effectively becomes selective file synchronization

File systems:
- SMB ([Wikipedia](https://en.wikipedia.org/wiki/Server_Message_Block))
  - CIFS
- 9P ([Wikipedia](https://en.wikipedia.org/wiki/9P_(protocol)))
- Internet File System[^chung-hwaraoOverviewInternetFile1997]

## File synchronization based NFS
[File synchronization](../Sync/README.md) + local file system

- Full redundancy and cache. Naturally parallel file systems.

## Dedicated NFS
[Distributed file systems - Wikipedia](https://en.wikipedia.org/wiki/List_of_file_systems#Distributed_file_systems)

- Sun Network File System[^sandbergSunNetworkFilesystem1986] ([Wikipedia](https://en.wikipedia.org/wiki/Network_File_System))

[A guide to clustered file systems](https://www.ufsexplorer.com/articles/clustered-file-systems/)

## Parallel file systems
[Distributed fault-tolerant file systems - Wikipedia](https://en.wikipedia.org/wiki/List_of_file_systems#Distributed_fault-tolerant_file_systems)

[Distributed parallel file systems - Wikipedia](https://en.wikipedia.org/wiki/List_of_file_systems#Distributed_parallel_file_systems)

[Distributed parallel fault-tolerant file systems - Wikipedia](https://en.wikipedia.org/wiki/List_of_file_systems#Distributed_parallel_fault-tolerant_file_systems)
- [Ceph](Ceph.md)
- [GlusterFS](Gluster.md)
- [Lustre](https://www.lustre.org/) ([Wikipedia](https://en.wikipedia.org/wiki/Lustre_(file_system)))
- HDFS

[Ceph VS GlusterFS? : r/sysadmin](https://www.reddit.com/r/sysadmin/comments/9onemk/ceph_vs_glusterfs/)

[Best options for shared filesystem in cluster? : r/linuxadmin](https://www.reddit.com/r/linuxadmin/comments/8co8ry/best_options_for_shared_filesystem_in_cluster/)
> Minus 1 for Gluster here. Used it a while back: me and the team really didn't get on with it. Harmonising brick sizes, FUSE mounts - it all felt a bit too brittle. Ceph was a much better fit for our shared blobstore use case.

> Ceph is a good option, but damn it can be a bit complicated on the ops side. Experience:/ran a 6.6pb ceph cluster across two sites. Good times.

[Storage Rearchitecture advice? Ceph vs GlusterFS : r/homelab](https://www.reddit.com/r/homelab/comments/15ybymd/storage_rearchitecture_advice_ceph_vs_glusterfs/)

[glusterfs - Data resiliency in Ceph or Gluster - Server Fault](https://serverfault.com/questions/1032430/data-resiliency-in-ceph-or-gluster)

[Help with homelab cluster setup. Ceph or Gluster, something else? : r/Proxmox](https://www.reddit.com/r/Proxmox/comments/u7cdkh/help_with_homelab_cluster_setup_ceph_or_gluster/)

[Need Help with a GlusterFS Alternative : r/selfhosted](https://www.reddit.com/r/selfhosted/comments/1behxb3/need_help_with_a_glusterfs_alternative/)

[Ceph alternative for a 3 node cluster : r/Proxmox](https://www.reddit.com/r/Proxmox/comments/12ccl79/ceph_alternative_for_a_3_node_cluster/)

[Distributed Network File System : r/selfhosted](https://www.reddit.com/r/selfhosted/comments/10oqu7a/distributed_network_file_system/)

## P2P file systems
- [InterPlanetary File System (IPFS)](IPFS.md)


[^sandbergSunNetworkFilesystem1986]: Sandberg, R. (1986). The Sun Network Filesystem: Design, Implementation and Experience.
[^chung-hwaraoOverviewInternetFile1997]: Chung-Hwa Rao, H., Chen, M.-F., & Wang, F.-J. (1997). An overview of the Internet File System. Proceedings Twenty-First Annual International Computer Software and Applications Conference (COMPSAC’97), 474–477. https://doi.org/10.1109/CMPSAC.1997.625047
