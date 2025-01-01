# DDR SDRAM
[Wikipedia](https://en.wikipedia.org/wiki/DDR_SDRAM)

[\[其他问题\] 内存不亮症状的一种可能原因，排查过程和思路供参考 178](https://nga.178.com/read.php?tid=36581946&rand=14)
- 短路

[\[硬件求助\] 主板里的其中一条内存槽只要插上内存就点不亮主机，但单独使用另外一个槽就没问题 NGA玩家社区](https://ngabbs.com/read.php?tid=22119052&rand=843)

## Voltage
- The higher, the riskier.

Generations:
- DDR: 2.5/2.6
- DDR2: 1.8
- DDR3: 1.5/1.35
- DDR4: 1.2/1.05
- DDR5: 1.1

  [关于DDR5内存超频电压的疑问？ - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2470108-1-1.html)

[这些年内存条的电压为何越做越低了？现在内存条的主流电压是多高？ - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2605938-1-1.html)

## Channels
[Multi-channel memory architecture - Wikipedia](https://en.wikipedia.org/wiki/Multi-channel_memory_architecture)

[不同容量的内存混插会有什么影响？ - 知乎](https://www.zhihu.com/question/644678950)
> 如果混插内存条的频率和时序不一样，那混插后主板自己会降频找到一个频率和时序兼容的状态，这时性能肯定不是最佳。如果是对内存频率敏感的应用，那使用体验大概率会下降，如果是对内存容量需求大的应用，体验却会变好。

> 1 3槽插8G，2 4槽插16G，这样每个通道内存容量一样，性能最高
> 
> 两个通道不同容量的话，比如aG+bG，那么前2aG的容量是双通道速率，后(b-a)G的容量是单通速率。所以尽可能让a=b，这样全部都是双通速率。
> 
> 单个通道内用不同容量的没有任何影响，频率兼容就可以（当然同型号不同批次都不能兼容的这种极端情况除外）

[不同容量的内存混插对内存性能有何影响？ - 知乎](https://zhuanlan.zhihu.com/p/600029607)

## Overclocking
- XMP
- EXPO

[小白超频教程------内存篇\_内存\_什么值得买](https://post.smzdm.com/p/a25rz47n/)

[Intel XMP vs AMD Expo? : r/buildapc](https://www.reddit.com/r/buildapc/comments/1azqagy/intel_xmp_vs_amd_expo/)
> Afaik, the difference between EXPO and XMP is not just branding. Expo profile also automatically sets the speed of infinity fabric to match the ram speed, otherwise you'll have to do it manually if your AM5 board can see embedded XMP profile, too. Having both is more for the convenience of the manufacturer, so they can sell the sticks to both camps with just a little extra work.

Motherboards:
- ASUS: Nitro mode

- Gigabyte

- MSI: High-Efficiency Mode
  
  [AGESA 1.0.0.7c and MSI High-Efficiency Mode Boosts Gaming Performance by up to 12%](https://www.msi.com/blog/do-agesa-1.0.0.7c-bios-and-msi-high-efficiency-mode-improve-gaming-performance)
  > The High-Efficiency Mode from MSI is designed to optimize popular memory modules available in the market. This feature increases memory bandwidth and reduces latency. High-Efficiency Mode offers four sets of RAM timing settings: Tightest, Tighter, Balance, and Relax. This allows users to find out the optimal configuration based on the quality of their memory modules.

  [MSI Boosts Gaming Performance By Up To 12% With New "High-Efficiency" Memory Mode on AM5 Motherboards](https://wccftech.com/msi-boosts-gaming-performance-by-up-to-12-with-new-high-efficiency-memory-mode-on-am5-motherboards/) ([r/Amd](https://www.reddit.com/r/Amd/comments/15xcyre/msi_boosts_gaming_performance_by_up_to_12_with/))

  [RAM High-Efficiency Mode, Compatible with EXPO? : r/MSI\_Gaming](https://www.reddit.com/r/MSI_Gaming/comments/167l6em/ram_highefficiency_mode_compatible_with_expo/)
  > From my experience on my systems, your results will vary. It depends on your individual CPU's mem controller quality (may the silicon gods show ye favor...) and your specific DRAM kit, you may not be able to run Tightest / Tighter settings. Either system instability as you experienced or you simply can't get the EXPO speed.

  Tightest 大约能提高 7.5%，Tighter 7.1%。

  [AMD玩家的福音！微星全新推出内存高性能模式，免费获得性能提升！\_主板\_什么值得买](https://post.smzdm.com/p/apv96mz9/)

## Benchmarks
> From our testing and confirmed by the thousands of benchmarks we have collected, memory performance is highly dependent on the CPU. Less powerful CPUs may not be able to utilize the full capability of the memory modules.

- PerformanceTest: [PassMark Software - Memory Benchmark Charts](https://www.memorybenchmark.net/)
- [Benchmarks.xlsx](Benchmarks.xlsx)

[内存速度对日常使用的提升主要感受在哪里 - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2588159-1-1.html)

## Testing
- [MemTest86 - Official Site of the x86 and ARM Memory Testing Tool](https://www.memtest86.com/)
  - Kernel level

  > With 64GB DDR4 and four passes it should take around 12 hours (more or less)

  > Note that even a single error (marked in red) in MemTest86 is too much. If everything goes right a big green PASSED will appear at the end of the test. If there are any errors I recommend immediately trying to get your RAM replaced.

- TestMem5

[MemTestHelper/DDR4 OC Guide.md at oc-guide - integralfx/MemTestHelper](https://github.com/integralfx/MemTestHelper/blob/oc-guide/DDR4%20OC%20Guide.md#memory-testing-software)

[How to Test RAM: Make Sure Bad Memory Isn't Crashing Your PC | Tom's Hardware](https://www.tomshardware.com/how-to/how-to-test-ram)

[How to test/verify new budget DDR4 RAM? : r/DataHoarder](https://www.reddit.com/r/DataHoarder/comments/tip8bf/how_to_testverify_new_budget_ddr4_ram/)
