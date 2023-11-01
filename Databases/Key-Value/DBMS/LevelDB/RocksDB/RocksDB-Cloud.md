# RocksDB-Cloud
[GitHub](https://github.com/rockset/rocksdb-cloud)

RocksDB-Cloud provides three main advantages for AWS environments:

1. A rocksdb instance is durable. Continuous and automatic replication of db data and metadata to S3. In the event that the rocksdb machine dies, another process on any other EC2 machine can reopen the same rocksdb database (by configuring it with the S3 bucketname where the entire db state was stored).

2. A rocksdb instance is cloneable. RocksDB-Cloud support a primitive called zero-copy-clone() that allows a slave instance of rocksdb on another machine to clone an existing db. Both master and slave rocksdb instance can run in parallel and they share some set of common database files.

3. A rocksdb instance can leverage hierarchical storage. The entire rocksdb storage footprint need not be resident on local storage. S3 contains the entire database and the local storage contains only the files that are in the working set.

[Rockset's RocksDB-Cloud Library | Rockset](https://rockset.com/blog/rocksdb-cloud-enabling-the-next-generation-of-cloud-native-databases/)

> Enter Rockset's RocksDB-Cloud library, an extension of RocksDB that maps local sstable files on to an S3-style bucket and WAL entries on to a Cloud Native Log such as a Kafka or Kinesis Partition. Intel has been collaborating with several end-customers and the Rockset team to enable this deployment scenario. Thus far we've successfully enabled the database to operate with MariaDB configured to maintain its sstable files locally and in a Minio-based S3 bucket. The WAL is configured to be local. We rely on the MariaDB instances binlog for maintaining the current a database's change-state.

## [RocksDBLite](https://github.com/rockset/rocksdb-cloud/blob/master/ROCKSDB_LITE.md)
Some examples of the features disabled by ROCKSDB_LITE:
- Compiled-in support for LDB tool
- No backup engine
- No support for replication (which we provide in form of TransactionalIterator)
- No advanced monitoring tools
- No special-purpose memtables that are highly optimized for specific use cases
- No Transactions