#import "@local/ib:0.1.0": *
#show: ib
#title[Garage]
#a-badge[https://git.deuxfleurs.fr/Deuxfleurs/garage]
#a-badge[https://github.com/deuxfleurs-org/garage]
#a-badge(body: [Blog])[https://garagehq.deuxfleurs.fr/blog/]

- License: AGPLv3

  #a[Commoning open-source versus growth-hacking open-source | Garage blog][https://garagehq.deuxfleurs.fr/blog/2025-commoning-opensource/]

#a[Goals and use cases | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/design/goals/]
- *Goals*
  - *Internet enabled*: made for multi-sites (eg. datacenters, offices, households, etc.) interconnected through regular Internet connections.
  - *Self-contained & lightweight*: works everywhere and integrates well in existing environments to target hyperconverged infrastructures.
  - *Highly resilient*: highly resilient to network failures, network latency, disk failures, sysadmin failures.
  - *Simple*: simple to understand, simple to operate, simple to debug.
- *Non-goals*
  - *Extreme performances*: high performances constrain a lot the design and the infrastructure; we seek performances through minimalism only.
  - *Feature extensiveness*: we do not plan to add additional features compared to the ones provided by the S3 API.
  - *Storage optimizations*: erasure coding or any other coding technique both increase the difficulty of placing data and synchronizing; we limit ourselves to duplication.
  - *POSIX/Filesystem compatibility*: we do not aim at being POSIX compatible or to emulate any kind of filesystem. Indeed, in a distributed environment, such synchronizations are translated in network messages that impose severe constraints on the deployment.

#a[List of Garage features | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/reference-manual/features/]
- #a[Encryption | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/cookbook/encryption/]
- #a[\#925 - WIP: Windows support - Deuxfleurs/garage - Forge Deuxfleurs][https://git.deuxfleurs.fr/Deuxfleurs/garage/pulls/925]

#a[Related work | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/design/related-work/]

#t[2512]
#a[Garage -- An S3 object store so reliable you can run it outside datacenters | Hacker News][https://news.ycombinator.com/item?id=46326984]
- #q[We’ve done some fairly extensive testing internally recently and found that Garage is somewhat easier to deploy in comparison to our existing use of MinIO, but is not as performant at high speeds. IIRC we could push about 5 gigabits of (not small) GET requests out of it, but something blocked it from reaching the 20-25 gigabits (on a 25g NIC) that MinIO could reach (also 50k STAT requests/s, over 10 nodes)

  I don’t begrudge it that. I get the impression that Garage isn’t necessarily focussed on this kind of use case.]

= Deployment
#a[Quick Start][https://garagehq.deuxfleurs.fr/documentation/quick-start/]
- #a[Downloads][https://garagehq.deuxfleurs.fr/download/]

#a[Deployment on a cluster][https://garagehq.deuxfleurs.fr/documentation/cookbook/real-world/]
- #a[Cluster layout management][https://garagehq.deuxfleurs.fr/documentation/operations/layout/]
- #a[Starting Garage with `systemd`][https://garagehq.deuxfleurs.fr/documentation/cookbook/systemd/]
- [ ] #a[\#450 - Declarative bucket and key configuration][https://git.deuxfleurs.fr/Deuxfleurs/garage/issues/450]

#a[Configuration file format][https://garagehq.deuxfleurs.fr/documentation/reference-manual/configuration/]
- `replication_factor`: 2, 3, 5, 7, ...
  - Hard to dynamically change.
  - [ ] #a[\#838 - Buckets with different replication factor][https://git.deuxfleurs.fr/Deuxfleurs/garage/issues/838]
- `consistency_mode`
- `compression_level`: 0 (3), 1 (default)\~19, ultra: 20\~22.
  - #q[Compression is done synchronously, setting a value too high will add latency to write queries.]

#a[Garage S3对象存储单节点部署指南-荒岛][https://lala.im/9907.html]

== Zones
#q[
Zones are simply a user-chosen identifier that identify a group of server that are grouped together logically.
It is up to the system administrator deploying Garage to identify what does "grouped together" means.
  
In most cases, a zone will correspond to a geographical location (i.e. a datacenter).
Behind the scene, Garage will use zone definition to try to store the same data on different zones,
in order to provide high availability despite failure of a zone.
]

Garage uses quorum to ensure consistency.
It prioritizes which nodes to query according to a few criteria:
#footnote[#a[Internals | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/design/internals/#node-preference]]
- A node always prefers itself if it can answer the request
- Then the node prioritizes nodes in the same zone
- Finally the nodes with the lowest latency are prioritized

= Performance
#a[Benchmarks | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/design/benchmarks/]

- #a[\#1102 - Poor performance][https://git.deuxfleurs.fr/Deuxfleurs/garage/issues/1102]

  #q[Since Garage wants to tolerate node failures, it uses quorum writes to send data blocks to storage nodes:
  try to write the block to three nodes, and return ok as soon as two writes complete.
  So even if all three nodes are online, the third write always completes asynchronously.
  In general, there are not many writes to a cluster, and the third asynchronous write can terminate early enough so as to not cause unbounded RAM growth.
  However, if the S3 API node is continuously receiving large quantities of data and the third node is never able to catch up, many data blocks will be kept buffered in RAM as they are awaiting transfer to the third node.
  
  The `block_ram_buffer_max` sets a limit to the size of buffers that can be kept in RAM in this process. When the limit is reached, backpressure is applied back to the S3 client.]
- #a[\#1171 - garage singlenode s3 performance is slow compare to other s3 storage][https://git.deuxfleurs.fr/Deuxfleurs/garage/issues/1171]
- [x] #a[\#1235 - Change optimization level to 3][https://git.deuxfleurs.fr/Deuxfleurs/garage/pulls/1235]

  #q[Very interesting.
  I think it is more common to build software with O2 because O3 is associated with subtle incorrectness in the generated code.
  Do you have data about how the performance of O3 compares to the performance of O2 on garage?]

  自作聪明的 owner…
- [ ] Multi-node download/upload
  - Connect to more nodes until speed converges.

== Cache
#a[\#874 - Document built-in caching behavior (or absence thereof)][https://git.deuxfleurs.fr/Deuxfleurs/garage/issues/874]
#q[
Caching data blocks is the first kind of caching that we could add, and it is already tracked in \#179.
It would be relatively straightforward to implement, as data blocks are content-addressed and therefore there is no issue with cache invalidation to handle,
and it would handle the bulk of the issue as it would have the potential of reducing traffic significantly for large frequently-requested objects.

I think we do not want to go further and try to cache object metadata, as this would impact the consistency properties of Garage.
This means that when fetching an object from Garage, there will always be at least one inter-zone RPC call before the Garage daemon can give its answer, so there is an incompressible latency there.
If we do not do this, we incur the risk of returning old versions of objects, which is not acceptable for the S3 API,
and probably not for the Web endpoint either as it is frequently used as a public access point for data programmatically added by external applications (such as media files).
]
- [ ]
  #a[\#179 - have some kind of cache for frequently accessed blocks][https://git.deuxfleurs.fr/Deuxfleurs/garage/issues/179]

= Network
Ports:
- RPC: 3901/TCP

  #a[`garage/src/net/message.rs`][https://git.deuxfleurs.fr/Deuxfleurs/garage/src/commit/730c61380779ef67549671c5632880132e5e6989/src/net/message.rs#L394]
- S3 API: 3900/HTTP
- S3 Web: 3902/HTTP
- Admin API: 3903/HTTP
- K2V API: 3904/HTTP

Only RPC is required.

#a[Configuring a reverse proxy | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/cookbook/reverse-proxy/]

#a[\#1280 - CLI via admin http api and not only internal rpc - Deuxfleurs/garage - Forge Deuxfleurs][https://git.deuxfleurs.fr/Deuxfleurs/garage/issues/1280]

= API
#a[S3 compatibility target | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/working-documents/compatibility-target/]

= Security
- If `rpc_secret` and any node id are leaked, the attacker can:
  - Know all nodes' IP address, hostname, capacity.
  - Read/write all buckets.
    - Client-side encryption (E2EE)
    - Multi-cluster backup
  - DoS attack to all nodes.

= UI
- #a[khairul169/garage-webui: WebUI for Garage Object Storage Service][https://github.com/khairul169/garage-webui]

== Official
#t[2506]
#q[
As part of our new NLnet grant, we will develop a fully-fledged administration UI for Garage.
Thanks to multiple API tokens and token expiration, you will be able to easily rotate the access token for this UI, and to rapidly revoke the current token if it is compromised.
Setting a master admin API token in the configuration file, while still supported, will become a discouraged practice.
]
#footnote[#a[Garage v2.0.0 has been released | Garage blog][https://garagehq.deuxfleurs.fr/blog/2025-06-garage-v2/]]
