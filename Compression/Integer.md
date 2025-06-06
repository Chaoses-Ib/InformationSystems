# Integer Compression
- General compression can be thought as a kind of integer compression, where the integer size is 8 bits

[Sorted integer compression - Ayende @ Rahien](https://ayende.com/blog/193955-A/sorted-integer-compression) ([Hacker News](https://news.ycombinator.com/item?id=27549075))
> FastPFor is using a bits stream while StreamVByte is using byte oriented mode. Theoretically speaking, you can get better compression rate from FastPFor, but StreamVByte is supposed to be faster.

> For anyone who wants really good compression of data with a particular characteristic, a very useful approach is to first shrink or reformat the data based on that characteristic, then pass the result through a general purpose compressor.
>
> For this case that might mean convert the data into deltas, then write those deltas in a byte-oriented variable length integer fashion. The general purpose compressor can then pick up most of what you have left on the table by not being super careful with the balancing of the chosen integer format, and it might find some other useful patterns in the data without you having to worry about those.

> If you want higher compression, a better option would be Binary Interpolative Coding [1], which has some of the highest compression rate among the schemes that are relatively simple to implement. Then you can go down the rabbit hole and start to use entropy compression, complex modeling, etc... But there are diminishing returns.

[Benchmarking Integer Compression in Go - Zen 3.1 - Product. Data. Code](https://zhen.org/blog/benchmarking-integer-compression-in-go/) ([Hacker News](https://news.ycombinator.com/item?id=6537688))
- Compression ratio (timestamp): VTEnc/1 < pcodec << Gzip << Delta BP32 + VariableByte < LZW < Snappy < Delta VariableByte < ZigZag BP32 + VariableByte << FastPFOR + VariableByte < BP32 + VariableByte < VariableByte

[vteromero/integer-compression-benchmarks: Integer compression benchmarks for sorted lists](https://github.com/vteromero/integer-compression-benchmarks)
- Compression ratio: VTEnc/1 << Delta+FastPFor < Delta+BinaryPacking << Delta+VariableByte < Delta+VarIntGB

[The Simple Beauty of XOR Floating Point Compression | Clemens' Blog](https://clemenswinter.com/2024/04/07/the-simple-beauty-of-xor-floating-point-compression/)

[python - Compression of randomly ordered non-repeating incremental integers - Stack Overflow](https://stackoverflow.com/questions/77742122/compression-of-randomly-ordered-non-repeating-incremental-integers)

## Algorithms
- Transform + general compression
  - Delta encoding ([Wikipedia](https://en.wikipedia.org/wiki/Delta_encoding))
    - Rust: [delta-encoding: A Rust library to encode and decode a delta-encoded stream of numbers](https://github.com/nyurik/delta-encoding)
  - [Blosc: Make NDArray Transposition Fast (and Compressed!)](https://www.blosc.org/)
    - [asomers/blosc-rs: Rust bindings for C-Blosc](https://github.com/asomers/blosc-rs)
      - No [WASM support - Issue #27](https://github.com/asomers/blosc-rs/issues/27)

- [pcodec: Lossless codec for numerical data](https://github.com/pcodec/pcodec)
  - \> parquet+zstd, blosc+zstd

      [Benchmark vs. SPDP and PFor algorithms - Issue #189 - pcodec/pcodec](https://github.com/pcodec/pcodec/issues/189)

    [Benchmark: TurboTranspose+iccodecs vs Quantile Compression - Issue #100 - powturbo/TurboPFor-Integer-Compression](https://github.com/powturbo/TurboPFor-Integer-Compression/issues/100)
  - No direct stream API
    - [Streaming decompression - Issue #245 - pcodec/pcodec](https://github.com/pcodec/pcodec/issues/245)

    > It supports streaming decompression, but compression still needs to be done one chunk at a time (ideally 1k+ numbers per chunk). Each file can contain many chunks.

  [q\_compress 0.7: still has 35% higher compression ratio than .zstd.parquet for numerical sequences, now with delta encoding and 2x faster than before : r/rust](https://www.reddit.com/r/rust/comments/surtee/q_compress_07_still_has_35_higher_compression/)
  > zstd is a general lz77 purpose compressor and is weak at compressing numerical data. You can improve drastically the lz77 compression by preprocessing your data with transpose. This is what blosc is doing.

- [fast-pack/FastPFOR: The FastPFOR C++ library: Fast integer compression](https://github.com/fast-pack/FastPFor)
  - Rust: [fast-pack/FastPFOR-rs: FastPFOR library written in Rust](https://github.com/fast-pack/FastPFOR-rs)

  [Integer compression: Understanding FastPFor - Ayende @ Rahien](https://ayende.com/blog/199523-C/integer-compression-understanding-fastpfor)
- [powturbo/TurboPFor-Integer-Compression: Fastest Integer Compression](https://github.com/powturbo/TurboPFor-Integer-Compression)
  - Rust
- [fast-pack/simdcomp: A simple C library for compressing lists of integers using binary packing](https://github.com/fast-pack/simdcomp)
  - Rust
    - [quickwit-oss/bitpacking: SIMD algorithms for integer compression via bitpacking. This crate is a port of a C library called simdcomp.](https://github.com/quickwit-oss/bitpacking)
      - Cumbersome API, only supports fixed-size input
    - ~~[fralalonde/mayda: Fast Rust integer compression using SIMD](https://github.com/fralalonde/mayda)~~
  - Java: [fast-pack/JavaFastPFOR: A simple integer compression library in Java](https://github.com/fast-pack/JavaFastPFOR)
- [vteromero/VTEnc: VTEnc C library](https://github.com/vteromero/VTEnc)
- Stream VByte: Faster Byte-Oriented Integer Compression[^StreamVByteFaster2018]

  [Stream VByte: breaking new speed records for integer compression -- Daniel Lemire's blog](https://lemire.me/blog/2017/09/27/stream-vbyte-breaking-new-speed-records-for-integer-compression/)

  Rust: [marshallpierce / stream-vbyte-rust --- Bitbucket](https://bitbucket.org/marshallpierce/stream-vbyte-rust/src/master/)
- [qsib-cbie/tsz: Compact Integral Time-Series Compression](https://github.com/qsib-cbie/tsz)

## Time series
- [rana/tms: Time series compression library in Rust and SIMD.](https://github.com/rana/tms)

## Order
The order of integers is also an information and takes space. How to compress optimally without preserving the order?

- Sorting (+ delta encoding)

  Can improve compression performance, but is this optimal?

- Integer Set Compression and Statistical Modeling[^larssonIntegerSetCompression2014]

  > In this work, we address the case where enumeration of elements may be arbitrary or random, but where statistics is kept in order to estimate probabilities of elements. We present a recursive subset-size encoding method that is able to benefit from statistics, explore the effects of permuting the enumeration order based on element probabilities, and discuss general properties and possibilities for this class of compression problem.

- Compressing Sets and Multisets of Sequences[^steinrueckenCompressingSetsMultisets2015]

  > We propose a technique that transforms the multiset into an order-invariant tree representation, and derive an arithmetic code that optimally compresses the tree. Our method achieves compression even if the sequences in the multiset are individually incompressible (such as cryptographic hash sums). The algorithm is demonstrated practically by compressing collections of SHA-1 hash sums, and multisets of arbitrary, individually encodable objects.

  How is this better than sorting?
  > Making an order-invariant representation of $W$ could be as easy as arranging the words in some sorted order: if both the sender and receiver use the same ordering, zero probability could be given to all words whose appearance violates the agreed order, reallocating the excluded probability mass to words that remain compatible with the ordering. However, the correct probability for the next element in a sorted sequence is expensive to compute, making this approach unappealing.

## [→Homomorphic Compression](Homomorphic/README.md)


[^larssonIntegerSetCompression2014]: Larsson, N. J. (2014). Integer Set Compression and Statistical Modeling (No. arXiv:1402.1936). arXiv. https://doi.org/10.48550/arXiv.1402.1936
[^steinrueckenCompressingSetsMultisets2015]: Steinruecken, C. (2015). Compressing Sets and Multisets of Sequences. IEEE Transactions on Information Theory, 61(3), 1485–1490. https://doi.org/10.1109/TIT.2015.2392093
[^StreamVByteFaster2018]: Stream VByte: Faster byte-oriented integer compression. (2018). Information Processing Letters, 130, 1–6. https://doi.org/10.1016/j.ipl.2017.09.011
