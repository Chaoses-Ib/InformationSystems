# Input-output Memory Management Unit (IOMMU)
[Wikipedia](https://en.wikipedia.org/wiki/Input%E2%80%93output_memory_management_unit#Virtualization)

> Hardware that performs direct memory access completely bypasses the CPU's MMU. Some I/O systems allow DMA hardware to use physical addresses to read or write directly anywhere in physical RAM without any restrictions. Other I/O systems have a separate MMU called an input-output memory management unit (IOMMU) that can be programmed by the OS to translate device addresses from the DMA hardware to specific, limited physical pages chosen by the OS. The IOMMU can be used to block DMA attacks.

[List of IOMMU-supporting hardware - Wikipedia](https://en.wikipedia.org/wiki/List_of_IOMMU-supporting_hardware)

[惊人的 IOMMU Overhead 与不合理的 AQC 网卡驱动 -- 属于CYY自己的世界](https://blog.cyyself.name/iommu-overhead/)
> 而让我更加意想不到的是，原来网卡驱动可以如此草台班子，一个 descriptor 只开一个页面，MTU 1500 时只能放 2 个 eth frame，超过了就要进行 Overhead 非常之大的 IOMMU 重映射操作。

## Implementations
### x86
- Intel VT-d

  [Intel Virtualization Technology for Directed I/O (VT-d) Architecture Specification](https://web.archive.org/web/20130623063513/http://www.intel.com/content/www/us/en/intelligent-systems/intel-technology/vt-directed-io-spec.html)
- AMD-Vi

  [AMD I/O Virtualization Technology (IOMMU) Specification Revision 1.26](https://web.archive.org/web/20110124134140/http://support.amd.com/us/Processor_TechDocs/34434-IOMMU-Rev_1.26_2-11-09.pdf)

### ARM
[Introduction to the ARMv8 Virtualization System | openEuler](https://www.openeuler.org/en/blog/yorifang/2020-10-24-arm-virtualization-overview.html#_3-i-o-virtualization)
> Similar to x86, the key to device passthrough on ARM is to solve the problems of DMA remapping and interrupt delivery of passthrough devices. However, ARMv8-A uses SMMUv3.1 to process DMA remapping and the GICv3 interrupt controller to implement interrupt delivery. SMMUv3 and GICv3 take many virtualization implementations into consideration during design, and make improvements for virtualization scenarios.

[Arm Neoverse N2 reference design Technical Overview](https://developer.arm.com/documentation/102337/0000/Hardware-and-topology/I-O-Virtualization-block)

## Security
> 最近三角洲行动（我一直感觉这名字挺离谱的中国公司做个 Delta Force，JSOC 不去要个版权费吗）BSOD 的问题看起来挺有意思的
> 
> 看了几个分析，貌似腾讯 ACE 拦截 DMA 的方法是强制 IOMMU (Intel VT-d) 虚拟化 PCIe 设备之后可能 hook 了所有 DMA mapping (`dma_map_page` ?) 之类的，所有设备包括显卡和 NVMe SSD 的 DMA access 都要经过 ACE 的 hook，导致了各种冲突和误报，和显卡/硬盘冲突的话就会直接导致系统起不来文件丢失之类的问题，感觉分析 ACE 具体是怎么操作的会很有意思
> 
> 腾讯这招真刺激啊，hook 所有 DMA，在 spyware 的路上越走越远了
> 
> For context: https://www.bilibili.com/video/BV1TV8FzzEy6

[Vanguard Restrictions -- VALORANT Support](https://support-valorant.riotgames.com/hc/en-us/articles/22291331362067-Vanguard-Restrictions)
> 但是 vgk 会 hook DMA 吗  
> at least since Dec 2022

## Virtualization
[Wikipedia](https://en.wikipedia.org/wiki/Input%E2%80%93output_memory_management_unit#Virtualization)

[x86 virtualization - Wikipedia](https://en.wikipedia.org/wiki/X86_virtualization#I/O_MMU_virtualization_(AMD-Vi_and_Intel_VT-d))
