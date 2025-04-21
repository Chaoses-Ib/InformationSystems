# Compression
[Wikipedia](https://en.wikipedia.org/wiki/Data_compression)

> In information theory, data compression, source coding, or bit-rate reduction is the process of encoding information using fewer bits than the original representation. Any particular compression is either lossy or lossless. Lossless compression reduces bits by identifying and eliminating statistical redundancy. No information is lost in lossless compression. Lossy compression reduces bits by removing unnecessary or less important information.

[Lossless compression - Wikipedia](https://en.wikipedia.org/wiki/Lossless_compression)

[Data Compression - Wikibooks, open books for an open world](https://en.wikibooks.org/wiki/Data_Compression)

[Compression - facebook/rocksdb Wiki](https://github.com/facebook/rocksdb/wiki/Compression)

[Content-Encoding - HTTP | MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Encoding)

## Duplicate elimination
- Inner duplicate elimination: compression
- Cross duplicate elimination
  - Identical duplicate elimination: data deduplication ([Wikipedia](https://en.wikipedia.org/wiki/Data_deduplication))
    - [→Hash functions](https://github.com/Chaoses-Ib/Cryptology#hash-functions)
  - [Differential compression](Diff/README.md)

## Benchmarks
ZPAQ > LZMA > Brotli > Zstandard > Deflate > CSC > lzham > LZ4 > lzo > Snappy

[Squash Compression Benchmark](https://quixdb.github.io/squash-benchmark/)
- DLL, i3-2105: ZPAQ > CSC > LZMA > lzham > Brotli > BZip2 > Defalte, Zstd?

[TurboBench: Compression Benchmark](https://github.com/powturbo/TurboBench)
- Incremental results
- `-elzma,0,1,2,3,4,5,6,7,8,9`
- `-ebrotli,4,5,6,7,8,9,10,11`
- `-ezstd,9,10,11,12,13,14,15,16,17,18,19,20,21,22`
- [feat: add TurboBench benchmarks - 16Hexa/pdbg-tests@99146d6](https://github.com/16Hexa/pdbg-tests/commit/99146d6a0b20d6b476960ed86d72f577406e56f5)

[Compression Analysis Tool | Noemax](https://www.noemax.com/free-tools/compression-analysis-tool.asp)

[Maximum file compression benchmark 7Z ARC ZIPX versus RAR](https://peazip.github.io/maximum-compression-benchmark.html)
- ZPAQ is clearly the top performing format in this benchmark focused on maximum attainable compression.
- ZPAQ and ARC are the best compressors, but 7Z and RAR formats has a clear advantage in terms of decompression speed, faster than for any other tested format.
- 7Z outperformed RAR in terms of compression ratio at all compression levels, but RAR outperformed 7Z in terms of compression speed.
- Brotli and Zstd can provide surprisingly good compression ratios, even if they are designed primarily for fast compression tasks, with Zstandard being overall the best choice.

[Choosing Between gzip, Brotli and zStandard Compression | Paul Calvano](https://paulcalvano.com/2024-03-19-choosing-between-gzip-brotli-and-zstandard-compression/)

Discussions:
- 2023-10 [What file compression format/algorithm has the best compression ratios (mainly for binary files of various types)? Compression and decompression time is irrelevant as this is for cold storage, and I have 36 GB of RAM. : r/DataHoarder](https://www.reddit.com/r/DataHoarder/comments/17cdnsu/what_file_compression_formatalgorithm_has_the/)

  > The best relatively accessible ones are 7zip if you also want compatibility or zpaq if you invest a bit more compute and sacrifice compatibility a bit.

  > LZMA-based formats are some of the most efficient - this includes 7zip and xz.

- 2024-11 [Announcing Faster, Lighter Firefox Downloads for Linux with .tar.xz Packaging! -- Firefox Nightly News](https://blog.nightly.mozilla.org/2024/11/28/announcing-faster-lighter-firefox-downloads-for-linux-with-tar-xz-packaging/)

## Dictionary type
### Lempel–Ziv (LZ77 and LZ78)
[Wikipedia](https://en.wikipedia.org/wiki/LZ77_and_LZ78)

> We believe LZ4 is almost always better than Snappy. LZ4/Snappy is a lightweight compression algorithm so it usually strikes a good balance between space and CPU usage.

#### Snappy
[Wikipedia](https://en.wikipedia.org/wiki/Snappy_(compression))

Rust:
- [rust-snappy: Snappy compression implemented in Rust (including the Snappy frame format).](https://github.com/burntsushi/rust-snappy)

#### LZ4
C++:
- [lz4: Extremely Fast Compression algorithm](https://github.com/lz4/lz4)

  Rust: [lz4-rs: Rust LZ4 bindings](https://github.com/10xGenomics/lz4-rs)

Rust:
- [lz4\_flex: Fastest pure Rust implementation of LZ4 compression/decompression.](https://github.com/PSeitz/lz4_flex)

## Hybrid
> If you want to further reduce space and have some free CPU to use, ... We recommend ZSTD. If it is not available, Zlib is the second choice.

### LZ77 + Huffman: Deflate
[Wikipedia](https://en.wikipedia.org/wiki/Deflate)

C++:
- [zlib: A massively spiffy yet delicately unobtrusive compression library.](https://github.com/madler/zlib)
- [zlib-ng: zlib replacement with optimizations for "next generation" systems.](https://github.com/zlib-ng/zlib-ng)
  - [zlib-ng/pigzbench: Test of parallel compression acceleration](https://github.com/zlib-ng/pigzbench)

  [2.0.0 Benchmark comparisons - zlib-ng/zlib-ng - Discussion #871](https://github.com/zlib-ng/zlib-ng/discussions/871)
  > Zlib-ng compression beats both hands down on speed. Zlib-ng is about 4x faster than zlib (w/zlib-ng minigzip), and 2.1x faster than stock gzip from my Scientific Linux 7.
  > 
  > Zlib-ng decompression takes about 57% less time than zlib (w/zlib-ng minigzip), and 43% less time than gzip.
  > 
  > Zlib-ng loses a little on compressed size (due to 4-byte minimum match size instead of 3-byte). Level 6 zlib-ng loses with 41.038% vs 40.813% compressed size for gzip. Level 9 has 40.696% vs 40.549%.

  > Our research with RocksDB and Zlib-ng shows that there is ~50% less throughput and ~45% latency increase in Zlib-ng vs Zstandard. Also not much difference observed in Compression ratios.

Rust:
- [rust-lang/flate2-rs: DEFLATE, gzip, and zlib bindings for Rust](https://github.com/rust-lang/flate2-rs)
  - > FLATE, Gzip, and Zlib bindings for Rust - can use miniz_oxide for a pure Rust implementation.
  - Supported formats: deflate, zlib, gzip
  - Backends: `miniz_oxide`, `zlib-rs`, `zlib-ng`, `cloudflare_zlib`
    - [Change default backend to `zlib-rs` instead - Issue #469 - rust-lang/flate2-rs](https://github.com/rust-lang/flate2-rs/issues/469)

    > zlib-rs (and zlib-ng) trades some compression ratio for speed so it doesn't compress as well as standard zlib and miniz\_oxide. This may or may not be desirable depending on application so it's somthing that has to be considered. When testing `cloudflare-zlib` it seemed like it was somewhere inbetween zlib and zlib-ng/zlib-rs on compression ratio and speed so maybe does some speed/ratio tradeoffs but not all (zlib and miniz/miniz\_oxide also has some slight differences in compression ratio characteristics but that's more a small variance that can go slightly either way due to slight difference in implementation rather than better/worse).
- [zlib-rs: A safer zlib](https://github.com/trifectatechfoundation/zlib-rs)
  - [zlib-rs benchmark dashboard](https://trifectatechfoundation.github.io/zlib-rs-bench/)
  - [stop using custom wasm simd for `slide_hash` by folkertdev - Pull Request #343](https://github.com/trifectatechfoundation/zlib-rs/pull/343)

  [Current zlib-rs performance - Blog - Tweede golf](https://tweedegolf.nl/en/blog/134/current-zlib-rs-performance)

  [zlib-rs is faster than C - Trifecta Tech Foundation](https://trifectatech.org/blog/zlib-rs-is-faster-than-c/)
  - [Rust can be faster than C](https://xuanwo.io/links/2025/02/rust_can_be_faster_than_c/)

  [Switch to more performant, 100% Rust zlib by brainstorm - Pull Request #331 - zaeleus/noodles](https://github.com/zaeleus/noodles/pull/331)
- [miniz\_oxide: Rust replacement for miniz](https://github.com/Frommi/miniz_oxide)
- [deflate-rs: An implementation of a DEFLATE encoder in rust](https://github.com/image-rs/deflate-rs) (discontinued)
- [Zopfli: A Rust implementation of the Zopfli compression algorithm.](https://github.com/zopfli-rs/zopfli)
- [deflate64-rs: Derflate64 implementation in rust based on .NET's implementation](https://github.com/anatawa12/deflate64-rs)
- [flate3](https://docs.rs/flate3/latest/flate3/)

  > It should compress slightly better than flate2. It uses multiple threads to compress faster.

### LZ77 + Huffman + context: Brotli
[Wikipedia](https://en.wikipedia.org/wiki/Brotli)

C++:
- [google/brotli: Brotli compression format](https://github.com/google/brotli)

  Rust: [brotlic: Bindings to the brotli library featuring a low-overhead encoder and decoder, Writers and Readers for compression and decompression at customizable compression qualities and window sizes.](https://github.com/AronParker/brotlic)

Rust:
- [dropbox/rust-brotli: Brotli compressor and decompressor written in rust that optionally avoids the stdlib](https://github.com/dropbox/rust-brotli)
  - [Multithreaded compression - Issue #96](https://github.com/dropbox/rust-brotli/issues/96)

  [Lossless compression with Brotli in Rust for a bit of Pied Piper on the backend - Dropbox](https://dropbox.tech/infrastructure/lossless-compression-with-brotli)
  > Activating unsafe mode results in another gain, bringing the total speed up to 249MB/s, bringing Brotli to within 82% of the C code.
  - `unsafe` feature has been removed?

    [add a feature flag unsafe that avoids unnecessary array bounds checks - dropbox/rust-brotli@412e8c0](https://github.com/dropbox/rust-brotli/commit/412e8c0332ec31c3583a8c589564afc59c453bb6)

  Wasm:
  - [brotli-wasm: A reliable compressor and decompressor for Brotli, supporting node & browsers via wasm](https://github.com/httptoolkit/brotli-wasm)
  - [brotli-dec-wasm: Brotli decompressor for browsers and web workers with WASM, but still having a small size (about 200KB)](https://github.com/ustclug-dev/brotli-dec-wasm)
  - [wasm-brotli: 🗜 WebAssembly compiled Brotli library](https://github.com/dfrankland/wasm-brotli)

    > requires a custom async wrapper for Webpack v4 usage and isn't usable at all in Webpack v5. Last updated in 2019.
- [brotli-rs: A Brotli implementation in pure and safe Rust](https://github.com/ende76/brotli-rs) (discontinued)

### LZ77 + Huffman + ANS: [Zstandard](https://facebook.github.io/zstd/)
[Wikipedia](https://en.wikipedia.org/wiki/Zstd)

C++:
- [zstd: Zstandard - Fast real-time compression algorithm](https://github.com/facebook/zstd)

  Rust: [zstd-rs: A rust binding for the zstd compression library.](https://github.com/gyscos/zstd-rs) (`zstd`, `zstd_safe`)
  - [Documentation for WASM? - Issue #93](https://github.com/gyscos/zstd-rs/issues/93)

Rust:
- [KillingSpark/zstd-rs: zstd format implementation in pure rust](https://github.com/KillingSpark/zstd-rs)

  > This crate contains a fully operational implementation of the decompression portion of the standard. It also provides a compressor which is usable, but it does not yet reach the speed, ratio or configurability of the original zstd library.

JS:
- Wasm
  - [zstd-codec: Zstandard codec for Node.js and Web, powered by Emscripten](https://github.com/yoshihitoh/zstd-codec)
  - [zstd-wasm: Zstandard for browser, Node.js and Deno](https://github.com/bokuweb/zstd-wasm)
  - [zstd-js](https://github.com/OneIdentity/zstd-js)
- [fzstd: High performance Zstandard decompression in a pure JavaScript, 8kB package](https://github.com/101arrowz/fzstd)

  > WebAssembly ports of Zstandard are usually significantly (30-40%) faster than `fzstd`
- Native
  - [mongodb-js/zstd: A Zstd Compression Library](https://github.com/mongodb-js/zstd)

### LZ77 + Range: LZMA
[Wikipedia](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Markov_chain_algorithm)

Lempel–Ziv–Markov chain algorithm

- Even the level 0 has a good compression ratio (> Brotli 5~9, Deflate, Zstd 15, also in compression speed) for highly compressible (30%) data

C++:
- [XZ Utils](https://github.com/tukaani-project/xz): liblzma
  - Performance
    - 9: 5.6~7.7 MB/s
    - 4: 25.3~28.9 MB/s
    - 0: 51~55 MB/s
  
  Rust:
  - [xz2-rs: Bindings to liblzma in Rust (xz streams in Rust)](https://github.com/alexcrichton/xz2-rs) (discontinued)
    - [liblzma-rs: Bindings to liblzma in Rust (xz streams in Rust)](https://github.com/portable-network-archive/liblzma-rs)
      - Require Clang
      - [☂️ WebAssembly Support - Issue #15](https://github.com/Portable-Network-Archive/liblzma-rs/issues/15)
        - Binary size
          - 97 KiB (`thin-lto` < no lto < `fat-lto`)
          - Encoder-only: 69 KiB
          - Decoder-only: 57 KiB
        - Performance: ~20% of native (x86-64)
          - Os
            - 9: 2.6~3.3 MiB/s
            - 4: 3.9~4.4 MiB/s
            - 0: 11.9~13.2 MiB/s
          - O3
            - 9: 2.5~3.5 MiB/s
            - 4: 4.4~4.7 MiB/s
            - 0: 12.5~13.7 MiB/s
  - [rust-lzma: A Rust crate that provides a simple interface for LZMA compression and decompression.](https://github.com/fpgaminer/rust-lzma)
- 7-Zip: [LZMA SDK](https://7-zip.org/sdk.html)

Rust:
- [lzma-rs: An LZMA decoder written in pure Rust](https://github.com/gendx/lzma-rs) (`lzma_rs`)
- [sevenz-rust2/lzma-rust2](https://github.com/hasenbanck/sevenz-rust2/tree/main/lzma-rust2) (`lzma-rust2`)

  > supports partial decompression and BCJ, and most importantly, it supports compression.

  [Consider using lzma-rust - Issue #200](https://github.com/zip-rs/zip2/issues/200)

JS:
- [LZMA-JS: A JavaScript implementation of the Lempel-Ziv-Markov (LZMA) chain compression algorithm](https://github.com/LZMA-JS/LZMA-JS)
  - Performance
    - 9: 0.24 MiB/s
    - 4: 3.57 MiB/s
  - [biw/lzma-web: A JavaScript implementation of the Lempel-Ziv-Markov (LZMA) chain compression algorithm](https://github.com/biw/lzma-web)
- [Leo4815162342/lzma-purejs: Clean, fast LZMA encoder in Javascript](https://github.com/Leo4815162342/lzma-purejs)
- [js-lzma: Port of LZMA to JavaScript](https://github.com/Magister/js-lzma)

[LZMA2 format](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Markov_chain_algorithm#LZMA2_format):
> The LZMA2 container supports multiple runs of compressed LZMA data and uncompressed data. Each LZMA compressed run can have a different LZMA configuration and dictionary. This improves the compression of partially or completely incompressible files and allows multithreaded compression and multithreaded decompression by breaking the file into runs that can be compressed or decompressed independently in parallel. Criticism of LZMA2's changes over LZMA include header fields not being covered by CRCs, and parallel decompression not being possible in practice.

- 7-Zip: LZMA2 compression, which is an improved version of LZMA, is now the default compression method for the .7z format, starting with version 9.30 on October 26, 2012.
- [7-Zip / Discussion / Open Discussion: LZMA vs. LZMA2](https://sourceforge.net/p/sevenzip/discussion/45797/thread/2f6085ba/)

Benchmarks:
- [7-Zip Compression Benchmark - OpenBenchmarking.org](https://openbenchmarking.org/test/pts/compress-7zip-1.11.0)

### LZ77: [CSC](https://github.com/fusiyuan2010/CSC)

### LZ77 + BWT + content mixing: [ZPAQ](https://www.mattmahoney.net/dc/zpaq.html)
[Wikipedia](https://en.wikipedia.org/wiki/ZPAQ)

### RLE + BWT + MTF + Huffman: bzip2
[Wikipedia](https://en.wikipedia.org/wiki/Bzip2)

> The only reason to use bzip2 for “general purpose” compression is if you have to use bzip2 because an upstream mandates it, bzip2 has not been a good general purpose compression format since LZMA appeared: LZMA will always beat bzip2 in decompression speed, and will generally beat its compression ratio at any given CPU time, bzip2 only beats LZMA on memory use (especially on compression, but also decompression for very high LZMA modes). Bzip2 can be superior for specific data patterns which happen to fit BWT, but the odds are low.

C++:
- libbz2

  Rust: [bzip2-rs: libbz2 (bzip2 compression) bindings for Rust](https://github.com/trifectatechfoundation/bzip2-rs)

Rust:
- [paolobarbolini/bzip2-rs: Pure Rust bzip2 decoder](https://github.com/paolobarbolini/bzip2-rs) (`bzip2_rs`)

### [bzip3](https://github.com/kspalaiologos/bzip3)
> A better, faster and stronger spiritual successor to BZip2. Features higher compression ratios and better performance thanks to a order-0 context mixing entropy coder, a fast Burrows-Wheeler transform code making use of suffix arrays and a RLE with Lempel Ziv+Prediction pass based on LZ77-style string matching and PPM-style context modeling.
>
> Like its ancestor, BZip3 excels at compressing text or code.

### Density
[density: Superfast compression library](https://github.com/g1mv/density)

## Libraries
C++:
- [squash: Compression abstraction library and utilities](https://github.com/quixdb/squash)

Rust:
- [async-compression: Adaptors between compression crates and Rust's async IO types](https://github.com/Nullus157/async-compression)
- [comde: Compression/decompression crate akin to serde](https://github.com/bbqsrc/comde)

[pure rust decompression libraries? : r/rust](https://www.reddit.com/r/rust/comments/1d8j5br/pure_rust_decompression_libraries/)

## Shared dictionaries
“黑压缩”

[Compression Dictionary Transport](https://datatracker.ietf.org/doc/html/draft-ietf-httpbis-compression-dictionary)

## Solid compression
[Wikipedia](https://en.wikipedia.org/wiki/Solid_compression)

> Solid compression is a method for data compression of multiple files, wherein all the uncompressed files are concatenated and treated as a single data block. Such an archive is called a solid archive.

> It is used natively in the 7z and RAR formats, as well as indirectly in tar-based formats such as `.tar.gz` and `.tar.bz2`. By contrast, the ZIP format is not solid because it stores separately compressed files (though solid compression can be emulated for small archives by combining the files into an uncompressed archive file and then compressing that archive file inside a second compressed ZIP file).

## Cryptography
> Cryptosystems often compress data (the "plaintext") before encryption for added security. When properly implemented, compression greatly increases the unicity distance by removing patterns that might facilitate cryptanalysis. However, many ordinary lossless compression algorithms produce headers, wrappers, tables, or other predictable output that might instead make cryptanalysis easier. Thus, cryptosystems must utilize compression algorithms whose output does not contain these predictable patterns.