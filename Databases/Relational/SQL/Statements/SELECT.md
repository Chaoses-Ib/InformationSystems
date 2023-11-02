# SELECT
```sql
SELECT [ALL|DISTINCT] <目标列表达式, …> | 聚集函数([ALL|DISTINCT] 列名)
FROM < <<表名|视图名>, …> | (查询子句) [AS] 别名>
[WHERE 条件表达式]
[GROUP BY 列名 [HAVING 条件表达式]]
[ORDER BY 列名 [ASC|DESC]]
[<UNION|INTERSECT|EXCEPT> 查询子句]
```

## 聚集函数
- `COUNT`

  `COUNT(*)`，不用纠结计数元组时用哪个列

- `SUM`
- `AVG`
- `MAX`、`MIN`

  可以用于文本。

## `FROM`
- 临时派生表

  `(查询子句) [AS] 别名`

  ```sql
  SELECT Sname, Ssex, Sdept
	FROM SC, Student, (
	    SELECT DISTINCT SC.Cno
	    FROM SC, Course
	    WHERE SC.Cno = Course.Cno AND Course.Cname = 'C++'
	    ) AS cpp
	WHERE SC.Cno = cpp.Cno AND Student.Sno = SC.Sno;
  ```
  为什么要加 DISTINCT 才行？

- ```sql
  <INNER | <LEFT|RIGHT|FULL> OUTER> JOIN 表名 <ON (条件表达式) | USING (列名)>
  | <CROSS|NATURAL> JOIN 表名
  ```

- 多表

  ```sql
  SELECT Sname, Ssex, Sdept
  FROM SC, Course, Student
  WHERE SC.Cno = Course.Cno AND Course.Cname = 'C++' AND Student.Sno = SC.Sno;
  ```

[Join (SQL) - Wikipedia](https://en.wikipedia.org/wiki/Join_(SQL)#Natural_join)

## `WHERE`
- 逻辑运算

  `NOT`, `AND`, `OR`

  非标准：
  - `XOR`

- 比较运算符

  `=`, `>`, `<`, `>=`, `<=`, `!=`, `<>`, `!>`, `!<`

- `BETWEEN … AND …`
- `IN (…)`
- `LIKE '匹配串' [ESCAPE '转义符']`

  `%` := 正则 `.*`

  `_` := 正则 `.`

  不支持分支，也不能 `field LIKE '%a%' OR '%b%'`。

- `IS NULL`

## `GROUP BY`
- `HAVING` 作用于整个组或组的第一行。

<br />

- 去重
- 配合聚集函数使用

查询选修了两门以上课程的学生学号：
```sql
SELECT Sno
FROM SC
GROUP BY Sno
HAVING COUNT(*)>2;
```

## 嵌套查询（nested query）
- 嵌套查询是嵌套在另一个查询块的 `WHERE` 或 `HAVING` 子句中的查询。
- 不相关子查询：子查询的查询条件不依赖于父查询。
- 不能使用 `ORDER BY` 子句
- 连接查询的性能通常高于嵌套查询

<br />

- `<IN | 比较运算符 [ANY|ALL] | EXISTS> (查询子句)`

  聚集函数的性能比 `ANY|ALL` 高

- `EXISTS`

  若内层查询结果非空，则外层的 `WHERE` 子句返回真值，否则返回假值。

  所有带 `IN` 谓词、比较运算符、`ANY` 和 `ALL` 谓词的子查询都能用带 `EXISTS` 谓词的子查询等价替换。

## 相关子查询的处理过程
```sql
SELECT Sname
FROM Student
WHERE EXISTS
        (SELECT *
        FROM SC
        WHERE Sno=Student.Sno AND Cno='1');
```
本例中子查询的查询条件依赖于外层父查询的某个属性值（`Student` 的 `Sno` 值），因此是相关子查询。
这个相关子查询的处理过程是：首先取外层查询中 `Student` 表的第一个元组，根据它与内层查询相关的属性值（`Sno` 值）处理内层查询，若 `WHERE` 子句返回值为真，则取外层查询中该元组的 `Sname` 放入结果表；然后再取 `Student` 表的下一个元组； 重复这一过程，直至外层 `Student` 表全部检查完为止。