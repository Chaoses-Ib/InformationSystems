# LZMA
[Wikipedia](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Markov_chain_algorithm)

Lempel–Ziv–Markov chain algorithm

- LZ77 + Range
- Even the level 0 has a good compression ratio (> Brotli 5~9, Deflate, Zstd 15, also in compression speed) for highly compressible (30%) data

## Formats
- LZMA
- LZMA2

  [LZMA2 format](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Markov_chain_algorithm#LZMA2_format):
  > The LZMA2 container supports multiple runs of compressed LZMA data and uncompressed data. Each LZMA compressed run can have a different LZMA configuration and dictionary. This improves the compression of partially or completely incompressible files and allows multithreaded compression and multithreaded decompression by breaking the file into runs that can be compressed or decompressed independently in parallel. Criticism of LZMA2's changes over LZMA include header fields not being covered by CRCs, and parallel decompression not being possible in practice.

  - 7-Zip: LZMA2 compression, which is an improved version of LZMA, is now the default compression method for the .7z format, starting with version 9.30 on October 26, 2012.
  - [7-Zip / Discussion / Open Discussion: LZMA vs. LZMA2](https://sourceforge.net/p/sevenzip/discussion/45797/thread/2f6085ba/)

- [xz](https://tukaani.org/xz/format.html) (liblzma)
  - Supports both LZMA and LZMA2
  - Streamable
  - Random-access reading
  - Multiple filters (algorithms)

    > The filters try to improve how repetitive the encoder-input data is, since repetition compresses very well. There’s a Delta(N) encoder, which modifies every input byte by subtracting its from-N-bytes-ago byte.
    > 
    > The other filters are all BCJ(arch) filters: Branch / Call / Jump filters for specific CPU architectures like x86, SPARC and RISC-V. When a compiler (C, C++, Go, Rust, etc.) sees a while loop with multiple break statements, they all break to the same line of code but, at the machine code level, BCJ opcodes usually take a relative address. A BCJ(arch) filter just detects BCJ ops in that arch’s machine code and re-writes those (different) relative addresses as (repeated) absolute addresses. This is fiddly minutia but, again, presumably the gain in compression ratio for certain workloads was worth the extra complexity.
    
    - [Delta](https://tukaani.org/xz/xz-javadoc/org/tukaani/xz/DeltaOptions.html)

      > Currently only simple byte-wise delta is supported. The only option is the delta distance, which you should set to match your data. It's not possible to provide a generic default value for it. For example, with distance = 2 and eight-byte input A1 B1 A2 B3 A3 B5 A4 B7, the output will be A1 B1 01 02 01 02 01 02.
      > 
      > The Delta filter can be good with uncompressed bitmap images. It can also help with PCM audio, although special-purpose compressors like FLAC will give much smaller result at much better compression speed.
  - Filter chaining
  - Integrity checks
  - Concatenation
  - Padding

  [XZ/LZMA Worked Example Part 5: XZ | Nigel Tao](https://nigeltao.github.io/blog/2024/xz-lzma-part-5-xz.html)
- lzip: A simpler file format with easier error recovery
- ZIPX
- [TOA: Modern Compression with Built-in Error Correction](https://github.com/hasenbanck/toa)

## Libraries
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
          - The sweet point is 3 instead of 4 in native
          - Os
            - 9: 2.5, 2.6~3.3 MiB/s
            - 6: 2.5 MiB/s
            - 5: 3 MiB/s
            - 4: 3.9~4.4 MiB/s
            - **3**: 7.4~7.6 MiB/s
            - 2: 9.3 MiB/s
            - 1: 11 MiB/s
            - 0: 11.9~13.2 MiB/s
          - O3
            - 9: 2.5~3.5 MiB/s
            - 4: 4.4~4.7 MiB/s
            - 0: 12.5~13.7 MiB/s
  - [rust-lzma: A Rust crate that provides a simple interface for LZMA compression and decompression.](https://github.com/fpgaminer/rust-lzma)
- 7-Zip: [LZMA SDK](https://7-zip.org/sdk.html)

Rust:
- [lzma-rust2: LZMA / LZMA2 / LZIP / XZ in native Rust](https://github.com/hasenbanck/lzma-rust2/)

  > supports partial decompression and BCJ, and most importantly, it supports compression.

  - Formerly in [`sevenz-rust2`](https://github.com/hasenbanck/sevenz-rust2/tree/main/lzma-rust2)
  - [Consider using lzma-rust - Issue #200 - zip-rs/zip2](https://github.com/zip-rs/zip2/issues/200)
  
    > According to @hasenbanck's benchmark, its performance is better or at least on par with `liblzma`. And its unsafe code is optional and has `no_std` support.

    - [Use native implementation of LZMA and XZ by hasenbanck - Pull Request #405 - zip-rs/zip2](https://github.com/zip-rs/zip2/pull/405)
  - [Find a better way to implement multi-threaded decoding & encoding for LZMA2 and XZ - Issue #40](https://github.com/hasenbanck/lzma-rust2/issues/40)
  - Wasm
    - Encoder-only: 59.2 KiB
    - Performance (v0.14.2)
      - Slower than `liblzma` for levels ≥ 2 (or 4).
      - Os
        - 9: 1.8 MiB/s
        - 6: 2.1 MiB/s
        - 5: 2.9 MiB/s
        - 4: 3.4 MiB/s
        - 3: 7.4 MiB/s
        - 2: 8.7 MiB/s
        - 1: 12.3~12.6 MiB/s
        - 0: 12.8 MiB/s
    - [Parallel compression on Wasm via web workers - Issue #59](https://github.com/hasenbanck/lzma-rust2/issues/59)

- [lzma-rs: An LZMA decoder written in pure Rust](https://github.com/gendx/lzma-rs) (`lzma_rs`)

JS:
- [LZMA-JS: A JavaScript implementation of the Lempel-Ziv-Markov (LZMA) chain compression algorithm](https://github.com/LZMA-JS/LZMA-JS)
  - [Support for .xz files? - Issue #62](https://github.com/LZMA-JS/LZMA-JS/issues/62)
  - Performance
    - 9: 0.24 MiB/s
    - 4: 3.57 MiB/s
  - [biw/lzma-web: A JavaScript implementation of the Lempel-Ziv-Markov (LZMA) chain compression algorithm](https://github.com/biw/lzma-web)
  - [SortaCore/lzma2-js: JavaScript LZMA2, based on https://github.com/LZMA-JS/LZMA-JS.](https://github.com/SortaCore/lzma2-js)
- [xzwasm: XZ decompression for the browser via WebAssembly](https://github.com/SteveSanderson/xzwasm)
  - [httptoolkit/xz-decompress: XZ decompression for the browser & Node without native code, via WebAssembly](https://github.com/httptoolkit/xz-decompress)
- [Leo4815162342/lzma-purejs: Clean, fast LZMA encoder in Javascript](https://github.com/Leo4815162342/lzma-purejs)
- [js-lzma: Port of LZMA to JavaScript](https://github.com/Magister/js-lzma)

Benchmarks:
- [7-Zip Compression Benchmark - OpenBenchmarking.org](https://openbenchmarking.org/test/pts/compress-7zip-1.11.0)
