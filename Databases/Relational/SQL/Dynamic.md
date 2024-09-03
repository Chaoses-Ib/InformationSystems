# Dynamic SQL
[The Curse and Blessings of Dynamic SQL](https://www.sommarskog.se/dynamic_sql.html)

Use cases:
- Dynamic Search Conditions
- Accessing Remote Data Sources
- Setting up Synonyms for Cross-Database Access
- `BULK INSERT` and `OPENROWSET(BULK)`
- Maintenance Tasks in General
- Dynamic Pivot – Making Rows into Columns

Wrong use cases:
- Dynamic Table Names in Application Code

  > Most likely, this is the result of some mistake earlier in the design. In a relational database, a table is intended to model a unique entity with a distinct set of attributes (that is, the columns). Typically, different entities require different operations. So if you think that you want to run the same query on multiple tables, something is not the way it should be.

  - Partitioned tables and views

- Dynamic Column Names
- Set Column Aliases Dynamically
- Dynamic Procedure Names
- Dynamic ORDER BY Condition
- `SELECT * FROM tbl WHERE col IN (@list)`
- Sending in a WHERE Clause as a Parameter
- Working with a Table with Unknown Columns
- `BACKUP`/`RESTORE`

## SQL builders
C++:
- WCDB: [C++ 语言集成查询 - Tencent/wcdb Wiki](https://github.com/Tencent/wcdb/wiki/C++-%e8%af%ad%e8%a8%80%e9%9b%86%e6%88%90%e6%9f%a5%e8%af%a2)

Go:
- [Squirrel: Fluent SQL generation for golang](https://github.com/Masterminds/squirrel)
- [jet: Type safe SQL builder with code generation and automatic query result data mapping](https://github.com/go-jet/jet)
- [goqu: SQL builder and query library for golang](https://github.com/doug-martin/goqu)
- [sqlf: Generate parameterized SQL statements in Go, sprintf style](https://github.com/keegancsmith/sqlf)

## Dynamic conditions
[Dynamic Search Conditions in T-SQL](https://www.sommarskog.se/dyn-search.html)

- Static SQL with `OPTION (RECOMPILE)`

  ```sql
  SELECT o.OrderID, o.OrderDate, o.EmployeeID, o.Status,
        c.CustomerID, c.CustomerName, c.Address, c.City, c.Region,
        c.PostalCode, c.Country, c.Phone, od.UnitPrice, od.Quantity,
        p.ProductID, p.ProductName, p.UnitsInStock, p.UnitsOnOrder
  FROM   Orders o
  JOIN   [Order Details] od ON o.OrderID = od.OrderID
  JOIN   Customers c ON o.CustomerID = c.CustomerID
  JOIN   Products p ON p.ProductID = od.ProductID
  WHERE  (o.OrderID = @orderid OR @orderid IS NULL)
    AND  (o.Status = @status OR @status IS NULL)
    AND  (o.OrderDate >= @fromdate OR @fromdate IS NULL)
    AND  (o.OrderDate <= @todate OR @todate IS NULL)
    AND  (od.UnitPrice >= @minprice OR @minprice IS NULL)
    AND  (od.UnitPrice <= @maxprice OR @maxprice IS NULL)
    AND  (o.CustomerID = @custid OR @custid IS NULL)
    AND  (c.CustomerName LIKE @custname + '%' OR @custname IS NULL)
    AND  (c.City = @city OR @city IS NULL)
    AND  (c.Region = @region OR @region IS NULL)
    AND  (c.Country = @country OR @country IS NULL)
    AND  (od.ProductID = @prodid OR @prodid IS NULL)
    AND  (p.ProductName LIKE @prodname + '%' OR @prodname IS NULL)
  ORDER  BY o.OrderID
  OPTION (RECOMPILE)
  ```

  > The `OPTION (RECOMPILE)` hint instructs SQL Server to recompile the query every time. *Without* this hint, SQL Server produces a plan that will be cached and reused. This has a very important implication: the plan must work with all possible input values of the parameters. When SQL Server builds an execution plan for a stored procedure, it "sniffs" the values of the parameters and optimises the queries in the procedure for these values -- but in a way so that plan will be correct no matter which values that are passed.

  Limitations:
  > When the requirements grow in complexity, the complexity of the query tends to grow non-linearly, so that what once was a relatively simple query evolves to a beast that hardly anyone understands, even less wants to touch.
  - Operators
  - Multi-valued parameters with operators other than `=`

    e.g. 2008~2012 or 2000~2024

  Discussions:
  - 2012-07 [sql server - SQL, how to use Dynamic Condition logics? - Stack Overflow](https://stackoverflow.com/questions/11395580/sql-how-to-use-dynamic-condition-logics)

- Dynamic SQL

  - [go-jet: How to construct dynamic condition?](https://github.com/go-jet/jet/wiki/FAQ#how-to-construct-dynamic-condition)
  - 2015-07 [ios - Sqlite.swift create dynamic complex queries - Stack Overflow](https://stackoverflow.com/questions/31595212/sqlite-swift-create-dynamic-complex-queries)
  - 2016-05 [python - How to create a dynamic filter? - Stack Overflow](https://stackoverflow.com/questions/37336520/how-to-create-a-dynamic-filter)
  - 2021-01 [python 3.x - Correct way to construct SQLite query with varying amount of filter parameters - Stack Overflow](https://stackoverflow.com/questions/65910707/correct-way-to-construct-sqlite-query-with-varying-amount-of-filter-parameters)
  - 2023-09 [How do you dynamically create SQL filters from query params? : r/golang](https://www.reddit.com/r/golang/comments/16uepxw/how_do_you_dynamically_create_sql_filters_from/)

UI:
- Expressions
- Lists/Tress
- Column header options