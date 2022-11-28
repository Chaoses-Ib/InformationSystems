# [libmdbx](https://erthink.github.io/libmdbx/)
[GitFlic](https://gitflic.ru/project/erthink/libmdbx), ~~[GitHub](https://github.com/erthink/libmdbx)~~

libmdbx 是 LMDB 的一个分支，由作者 erthink 一人维护。根据[作者说明](https://gitflic.ru/project/erthink/libmdbx/file#improvements-beyond-lmdb)，libmdbx 相比 LMDB 主要做了以下改进：
- 将 key size 的最大限制从 511 字节提高到了 2022 字节。
- 性能相比 LMDB 提高 10~30%。
- 能够自动调整数据库容量，包括自动增大和自动缩小。
- 降低某些场景下的内存占用和写入量。
- 修复部分 bug。

但 LMDB 的主要开发者 [Howard Chu 声称](https://twitter.com/hyc_symas/status/1008627818182344704) libmdbx 的性能在他的测试中要远低于 LMDB，并在两年半后[再次指出](https://twitter.com/hyc_symas/status/1317510080779161600)，libmdbx 的性能是在关闭数据库容量自动调整后测得的，否则性能会比 LMDB 更低；并认为 libmdbx 声称的改进是在重走他们走过的弯路，不值得他回应。

libmdbx 的作者 erthink 在 2022 年四月疑似因为俄罗斯国籍而被 GitHub take down 了所有仓库，随后作者在仓库恢复后 archive 了所有 GitHub 仓库，并将 libmdbx 的仓库迁移到了俄罗斯网站 GitFlic 上：[erthink/libmdbx](https://gitflic.ru/project/erthink/libmdbx)。但在迁移之后，作者就开始使用俄语编写代码 comment、changelog 和 commit message 了，只有 README 目前仍然是英文的。

综上，尽管 libmdbx 声称拥有更高的性能，但它的维护状况令人担忧，文档也很匮乏，对于生产场景来说并不是一个好选择。

[Criteria for transitioning from Alpha to Beta · ledgerwatch/erigon Wiki](https://github.com/ledgerwatch/erigon/wiki/Criteria-for-transitioning-from-Alpha-to-Beta#switch-from-lmdb-to-mdbx)

## Bindings
Rust：
- ~~heed~~

  由于[多种原因](https://github.com/meilisearch/heed/pull/125)，heed 已于 2022 年五月移除了对 libmdbx 的支持，并且之前的版本也不支持在 Windows 上构建。
- [libmdbx-rs](https://github.com/vorot93/libmdbx-rs)

  [Documentation](https://docs.rs/libmdbx)

  libmdbx-rs 是 libmdbx 目前使用量最多的 Rust binding，但它的最新版本（v0.1.11）甚至无法通过编译，会产生 10 处 error。