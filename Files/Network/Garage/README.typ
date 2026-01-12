#import "@local/ib:0.1.0": *
#title[Garage]
#a-badge[https://git.deuxfleurs.fr/Deuxfleurs/garage]
#a-badge[https://github.com/deuxfleurs-org/garage]

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
#a[Garage S3对象存储单节点部署指南-荒岛][https://lala.im/9907.html]

= Performance
#a[Benchmarks | Garage HQ][https://garagehq.deuxfleurs.fr/documentation/design/benchmarks/]

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

= UI
- #a[khairul169/garage-webui: WebUI for Garage Object Storage Service][https://github.com/khairul169/garage-webui]
