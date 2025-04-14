# Differential Compression
[Wikipedia](https://en.wikipedia.org/wiki/Data_differencing)

Differential compression, data differencing

Data differencing is another form of compression. It utilizes duplicate elimination too, but use a different file as the source of the dict.

> In computer science and information theory, data differencing or differential compression is producing a technical description of the difference between two sets of data – a source and a target. Formally, a data differencing algorithm takes as input source data and target data, and produces difference data such that given the source data and the difference data, one can reconstruct the target data ("patching" the source with the difference to produce the target).

[File comparison - Wikipedia](https://en.wikipedia.org/wiki/File_comparison)

[Awesome-Binary-Similarity: An awesome & curated list of binary code similarity papers](https://github.com/SystemSecurityStorm/Awesome-Binary-Similarity)

## Algorithms
- Naive

  [ethteck/bdiff: A binary diffing tool](https://github.com/ethteck/bdiff)

- Exediff[^bakerCompressingDifferencesExecutable1999]
  - COFF
  - Different strategies for different sections

  Implementations:
  - [0day1day/bap: Binary Analysis Platform](https://github.com/0day1day/bap)

- BSDiff[^percivalNaiveDifferencesExecutable2003]
  - Worse performance than Exediff, but format independent
  - Quite memory-hungry. It requires $max(17*n,9*n+m)+O(1)$ bytes of memory, where $n$ is the size of the old file and $m$ is the size of the new file. **bspatch** requires $n+m+O(1)$ bytes.
  - Runs in $O((n+m) log n)$ time

  [Binary diff](https://www.daemonology.net/bsdiff/)

  Implementations:
  - C: [mendsley/bsdiff: bsdiff and bspatch are libraries for building and applying patches to binary files.](https://github.com/mendsley/bsdiff)
  - Rust: [space-wizards/bsdiff-rs: Binary diffing algorithm implemented in Rust](https://github.com/space-wizards/bsdiff-rs)
    - No dependencies

  [aehobak: Like zucchini but grown in Korea](https://github.com/barrbrain/aehobak)
  - LZ4-compressed aehobak patches yield a median reduction of 74.9%

- [bidiff: A Rust take on bsdiff](https://github.com/divvun/bidiff)

  > `bidiff` generates patches of similar size compared to `bsdiff`, but is generally faster and requires less memory, thanks to the following changes.
  - Optimized suffix sorting
  - Chunking

    > Note that dividing the newer file into chunks also contributes to generating very slightly worse patch files: cross-chunk matches will result in two ADD operations, where they would only be one before. However, in practice, the difference is negligible.

  - Patch format is not compatible with bspatch: [Compatiblity with bspatch - Issue #10](https://github.com/divvun/bidiff/issues/10)
  - [Can LZMA/LZMA2 support be added to the demo app? - Issue #9](https://github.com/divvun/bidiff/issues/9)

- Wavefront alignment (WFA)

  Implementaions:
  - [smarco/WFA2-lib: WFA-lib: Wavefront alignment algorithm library v2](https://github.com/smarco/WFA2-lib)
  - Rust: [8051Enthusiast/biodiff: Hex diff viewer using alignment algorithms from biology](https://github.com/8051Enthusiast/biodiff)

- Myers’ diff

  Implementations:
  - [diff-match-patch-rs: A very fast, accurate and wasm ready port of Diff Match Patch in Rust. The diff implementation is based on Myers' diff algorithm.](https://github.com/AnubhabB/diff-match-patch-rs)
  - [imara-diff: Reliably performant diffing](https://github.com/pascalkuthe/imara-diff)
  - [diffs - Rust](https://docs.rs/diffs/latest/diffs/)

- Patience diff

  Implementations:
  - [imara-diff: Reliably performant diffing](https://github.com/pascalkuthe/imara-diff)
  - [diffs - Rust](https://docs.rs/diffs/latest/diffs/)

- [JojoDiff - diff utility for binary files](https://jojodiff.sourceforge.net/)

  [francisdb/jojodiff-rs: Rust library for working with JojoDiff files](https://github.com/francisdb/jojodiff-rs)


[^bakerCompressingDifferencesExecutable1999]: Baker, B. S., Manber, U., & Muth, R. (1999). Compressing Differences of Executable Code.
[^percivalNaiveDifferencesExecutable2003]: Percival, C. (2003). Naı¨ve Differences of Executable Code.
