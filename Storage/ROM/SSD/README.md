# Solid-State Drives
[Wikipedia](https://en.wikipedia.org/wiki/Solid-state_drive)

2023-07 [被垄断的NAND闪存技术 - 知乎](https://zhuanlan.zhihu.com/p/644147929)

[SSD 白箱測試全指南：從演進挑戰到內部架構與實戰案例](https://vocus.cc/article/68bd2edbfd89780001a03193)

## Flash translation layer (FTL)
[Flash Translation Layer (FTL) -- 石頭筆記 -- 假作真時真作假，無為有處有為無。](https://chienweichih.github.io/flash-translation-layer/)

t180807
[SSD深度技术解析---FTL层算法对性能的影响\_ftl算法 - CSDN博客](https://blog.csdn.net/weixin_38233274/article/details/78865255)

## DRAM cache
- DRAM-less
- DRAM-based
- Host memory buffer (HMB)
  - 64 MiB

[有缓盘?为什么Drambased不是业界的未来 - 哔哩哔哩](https://www.bilibili.com/video/BV1FN4VewEiN/)
- Client SSD 无断电保护，导致倾向于保守使用 DRAM。
- Client DRAM-based 在 4K 深队列混合读写场景表现稍好，实际场景基本没有区别。

2022-01 [Do I need an SSD with DRAM? : r/buildapc](https://www.reddit.com/r/buildapc/comments/s1usmm/do_i_need_an_ssd_with_dram/)
> For a boot drive I wouldn't do without it. As the dram cache takes the brunt of the writes.

2023-10 [Why do many people say that DRAM is not necessary for an SSD used for games, whereas it has to access so many files on the SSD to load them to memory? : r/hardware](https://www.reddit.com/r/hardware/comments/175wd2o/why_do_many_people_say_that_dram_is_not_necessary/)
> DRAM on the drive benefits writes, not reads. Gaming is extremely read-heavy, and reads are cached in system memory anyways.

> The short of it is that games loads aren't that strenuous of an activity for an SSD. A lot of large sequential reads, and a lot of downtime between the files being overwritten so it has a lot of spare time to do internal maintainance/gargabe collection to reduce the FTL size.
> 
> DRAMless drives use 2 strategies to mitigate lack of DRAM... first is they try to directly use a small window of system RAM. it's called DMA and it bypasses the OS entirely once the window is set up on the IMMOU controller. It increases latency for any given lookup, but game loads aren't highly fragmented.
> 
> Second is that it uses cells dedicated to the FTL in SLC mode which improves bandwidth and decreases latency from loading FTL directly from flash. Flash is fast enough now to host it's own FTL directly for simple workloads.

2025-07 [Is the DRAM really that important for a SSD mainly used for storage and gaming? : r/buildapc](https://www.reddit.com/r/buildapc/comments/1m56jtb/is_the_dram_really_that_important_for_a_ssd/)

## Interfaces
- [HDD interfaces](../../Analog%20Recording/HDD/README.md#interfaces)
  - SATA
  - SAS
- [NVM Express](https://en.wikipedia.org/wiki/NVM_Express)

## Form Factors
- [HDD form factors](../../Analog%20Recording/HDD/README.md#form-factors)
  - 2.5-inch
- [mSATA](https://en.wikipedia.org/wiki/MSATA)
- [M.2 (NGFF)](https://en.wikipedia.org/wiki/M.2)
- [PCI Express](https://en.wikipedia.org/wiki/PCI_Express#Form_factors)

## Capacity
[Does 4 TB NVMe worsen in performance vs. 2 TB NVMe : r/buildapc](https://www.reddit.com/r/buildapc/comments/18mtzvz/does_4_tb_nvme_worsen_in_performance_vs_2_tb_nvme/)
> FTL没MAPPING那么多

[Why do people go for two 2TB SSD's and not one 4TB SSD? The costs are similar. : r/buildapc](https://www.reddit.com/r/buildapc/comments/1bmm69p/why_do_people_go_for_two_2tb_ssds_and_not_one_4tb/)

[为啥4tb的m.2 ssd比两个2tb的还贵啊？ 178](https://nga.178.com/read.php?tid=33155840&rand=598)

[\[硬件产品讨论\] SSD弄到2T的人都是干啥用的啊？理论上还是要用HDD存放文件的吧？ NGA玩家社区 P1](https://bbs.nga.cn/read.php?tid=40920035)
> 我宁愿多买几个SSD多备份，我也不会去寄希望于什么HDD数据可恢复啥的，我是四个SSD互相备份重要数据

> 2T不就装点片片吗。。。  
> 常用的文件当然放固态 机械已经进不了DIY大众机箱了。。。更不要说挂了你一样不舍得开盘。。。  
> 2T固态都不舍得买的个人 100%不会去开盘的  

> 一部蓝光原盘电影都几十个G了，现在的游戏也动辄100多g。2T也就差不多够用的水平

[2TB or 4TB SSD - Is 4TB overkill for gaming? : r/buildapc](https://www.reddit.com/r/buildapc/comments/129q1ky/2tb_or_4tb_ssd_is_4tb_overkill_for_gaming/)
