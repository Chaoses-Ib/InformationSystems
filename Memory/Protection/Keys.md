# Memory Protection Keys
[Wikipedia](https://en.wikipedia.org/wiki/Memory_protection#Protection_keys)

Pkeys Userspace (PKU) is a feature which can be found on:
- Intel server CPUs, Skylake and later
- Intel client CPUs, Tiger Lake (11th Gen Core) and later
- AMD CPUs, Zen 3 and later
- arm64 CPUs implementing the Permission Overlay Extension (FEAT_S1POE)

> MPK suffers from permission violation from fundamental hardware design, known as meltdown-pk. Like other meltdown variants, speculative execution allows for reading data speculatively located in MPK domains. It is mitigated by address space isolation and will be mitigated by hardware support in future processors as well.[^parkMemoryProtectionKeys2023]

Libraries:
- Rust
  - [rust-pkeys: rust bindings for pkeys(7)](https://github.com/mmisono/rust-pkeys)
  - [galeed](https://github.com/mit-ll/galeed)
- [Donky: Domain Keys – Efficient In-Process Isolation for RISC-V and x86](https://github.com/IAIK/Donky)
- [sslab-gatech/libmpk](https://github.com/sslab-gatech/libmpk)
- [ssrg-vt/libhermitMPK: Intra-Unikernel Isolation with Intel Memory Protection Keys](https://github.com/ssrg-vt/libhermitMPK)
- [HexHive/ShadowStack: LLVM Implementation of different ShadowStack schemes for x86\_64](https://github.com/HexHive/ShadowStack)

Wasm:
- Chromium

  > Chromium originally adopted `mprotect`-based W ⊕ X protection to prevent code injection, but the method incurs a high system call overhead for permission switching as it requires invoking an `mprotect` system call to obtain and revoke write permission. By replacing the `mprotect`-based protection with MPK-based protection, Chromium can alleviate the performance overhead. As an unexpected beneficial effect, it can also protect the memory from race conditions.[^parkMemoryProtectionKeys2023]

- [PKU-ASAL/PKUWA: Protection Key in Userspace for WebAssembly](https://github.com/PKU-ASAL/PKUWA)

## x86
Supported by mainstream x86 from 2021.

> Pkeys work by dedicating 4 previously Reserved bits in each page table entry to a “protection key”, giving 16 possible keys.
> 
> Protections for each key are defined with a per-CPU user-accessible register (PKRU). Each of these is a 32-bit register storing two bits (Access Disable and Write Disable) for each of 16 keys.
> 
> Being a CPU register, PKRU is inherently thread-local, potentially giving each thread a different set of protections from every other thread.
> 
> There are two instructions (`RDPKRU`/`WRPKRU`) for reading and writing to the register. The feature is only available in 64-bit mode, even though there is theoretically space in the PAE PTEs. These permissions are enforced on data access only and have no effect on instruction fetches.

[WRPKRU --- Write Data to User Page Key Register](https://www.felixcloutier.com/x86/wrpkru)

## Linux
[Memory Protection Keys --- The Linux Kernel documentation](https://docs.kernel.org/core-api/protection-keys.html)
```c
int real_prot = PROT_READ|PROT_WRITE;
pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
ptr = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
ret = pkey_mprotect(ptr, PAGE_SIZE, real_prot, pkey);
```
```c
pkey_set(pkey, 0); // clear PKEY_DISABLE_WRITE
*ptr = foo; // assign something
pkey_set(pkey, PKEY_DISABLE_WRITE); // set PKEY_DISABLE_WRITE again
```
申请个 key，设置到页面上，然后就可以通过这个 key 来控制禁止读写。

[Page-table hardening with memory protection keys \[LWN.net\]](https://lwn.net/SubscriberLink/1004029/cfef7018513ca3ac/)

## Windows
[Myria："Does Windows support the PKRU / memory protection keys / tagged memory of recent processors? I don't see anything about it in VirtualProtect documentation." / X](https://x.com/Myriachan/status/1410085659608449027)
> Im trying to make execute only page on AMD, and also using amd svm, but when i set cr4.pke, change the pte mpk and use asm to write pkru,Windows' display will be stuck or  don't have any different, the page that set the permission still can be seen


[^parkMemoryProtectionKeys2023]: Park, S., Lee, S., & Kim, T. (2023). Memory Protection Keys: Facts, Key Extension Perspectives, and Discussions. IEEE Security & Privacy, 21(3), 8–15. https://doi.org/10.1109/MSEC.2023.3250601
