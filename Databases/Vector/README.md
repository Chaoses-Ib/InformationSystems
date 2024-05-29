# Vector Databases
[Wikipedia](https://en.wikipedia.org/wiki/Vector_database)

## Databases
- PostgreSQL
  - [pgvector: Open-source vector similarity search for Postgres](https://github.com/pgvector/pgvector)
  - [PostgresML: The GPU-powered AI application database. Get your app to market faster using the simplicity of SQL and the latest NLP, ML + LLM models.](https://github.com/postgresml/postgresml)

- SQLite
  - [→sqlite-vec](../Relational/DBMS/SQLite/README.md#extensions)

- [meilisearch: A lightning-fast search API that fits effortlessly into your apps, websites, and workflow](https://github.com/meilisearch/meilisearch)

- [LanceDB: Developer-friendly, serverless vector database for AI applications. Easily add long-term memory to your LLM apps!](https://github.com/lancedb/lancedb)
  - Languages: Rust, Python, JS
  - 目前不够成熟，用于官方设定外的场景可能有许多坑。
  - 基于 Arrow
    - > For simpler access or row-based access we recommend creating extension traits to convert Arrow data into your internal data model.
    - [Feature: Row IDs - Issue #1120](https://github.com/lancedb/lancedb/issues/1120)
    - [\[WIP\] \[RFC\] Remove hard-coded vector column requirements - Issue #462](https://github.com/lancedb/lancedb/issues/462)
  - LanceDB 支持遍历和 [IVF-PQ](https://lancedb.github.io/lancedb/concepts/index_ivfpq/) 两种查询方法，后者需要建立索引，会增加一定的硬盘占用，并且需要定时重新索引来保持性能。
    - 性能上都满足普通需要，根据官方的 benchmark，使用 IVF-PQ 的情况下 <10ms，即使用遍历在 ~100K embedding 时也只需要 100ms 左右。
    - 查询距离位于自动生成的 `_distance` 列。
  - [Indexes](https://docs.rs/lancedb/latest/lancedb/index/enum.Index.html)
    - Disk indexes in [IVF-PQ (inverted file index + product quantization)](https://lancedb.github.io/lancedb/concepts/index_ivfpq/)
    - > For small datasets of ~100K records or applications that can accept ~100ms latency, an ANN index is usually not necessary. Computing 100K pairs of 1000-dimension vectors takes less than 20ms. For large-scale (>1M) or higher dimension vectors, it is beneficial to create an ANN index.
    - [Reindexing](https://lancedb.github.io/lancedb/concepts/data_management/#reindexing)

      [Incremental updates to an index - Issue #487](https://github.com/lancedb/lancedb/issues/487)

    - IVF-PQ 不保证返回最优匹配，需要进行一定[调参](https://lancedb.github.io/lancedb/faq/#do-i-need-to-set-a-refine-factor-when-using-an-index)，不过在性能要求不高时应该可以直接使用较为宽松的参数。
    - [system runs of memory at index creation time - Issue #767](https://github.com/lancedb/lancedb/issues/767)
    - [IVF-HNSW-SQ](https://docs.rs/lancedb/latest/lancedb/index/vector/struct.IvfHnswSqIndexBuilder.html)
  - [Storage](https://lancedb.github.io/lancedb/concepts/storage/)
    - NVMe: <10ms p95
    - [\[Feature request\] uri for connect in memory - Issue #676](https://github.com/lancedb/lancedb/issues/676)
  - LanceDB 是基于 Arrow 的，可以储存 embedding 外的普通数据，如果要用 LanceDB 的话可以把 chunks 的数据都储存到 LanceDB 中。
  - [FTS](https://lancedb.github.io/lancedb/fts/): [Tantivy: A full-text search engine library inspired by Apache Lucene and written in Rust](https://github.com/quickwit-oss/tantivy)

    目前不支持 Rust。
  - [Benchmarking LanceDB](https://blog.lancedb.com/benchmarking-lancedb-92b01032874a/)
  - Updating
    - Delete + insert
    - [`update()`](https://docs.rs/lancedb/latest/lancedb/table/struct.Table.html#method.update), 
    - Python: [`update()`](https://lancedb.github.io/lancedb/python/python/#lancedb.table.Table.update), [`merge_insert()`](https://lancedb.github.io/lancedb/python/python/#lancedb.table.Table.merge_insert)
  
    [Update of Data - Issue #442](https://github.com/lancedb/lancedb/issues/442)

    Embedding:
    - [Feature: port python's embedding funtions to Rust - Issue #994](https://github.com/lancedb/lancedb/issues/994)
    - [Feature: Implement Async Embedding Creation for Enhanced Performance - Issue #830](https://github.com/lancedb/lancedb/issues/830)
    - [Vector regeneration on embedding model change - Issue #931](https://github.com/lancedb/lancedb/issues/931)
    - [Feature: schema evolution & embedding functions - Issue #737](https://github.com/lancedb/lancedb/issues/737)
  
  - [Feature: complete rust API - Issue #996](https://github.com/lancedb/lancedb/issues/996)

  [Show HN: Lance -- Alternative to Parquet for ML data | Hacker News](https://news.ycombinator.com/item?id=36144450)
  - > We are building different indices into this columnar storage format, which is actually a happy side-effect of its good random-access performance. It does occur extra space for indices.

- [Qdrant: High-performance, massive-scale Vector Database for the next generation of AI. Also available in the cloud https://cloud.qdrant.io/](https://github.com/qdrant/qdrant)
  - Languages: Rust, Python
  - > Qdrant does not perform well (consume too much resource) when large amount (kilos) of collections is created. They recommand a single collection & multitenancy approach to deal with this but this does not fit in my case.

- Chroma DB
  - Languages: Python, JS

- [Weaviate: An open-source vector database that stores both objects and vectors, allowing for the combination of vector search with structured filtering with the fault tolerance and scalability of a cloud-native database​.](https://github.com/weaviate/weaviate)
  - Language: Go

History:
- 2023-05 [Which database to use for semantic search? : r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/comments/13tp2sr/which_database_to_use_for_semantic_search/)
- 2024-01 [Best Practices for Semantic Search on 200k vectors (30GB) Worth of Embeddings? : r/LangChain](https://www.reddit.com/r/LangChain/comments/1acxxbw/best_practices_for_semantic_search_on_200k/)
- 2024-02 [What storage/ search are you using for retrieval : r/LangChain](https://www.reddit.com/r/LangChain/comments/1b1x880/what_storage_search_are_you_using_for_retrieval/)
- 2024-04 [Best vector database for large scale data, besides qdrant and pinecone : r/LangChain](https://www.reddit.com/r/LangChain/comments/1c2t59t/best_vector_database_for_large_scale_data_besides/)