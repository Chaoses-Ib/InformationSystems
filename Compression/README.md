# Compression
[Wikipedia](https://en.wikipedia.org/wiki/Data_compression)

> In information theory, data compression, source coding, or bit-rate reduction is the process of encoding information using fewer bits than the original representation. Any particular compression is either lossy or lossless. Lossless compression reduces bits by identifying and eliminating statistical redundancy. No information is lost in lossless compression. Lossy compression reduces bits by removing unnecessary or less important information.

[Lossless compression - Wikipedia](https://en.wikipedia.org/wiki/Lossless_compression)

[Data Compression - Wikibooks, open books for an open world](https://en.wikibooks.org/wiki/Data_Compression)

[Compression - facebook/rocksdb Wiki](https://github.com/facebook/rocksdb/wiki/Compression)

Libraries:
- [squash: Compression abstraction library and utilities](https://github.com/quixdb/squash)
- Rust
  - [comde: Compression/decompression crate akin to serde](https://github.com/bbqsrc/comde/tree/master)

## Duplicate elimination
- Inner duplicate elimination: compression
- Cross duplicate elimination
  - Identical duplicate elimination: data deduplication ([Wikipedia](https://en.wikipedia.org/wiki/Data_deduplication))
    - [→Hash functions](https://github.com/Chaoses-Ib/Cryptology#hash-functions)
  - [Differential compression](Diff/README.md)

## Benchmarks
[Squash Compression Benchmark](https://quixdb.github.io/squash-benchmark/)

[TurboBench: Compression Benchmark](https://github.com/powturbo/TurboBench)

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

#### LZ4
C++:
- [lz4: Extremely Fast Compression algorithm](https://github.com/lz4/lz4)

  Rust: [lz4-rs: Rust LZ4 bindings](https://github.com/10xGenomics/lz4-rs)

## Hybrid
> If you want to further reduce space and have some free CPU to use, ... We recommend ZSTD. If it is not available, Zlib is the second choice.

### LZ77 + Huffman: Deflate
[Wikipedia](https://en.wikipedia.org/wiki/Deflate)

### LZ77 + Huffman + context: Brotli
[Wikipedia](https://en.wikipedia.org/wiki/Brotli)

### LZ77 + Huffman + ANS: Zstandard
[Wikipedia](https://en.wikipedia.org/wiki/Zstd)

C++:
- [zstd: Zstandard - Fast real-time compression algorithm](https://github.com/facebook/zstd)

  Rust: [zstd-rs: A rust binding for the zstd compression library.](https://github.com/gyscos/zstd-rs)

### LZ77 + Range: LZMA
[Wikipedia](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Markov_chain_algorithm)

Lempel–Ziv–Markov chain algorithm

- liblzma
  
  Rust: [rust-lzma: A Rust crate that provides a simple interface for LZMA compression and decompression.](https://github.com/fpgaminer/rust-lzma)

[LZMA2 format](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Markov_chain_algorithm#LZMA2_format):
> The LZMA2 container supports multiple runs of compressed LZMA data and uncompressed data. Each LZMA compressed run can have a different LZMA configuration and dictionary. This improves the compression of partially or completely incompressible files and allows multithreaded compression and multithreaded decompression by breaking the file into runs that can be compressed or decompressed independently in parallel. Criticism of LZMA2's changes over LZMA include header fields not being covered by CRCs, and parallel decompression not being possible in practice.

- 7-Zip: LZMA2 compression, which is an improved version of LZMA, is now the default compression method for the .7z format, starting with version 9.30 on October 26, 2012.
- [7-Zip / Discussion / Open Discussion: LZMA vs. LZMA2](https://sourceforge.net/p/sevenzip/discussion/45797/thread/2f6085ba/)

Benchmarks:
- [7-Zip Compression Benchmark - OpenBenchmarking.org](https://openbenchmarking.org/test/pts/compress-7zip-1.11.0)

### LZ77 + BWT + content mixing: ZPAQ
[Wikipedia](https://en.wikipedia.org/wiki/ZPAQ)

### RLE + BWT + MTF + Huffman: bzip2
[Wikipedia](https://en.wikipedia.org/wiki/Bzip2)

### Density
[density: Superfast compression library](https://github.com/g1mv/density)

## Shared dictionaries
“黑压缩”

## Solid compression
[Wikipedia](https://en.wikipedia.org/wiki/Solid_compression)

> Solid compression is a method for data compression of multiple files, wherein all the uncompressed files are concatenated and treated as a single data block. Such an archive is called a solid archive.

> It is used natively in the 7z and RAR formats, as well as indirectly in tar-based formats such as `.tar.gz` and `.tar.bz2`. By contrast, the ZIP format is not solid because it stores separately compressed files (though solid compression can be emulated for small archives by combining the files into an uncompressed archive file and then compressing that archive file inside a second compressed ZIP file).

## Cryptography
> Cryptosystems often compress data (the "plaintext") before encryption for added security. When properly implemented, compression greatly increases the unicity distance by removing patterns that might facilitate cryptanalysis. However, many ordinary lossless compression algorithms produce headers, wrappers, tables, or other predictable output that might instead make cryptanalysis easier. Thus, cryptosystems must utilize compression algorithms whose output does not contain these predictable patterns.