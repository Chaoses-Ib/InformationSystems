# String Compression
In addition to general compression:
- Language dictionary
- Unicode optimization
- Short or no header (for short strings)

## Algorithms
- [→Standard Compression Scheme for Unicode (SCSU)](#standard-compression-scheme-for-unicode-scsu)

- [UTF-C: A compact way to encode Unicode strings](https://github.com/deNULL/utf-c)

- [smaz: Small strings compression library](https://github.com/antirez/smaz)
  - Dictionary

- [shoco: a compressor for small text strings](https://github.com/Ed-von-Schleck/shoco) ([GitHub](https://ed-von-schleck.github.io/shoco/))
  - > The compressed size will never exceed the size of your input string, provided it is plain ASCII.

  > smaz seems to be dictionary based, while shoco is an entropy encoder. As a result, smaz will often do better than shoco when compressing common english terms. However, shoco typically beats smaz for more obscure input, as long as it’s ASCII.

- [rmw-utf8: utf-8的短文本压缩算法（为中文压缩优化）](https://github.com/rmw-link/rmw-utf8)
  - Dictionary

### Standard Compression Scheme for Unicode (SCSU)
[Wikipedia](https://en.wikipedia.org/wiki/Standard_Compression_Scheme_for_Unicode)

> reducing the number of bytes needed to represent Unicode text, especially if that text uses mostly characters from one or a small number of per-language character blocks. It does so by dynamically mapping values in the range 128–255 to offsets within particular blocks of 128 characters. The initial conditions of the encoder mean that existing strings in ASCII and ISO-8859-1 that do not contain C0 control codes other than NULL TAB CR and LF can be treated as SCSU strings.
> SCSU can also switch to UTF-16 internally to handle non-alphabetic languages.

- Go: [scsu](https://github.com/dop251/scsu)

[Unicode compression implementation - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/data-compression/unicode-compression-implementation?view=sql-server-ver15)
