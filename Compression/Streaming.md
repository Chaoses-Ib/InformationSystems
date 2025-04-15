# Streaming Compression
- Blocks
  - Disks
  - File systems

[Data Compression/Streaming Compression - Wikibooks, open books for an open world](https://en.wikibooks.org/wiki/Data_Compression/Streaming_Compression)
> There has been little research on alternatives to "blocks". Some people speculate that, compared to using a block size of B bytes, it may be possible to achieve better compression and just as quick restarts with a (non-blocking) converging decoder designed so that all decoders, no matter when they are turned on, eventually converge on the same adaptive dictionary after at most B bytes. An adaptive block decoder has very little context (and poor compression) at the beginning of each block, gradually rising to lots of context (and much better compression) at the end of the block. A non-adaptive block decoder has the overhead of a dictionary or Huffman table at the beginning of each block (in effect, zero compression during the dictionary or table, and high compression during the data in the remainder of the block). The converging decoder, in theory, has some intermediate context (and some intermediate compression) at all times, without dictionary or table overhead or times of poor compression.

[Is there an official name for "streaming compression algorithm"? : r/algorithms](https://www.reddit.com/r/algorithms/comments/m8irwd/is_there_an_official_name_for_streaming/)

[sockets - Does any mainstream compression algorithm natively support streaming data - Stack Overflow](https://stackoverflow.com/questions/44478254/does-any-mainstream-compression-algorithm-natively-support-streaming-data)

[performance - Streaming proxied responses with gzip on nginx - Server Fault](https://serverfault.com/questions/967271/streaming-proxied-responses-with-gzip-on-nginx)

[IIS Dynamic Compression and new Dynamic Compression features in IIS 10 - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/iis-support-blog/iis-dynamic-compression-and-new-dynamic-compression-features-in/ba-p/773878)

[Compression and Decompression | NGINX Documentation](https://docs.nginx.com/nginx/admin-guide/web-server/compression/)

## Compressing vs transorting
Compressing can be thought as a side channel for transporting. If $\text{compression speed}\times (1-\text{compression ratio}) > \text{transport speed}$, compressing should be preferred. With streaming this can be further relaxed.

## gzip
[Wikipedia](https://en.wikipedia.org/wiki/Gzip)

> zlib is an abstraction of the DEFLATE algorithm in library form which includes support both for the gzip file format and a lightweight data stream format in its API. The zlib stream format, DEFLATE, and the gzip file format were standardized respectively as RFC 1950, RFC 1951, and RFC 1952.

> Gzip is fundamentally supported by all web servers, browsers and intermediaries (CDNs, proxies, etc), mostly by default. Despite how easy it is to serve content gzip compressed, there are a few things to keep in mind:
> 
> - Most web servers and CDNs default to gzip compression level 6, which is a reasonable default. Some servers (ie, NGINX) [default to gzip level 1](https://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip), which usually results in faster compression times but results in a larger file. Make sure to check your compression levels!
> - Many CDNs can gzip compress resources for you, which is helpful if you missed something on your origin server. Some CDNs enable this by default.
> - Some CDNs may decompress and recompress content for you if they need to inspect or manipulate the contents. This may have an impact on your time to first byte (TTFB) especially if the content that needs to be recompressed is large.

[linux - Fast Concatenation of Multiple GZip Files - Stack Overflow](https://stackoverflow.com/questions/8005114/fast-concatenation-of-multiple-gzip-files)