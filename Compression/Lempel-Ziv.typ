#import "@local/ib:0.1.0": *
#title[Lempel-Ziv (LZ)]
#a[embedded - What would be a good (de)compression routine for this scenario - Stack Overflow][https://stackoverflow.com/questions/1348479/what-would-be-a-good-decompression-routine-for-this-scenario]

#a[compression - Compact decompression library for embedded use - Stack Overflow][https://stackoverflow.com/questions/3767640/compact-decompression-library-for-embedded-use]

#a[What is the simplest algorithm to compress a string? - Computer Science Stack Exchange][https://cs.stackexchange.com/questions/134277/what-is-the-simplest-algorithm-to-compress-a-string]

= LZ77 and LZ78
<lz77>
#a-badge[https://en.wikipedia.org/wiki/LZ77_and_LZ78]

= Lempel-Ziv-Storer-Szymanski (LZSS)
#t[1982]
#a-badge[https://en.wikipedia.org/wiki/Lempel–Ziv–Storer–Szymanski]

#q[
The main difference between LZ77 and LZSS is that in LZ77 the dictionary reference could actually be longer than the string it was replacing.
In LZSS, such references are omitted if the length is less than the "break even" point.
Furthermore, LZSS uses one-bit flags to indicate whether the next chunk of data is a literal (byte) or a reference to an offset/length pair.
]

== Libraries
Rust:
- #a[alexkazik/lzss: A LZSS en-/decompressor (lossless data compression, `no_std` capable, in pure Rust)][https://github.com/alexkazik/lzss]
  - Bit unit
  - #a[myst6re/lzs][https://github.com/myst6re/lzs]
    - Byte unit

#a[Compression for embedded / `no_std` - embedded - The Rust Programming Language Forum][https://users.rust-lang.org/t/compression-for-embedded-no-std/68839]

== Applications
- Many popular archivers like ARJ, RAR, ZOO, LHarc use LZSS rather than LZ77 as the primary compression algorithm;
  the encoding of literal characters and of length-distance pairs varies, with the most common option being Huffman coding.
- Most implementations stem from a public domain 1989 code by Haruhiko Okumura.
- Version 4 of the Allegro library can encode and decode an LZSS format, but the feature was cut from version 5.
- The Game Boy Advance BIOS can decode a slightly modified LZSS format.
- Apple's macOS uses LZSS as one of the compression methods for kernel code.

  #a[`kext_tools/compression.c`][https://github.com/opensource-apple/kext_tools/blob/bc71a85/compression.c]

= Lempel-Ziv-Welch
#t[1984]
#a-badge[https://en.wikipedia.org/wiki/Lempel–Ziv–Welch]

#a[Embedded - Lossless Data Compression for Embedded Systems][https://www.embedded.com/lossless-data-compression-for-embedded-systems/]

== Libraries
Rust:
- #a[nwin/lzw: LZW en- and decoding][https://github.com/nwin/lzw]
  (discontinued)
  - #a[image-rs/weezl: LZW en- and decoding that goes weeeee!][https://github.com/image-rs/weezl]

== Applications
- GIF

= LZF
#t[2000]

C++:
- #a[Marc Lehmann's "LibLZF"][http://oldhome.schmorp.de/marc/liblzf.html]
  - #a[liblzf][https://software.schmorp.de/pkg/liblzf.html]

Rust:
- #a[badboy/lzf-rs: Rust implementation of LibLZF][https://github.com/badboy/lzf-rs]
  (discontinued)

= Snappy
<snappy>
#t[2011]
#a-badge[https://en.wikipedia.org/wiki/Snappy_(compression)]

== Libraries
Rust:
- #a[rust-snappy: Snappy compression implemented in Rust (including the Snappy frame format).][https://github.com/burntsushi/rust-snappy]

== Applications
- Firefox: local storage

= LZ4
<lz4>
#t[2011]
#a-badge[https://en.wikipedia.org/wiki/LZ4_(compression_algorithm)]

#q[
We believe LZ4 is almost always better than Snappy.
LZ4/Snappy is a lightweight compression algorithm so it usually strikes a good balance between space and CPU usage.
]

#a[The LZ4 introduced in PostgreSQL 14 provides faster compression | Hacker News][https://news.ycombinator.com/item?id=29147656]
- #q[LZ4 is amazing - it's basically the same idea as LZ77, *only* implemented carefully, with all the dozens parameters and tradeoffs made in a certain way.
  Couple this with modern amounts of brute force thrown in an optimal parser (LZ4HC) and you get something quite extraordinary, on the "Pareto frontier" of compression efficiency.
  There's a tendency to focus on algorithms and scoff at implementation details, but LZ4 was possible as an algorithm 30 years ago, yet the implementation details crystallized to perfection only, say, five years ago.]

== Libraries
C++:
- #a[lz4: Extremely Fast Compression algorithm][https://github.com/lz4/lz4]
  - Rust
    - #a[10XGenomics/lz4-rs: Rust LZ4 bindings][https://github.com/10xGenomics/lz4-rs]
    - #a[picoHz/lzzzz: Full-featured liblz4 binding for Rust][https://github.com/picoHz/lzzzz]

Rust:
- #a[`lz4_flex`: Fastest pure Rust implementation of LZ4 compression/decompression.][https://github.com/PSeitz/lz4_flex]
  - `no_std` but `alloc`, although not actually a must.
  - #a[`lz4_decompress`][https://github.com/traceflight/lz4_decompress]
- #a[lz-fear: A fast pure-rust no-unsafe implementation of LZ4 compression and decompression][https://github.com/main--/rust-lz-fear]
- #a[lamezip77: Univeral(-ish) LZ77 thing][https://github.com/ArcaneNibble/lamezip77]

== Applications
- Linux v3.11
- ZFS
- Apache Hadoop
