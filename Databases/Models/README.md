# Data Models
[Wikipedia](https://en.wikipedia.org/wiki/Data_model)

A **data model** is an abstract model that organizes elements of data and standardizes how they relate to one another and to the properties of real-world entities.

数据模型是对现实世界数据特征的抽象，是数据库系统的核心和基础。

A data model instance may be one of three kinds according to ANSI in 1975:

1. Conceptual data model
   
   Conceptual data model describes the semantics of a domain, being the scope of the model. For example, it may be a model of the interest area of an organization or industry. This consists of entity classes, representing kinds of things of significance in the domain, and relationship assertions about associations between pairs of entity classes. A conceptual schema specifies the kinds of facts or propositions that can be expressed using the model. In that sense, it defines the allowed expressions in an artificial 'language' with a scope that is limited by the scope of the model.

2. Logical data model
   
   Logical data model describes the semantics, as represented by a particular data manipulation technology. This consists of descriptions of tables and columns, object oriented classes, and XML tags, among other things.

3. Physical data model
   
   Physical data model describes the physical means by which data are stored. This is concerned with partitions, CPUs, tablespaces, and the like.

## 数据模型的组成要素
- 数据结构
  
  数据结构描述数据库的组成对象以及对象之间的联系。

- 数据操作
  
  数据操作是指对数据库中各种对象（型）的实例（值）允许执行的操作的集合，包括操作及有关的操作规则。

- 数据的完整性约束条件

  数据的完整性约束条件是一组完整性规则。完整性规则是给定的数据模型中数据及其联系所具有的制约和依存规则，用以限定符合数据模型的数据库状态以及状态的变化，以保证数据的正确、有效和相容。
  
  数据模型应该反映和规定其必须遵守的基本的和通用的完整性约束条件。

## 分类
- Conceptual model
  - E-R

- 逻辑模型
  - Flat model

    二维数组
    - CSV
  - Hierarchical model
  - Network model
  - Inverted file model
  - Relational model
  - Dimensional model
  - Graph model
    - RDF model ([Wikipedia](https://en.wikipedia.org/wiki/Resource_Description_Framework))
  - Multivalue model
  - Object model
  - Object-relational model
  - Semi-structured model ([Wikipedia](https://en.wikipedia.org/wiki/Semi-structured_model))
    - Object Exchange Model
    - Document model
      - XML
      - JSON
      - YAML
    - Registry
    - NTFS

- 物理模型

[Database model - Wikipedia](https://en.wikipedia.org/wiki/Database_model)

[NoSQL - Wikipedia](https://en.wikipedia.org/wiki/NoSQL)