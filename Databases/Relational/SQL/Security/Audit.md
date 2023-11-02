# Audit
[科普|什么是数据库审计？ - 知乎](https://zhuanlan.zhihu.com/p/100905028)

## 使用场景
- 安全事故追踪溯源
- 风险行为预警

## SQL
- ```sql
  AUDIT <事件, …>
  ON 表名
  ```
- ```sql
  NOAUDIT <事件, …>
  ON 表名
  ```

`SYS_AUDITTRAIL`