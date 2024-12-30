# DDR5 SDRAM
[Wikipedia](https://en.wikipedia.org/wiki/DDR5_SDRAM)

## Frequency
[Why ddr5 has such a high timings, but still considered "faster" than ddr4? : r/buildapc](https://www.reddit.com/r/buildapc/comments/17do3fr/why_ddr5_has_such_a_high_timings_but_still/)
> `(2000*CL) / freq = latency nanoseconds`
>
> For ryzen 7000, which is a ddr5 platform, 6000mhz is the desired speed, and cl30 is the same effective speed as 3600 cl18. However, you wont notice the difference between 6000mhz cl30 and 6000mhz cl36 so go for cheapest. For intel, your motherboard will dictate ddr4 or ddr5, although ddr5 is where you should be aiming.

[RAM frequency vs. latency: What matters more?](https://www.xda-developers.com/ram-frequency-vs-latency/)
> While we've seen RAM frequency affect memory performance much more than latency, you need to strike a balance between the two when buying a memory kit. If you simply want a great kit for gaming alone, a DDR5-6000 CL30 kit is the sweet spot. And if you're looking for a productivity-focused kit, you can consider faster speeds — 6400MT/s to 8000MT/s — based on your budget and platform.

[What is current sweetspot for DDR5 | TechPowerUp Forums](https://www.techpowerup.com/forums/threads/what-is-current-sweetspot-for-ddr5.323553/)


[知之实验室 篇十五：真-战未来！高频DDR5内存到底有多大性能优势？\_CPU\_什么值得买](https://post.smzdm.com/p/a4pd4zex/)
> 高频内存到底能带来什么收益？目前来看主要还是在游戏上。生产力上虽然高带宽也可以带来明显的提升，但是对于生产力来说容量更重要，而目前两家CPU的内存控制器在面对4根2DPC的满配内存的时候，频率都基本上不去

[低频内存对游戏性能有多大影响？ - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://chiphell.com/forum.php?mod=viewthread&tid=2491504)

[DDR5的频率差距在实际应用游戏中很大吗 - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2504266-1-1.html)
> 简单来说因为在支持gsync的显示器上最低延迟帧率实际上差不多是显示器帧率的95%左右，所以对于目前主流的2k@240hz的电竞显示器来说，常见内存频率并不足以成为瓶颈，5600和7200不会有任何区别，而对于4K屏来说因为现有主流产品所支持的最高帧率更低，内存也不会成为瓶颈。至于3A，因为瓶颈主要在显卡和CPU上所以内存频率的区别会更小。

> 超多核并行以及高性能核显才需要越大的带宽，以前游戏U超内存大部分是为了延迟低，每个周期能从RAM里拿到更多的数据。当L3足够大的时候，延迟就不重要了。DDR5时序天生宽，缩时序比拉高频率效果会更好。  
> 倒不如说，目前的超高频率DDR5风气挺奇怪的，毕竟现在这几个DDR5平台压根没有很强的核显，把内存超上去边际收益太小了，还要承担不稳定的风险。

[ddr5虽然频率一直在提高 但游戏帧数提升感觉没想象的大 178](https://nga.178.com/read.php?tid=38218375&rand=691)

[为什么 DDR5 对 CPU 性能影响几乎不计价格还那么高？ - 知乎](https://www.zhihu.com/question/508403746)
> 性能而言，目前的顶级ddr5，超到6400压时序，可以做到游戏略超或持平ddr4 4200 c15了，而内存带宽100GB/S强了40%。
> 
> 你觉得ddr5不比ddr4强是因为媒体都在拿ddr4 3600+ c16 gear1和ddr5 4800-5600gear2对比游戏好像ddr5没啥提升甚至倒退，如果对比adobe ansys这些吃内存带宽的应用，ddr5的提升是很明显的。

[别只看频率，时序同样重要，七彩虹战斧赤焰DDR5内存实测\_内存\_什么值得买](https://post.smzdm.com/p/arqk9w2g/)

[DDR5内存时序和频率哪个重要？ - ＰＣ数码 - Stage1st - stage1/s1 游戏动漫论坛](https://www.saraba1st.com/2b/thread-2187858-1-1.html)

## CPU
### AMD
[AMD 9000系内存怎么选？同频OR分频？阿斯加特吹雪DDR5内存实测\_CPU\_什么值得买](https://post.smzdm.com/p/a7pkd7z9/)
> 新的AMD 9000系列CPU搭配B650主板，6000MHz依旧是甜点频率，在6000MHz频率下可以尽量缩小时序以获取性能提升。在分频模式下，超频到7600频率以上也能获得不错的内存性能。

[AMD Confirms DDR5-6000 RAM Is The Sweet Spot For Ryzen 7000 CPUs | Tom's Hardware](https://www.tomshardware.com/news/amd-confirms-ddr5-6000-ram-is-the-sweet-spot-for-ryzen-7000-cpus)

[AM5现在到底用什么内存？(16G\*2) 178](https://nga.178.com/read.php?tid=38095995&rand=470)

[ZEN4内存的最佳频率是6000吗？ - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2494900-1-1.html)
> 一半以上可以6400，少数可以6600
>
> 2100FCLK 6000-6200都比较轻松，6400就真的要看RP了

[AMD的AM5平台最高频率只能支持到6400么？ - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2511903-1-1.html)
> io带宽问题，超过6400读写速度基本没提升，还不如6400内尽可能压小参

> A的桌面平台IOD跟CCD分离，内存控制器在IOD上，计算内核在CCD上，两者的连接靠的infinity fabric总线，这个总线的频率和带宽决定了内存的有效带宽。I家的内存控制器和计算内核都在同一个DIE上，内存控制器也可以上到更高频率，所以I的内存频率可以更高也好理解。
> 
> A的桌面平台和服务器/工作站平台的架构相同，是后者的简化版本，所以保留了IOD和CCD分离的做法。I的桌面平台和服务器平台架构不完全相同，但都是多个内核整合成一个DIE。这个差别，导致A家的服务器平台效率更高，桌面平台性能却难以最大化；I家的服务器平台效率低，但桌面平台的性能却能做到极致。

[现阶段 am5 内存兼容性 - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2642845-1-1.html)

[AMD平台的D5内存，用Adie还是Mdie有区别吗 NGA玩家社区](https://bbs.nga.cn/read.php?tid=41497630&rand=306)

[AM5平台内存性能真挺拉 - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2631379-1-1.html)

[AMD Ryzen 9000X3D系列将完全开放超频， DDR5-6400是Zen 5内存"甜点"频率 - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/thread-2617314-1-1.html)

[锐龙9000处理器内存需求测试：寻找最合适的甜点频率\_Trident\_皇家](https://www.sohu.com/a/802862316_121948415)

[新BIOS加持，锐龙97950X高频DDR5内存随心玩！ | 机核 GCORES](https://www.gcores.com/articles/170796)

## Brands
- 金百达

  连号内存，一条开 EXPO 都正常，另一条插上就过不了 MSI B650M 自检。

  [求救，新机器装好后dram灯常亮... NGA玩家社区](https://bbs.nga.cn/read.php?tid=38449265&page=e&forder_by=postdatedesc&rand=27)

  [PRO B650M-P 主板+金百达内存无法重启 | MSI中国大陆区客户论坛](https://forum-sc.msi.cn/index.php?threads/pro-b650m-p-%E4%B8%BB%E6%9D%BF-%E9%87%91%E7%99%BE%E8%BE%BE%E5%86%85%E5%AD%98%E6%97%A0%E6%B3%95%E9%87%8D%E5%90%AF.58320/)

  [问一下，微星b650m迫击炮兼容金百达d5 6000或者6400的内存条吗 178](https://nga.178.com/read.php?tid=38366152&rand=813)

  [\[兼容性讨论\]热门的金百达内存与技嘉主板的兼容性问题 178](https://nga.178.com/read.php?tid=38056840&rand=726)

  [金百达内存和微星主板还是有点兼容问题 - 电脑讨论(新) - Chiphell - 分享与交流用户体验](https://www.chiphell.com/forum.php?mod=viewthread&tid=2483078&extra=page%3D1&mobile=no)

  [\[已解决\]微星是不是跟金百达的内存不兼容啊... NGA玩家社区](https://bbs.nga.cn/read.php?tid=37456513&rand=952)
  > 主要是微星那边的问题，这代的D5板子兼容性太差，D4的就基本没这问题  
  > 尤其是金百达的内存，6400和6800的一般都会出事，想要稳定运行只能降到6000

  [微星主板不支持金百达内存条 NGA玩家社区](https://ngabbs.com/read.php?tid=35335611&rand=768)
  > 更新下bios，微星插金百达能不能点亮确实看运气

- 新乐士
  
  [在差异化中追求更高性价比 新乐士狂刃战士内存使用体验\_内存\_什么值得买](https://post.smzdm.com/p/allgzn7g/)

- 光威

  [b650m小雕，天策6400，c32 adie，卡DRAM灯 178](https://nga.178.com/read.php?tid=38773159&rand=57)

[D5内存6000、6800、7200怎么选？同频率不同时序的体质差异！点赞收藏附内存性价比推荐表\_台式机内存\_什么值得买](https://post.smzdm.com/p/axzql8ww/)

[实测告诉你DDR5内存怎么选，海力士Mdie、Adie和三星Bdie到底哪个香\_台式机内存\_什么值得买](https://post.smzdm.com/p/apv963zx/)