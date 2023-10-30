# Physical Data Models
## 物理结构设计
为给定的逻辑模型选取最适合应用要求的物理结构的过程，就是数据库的物理设计。

数据库的物理结构设计通常分为两步：
- 确定数据库的物理结构

  关系数据库物理设计的主要内容是为关系模式选择存取方法，设计关系、索引等数据库文件的物理存储结构。

  常用的存取方法有索引和聚簇。

  物理存储结构包括数据存放位置和系统配置。

- 对物理结构进行评价

  时间和空间效率

## I/O
[Are You Sure You Want to Use MMAP in Your Database Management System? (CIDR 2022)](https://db.cs.cmu.edu/mmap-cidr2022/)
- Transactional safety
- I/O stalls
- Error handling
- Performance issues