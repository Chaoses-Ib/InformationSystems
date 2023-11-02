# Relational Databases
[Wikipedia](https://en.wikipedia.org/wiki/Relational_database)

## Relation
$D_1 \times D_2 \times \cdots \times D_n$ 的子集叫做在域 $D_1, D_2, \cdots, D_n$ 上的**关系**，表示为 $R(D_1,D_2,\cdots,D_n)$ 。

关系有三种类型：
- 基本关系（基本表）
- 查询表
- 视图表

## Keys
若关系中的某一属性组能唯一地标识一个元组，而其子集不能，则称该属性组为**候选码（candidate key）**。

若一个关系中有多个候选码，则选定其中一个为**主码（primary key）**。

候选码的各个属性称为**主属性（prime attribute）**，不包含在候选码中的属性称为非主属性或非码属性。

当候选码为关系的所有属性时，称为**全码（all-key）**。

若关系 R 中的属性组 X 不是 R 的码，但是另一个关系的码，则称 X 为 R 的**外码（foreign key）**。

## 基本关系
- 列是同质的（homogeneous），每一列中的分量是同一类型的数据
- 不同的列可出自同一个域，但要给予不同的属性名
- 列的次序可以任意交换
- 行的次序也可以任意交换
- 任意两个元组的候选码不能取相同的值
- 分量必须取原子值，即每一个分量都必须是不可分的数据项（1NF）

## 关系模式
关系模式是对关系的描述，可以表示为

$$R(U, D, DOM, F)$$

其中 $R$ 为关系名， $U$ 为属性名集合， $D$ 为属性所属的域， $DOM$ 为属性向域的映像集合， $F$ 为属性间数据的依赖关系集合。

例如 $DOM(STUDENT) = DOM(TEACHER) = PERSON$。

关系模式通常可简记为 $R(U)$ 或 $R(A_1, A_2, \cdots, A_n)$，其中域名及属性向域的映像常常直接说明为属性的类型、长度。