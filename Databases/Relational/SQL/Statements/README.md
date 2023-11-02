# Statements
| | 创建 | 修改 | 删除 |
|--- | --- | --- | --- |
|模式 | `CREATE SCHEMA` |  | `DROP SCHEMA` |
|表 | `CREATE TABLE` | `ALTER TABLE` | `DROP TABLE` |
|视图 | `CREATE VIEW` |  | `DROP VIEW` |
|索引 | `CREATE INDEX` | `ALTER INDEX` | `DROP INDEX` |

## 模式
- ```sql
  CREATE SCHEMA 模式名 AUTHORIZATION 用户名 [表定义字句 | 视图定义子句 | 授权定义子句]
  ```
- ```sql
  DROP SCHEMA 模式名 <CASCADE|RESTRICT>
  ```

## 表
- ```sql
  CREATE TABLE 表名 (列名 数据类型 [列级完整性约束条件, …][, 表级完整性约束条件])
  ```
- ```sql
  ALTER TABLE 表名
  [ADD [COLUMN] 新列名 数据类型 [完整性约束]]
  [ADD 表级完整性约束]
  [DROP [COLUMN] 列名 [CASCADE|RESTRICT]]
  [DROP CONSTRAINT 完整性约束名 [RESTRICT|CASCADE]]
  [ALTER COLUMN 列名 数据类型]
  ```
- ```sql
  DROP TABLE 表名 [RESTRICT|CASCADE]
  ```

## 视图
- ```sql
  CREATE VIEW 视图名 [(列名, …)]
  AS 子查询
  [WITH CHECK OPTION]
  ```
- ```sql
  DROP VIEW 视图名 [CASCADE]
  ```

## 索引（非 SQL 标准）
- ```sql
  CREATE [UNIQUE] [CLUSTER] INDEX 索引名 ON 表名(列名[次序], …)
  ```
  次序 := `[ASC|DESC]`
- ```sql
  ALTER INDEX 旧索引名 RENAME TO 新索引名
  ```
- ```sql
  DROP INDEX 索引名
  ```

## 查询
- ```sql
  SELECT [ALL|DISTINCT] <目标列表达式, …> | 聚集函数([ALL|DISTINCT] 列名)
  FROM < <<表名|视图名>, …> | (查询子句) > [AS] 别名
  [WHERE 条件表达式]
  [GROUP BY 列名 [HAVING 条件表达式]]
  [ORDER BY 列名 [ASC|DESC]]
  ```

## 更新
- ```sql
  INSERT
  INTO 表名[(属性列, …)]
  VALUES <(常量, …), …> | 查询子句
  ```
- ```sql
  UPDATE 表名
  SET <<列名=表达式>, …>
  [WHERE 条件]
  ```
- ```sql
  DELETE
  FROM 表名
  [WHERE 条件]
  ```

```sql
INSERT INTO department
VALUES (31, 'Sales'),
       (33, 'Engineering'),
       (34, 'Clerical'),
       (35, 'Marketing');
```

## 注释
[SQLite 语法 | 菜鸟教程](https://www.runoob.com/sqlite/sqlite-syntax.html)
```sql
-- good
```
```sql
/* also good */
```