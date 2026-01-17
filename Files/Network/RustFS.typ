#import "@local/ib:0.1.0": *
#title[RustFS]
#a-badge[https://github.com/rustfs/rustfs]

- License: Apache-2.0
- Slop.
- Web UI

#t[2601]
CVE-2025-68926
#a[gRPC Hardcoded Token Authentication Bypass - Reproduction Report - Advisory][https://github.com/rustfs/rustfs/security/advisories/GHSA-h956-rh7x-ppgj]

= Deployment
- #a[RustFS Multiple Node Multiple Disk Installation][https://docs.rustfs.com/installation/linux/multiple-node-multiple-disk.html]
  - #q[All RustFS servers in the deployment *must* use the same listening port.
    If you use port 9000, all ports on other servers must also be port 9000.]
  - #q[Creating a RustFS cluster requires *identical, sequential* hostnames.]
