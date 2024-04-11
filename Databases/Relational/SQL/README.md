# Structured Query Language
[Wikipedia](https://en.wikipedia.org/wiki/SQL)

## 标准
“SQL 标准因为定义过于宽泛等技术和非技术原因，不同产品对标准的符合程度存在很大的差异。”

[SQL标准简介 - 云+社区 - 腾讯云](https://cloud.tencent.com/developer/article/1442564)

## Parsers and transpilers
- [SQLGlot: Python SQL Parser and Transpiler](https://github.com/tobymao/sqlglot)
- [Logica: A logic programming language that compiles to SQL. It runs on Google BigQuery, PostgreSQL and SQLite.](https://github.com/EvgSkv/logica)

## 特点
- 综合统一

  非关系模型的数据语言一般都分为：
  - 模式 DDL（数据定义语言）
  - 外模式 DDL
  - DSDL（数据存储描述语言）
  - DML（数据操纵语言）

  而 SQL 集它们于一身，语言风格统一，可以独立完成数据库生命周期中的全部活动。

- 高度非过程化

  不需要指定存取路径

- 面向集合的操作方式

- 以同一种语法结构提供多种使用方式
  - 交互式使用
  - 嵌入式使用

- 语言简洁、易学易用

## [SQLZOO](https://sqlzoo.net/wiki/SQL_Tutorial)
- MySQL
- 没有参考答案

1.14
```sql
SELECT capital, name FROM world WHERE capital LIKE CONCAT(name, '_%')
```
1.15
```sql
SELECT name, RIGHT(capital, LENGTH(capital) - LENGTH(name)) FROM world WHERE capital LIKE CONCAT(name, '_%')
```

4.2
```sql
SELECT name FROM world WHERE continent = 'Europe' AND gdp/population >
  (SELECT gdp/population FROM world WHERE name = 'United Kingdom')
```
4.3
```sql
SELECT name, continent FROM world WHERE continent IN
(SELECT continent FROM world WHERE INSTR(name, 'Argentina') OR INSTR(name, 'Australia'))
ORDER BY name
```