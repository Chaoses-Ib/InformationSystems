# Normalization
[Wikipedia](https://en.wikipedia.org/wiki/Database_normalization)

关系所满足的不同程度的要求称为不同的范式。

| | |
| --- | --- |
| ![](../images/Normalization/forms.png) | ![](../images/Normalization/image.png) |

[数据库范式那些事 - CareySon - 博客园](https://www.cnblogs.com/CareySon/archive/2010/02/16/1668803.html)

DEMO：…

“应用的范式等级越高，则表越多。表多会带来很多问题：
1. 查询时要连接多个表，增加了查询的复杂度
2. 查询时需要连接多个表，降低了数据库查询性能

因此，并不是应用的范式越高越好，要看实际情况而定。第三范式已经很大程度上减少了数据冗余，并且减少了造成插入异常，更新异常，和删除异常了。”

[如何理解关系型数据库的常见设计范式？ - 知乎](https://www.zhihu.com/question/24696366)

关系范式的思想也可以迁移到其它领域，比如拼音数据仓库，如果仓库同时存在源数据和结果数据，修改源数据时就会发生更新异常。

## 1NF
每一个分量必须是不可分的数据项

SQL 表并不一定满足 1NF，比如地址属性，可以拆分为省份、城市、区域、街道、门牌号。不过实际应用中这种拆分未必合适。

## 2NF
1NF $\land$ 每一个非主属性完全函数依赖于任何一个候选码

### 函数依赖（2NF、3NF、BCNF）
设 $R(U)$ 是属性集 $U$ 上的关系模式， $X,Y$ 是 $U$ 的子集。若对于 $R(U)$ 的任意一个可能的关系 $r$， $r$ 中不可能存在两个元组在 $X$ 上的属性值相等，而在 $Y$ 上的属性值不等，则称 $X$ 函数确定 $Y$ 或 $Y$ 函数依赖于 $X$，记作 $X \rightarrow Y$。

单射（一组 $Y$ 只对应一组 $X$）

$X$ 是属性集合，不是 $X$ 上值的集合

#### 非平凡函数依赖
- $X \rightarrow Y$，但 $Y \not\subseteq X$，则称 $X \rightarrow Y$ 是**非平凡的函数依赖**。
- $X \rightarrow Y$，但 $Y \subseteq X$，则称 $X \rightarrow Y$ 是**平凡的函数依赖**。对于任一关系模式，平凡函数依赖都是必然成立的，它不反应新的语义。若不特别声明，总是讨论非平凡的函数依赖。
- 若 $X \rightarrow Y$，则 $X$ 称为这个函数依赖的决定属性组，也称为**决定因素（determinant）**。
- 若 $X \rightarrow Y$， $Y \rightarrow X$，则记作 $X \leftarrow\rightarrow Y$。
- 若 $Y$ 不函数依赖于 $X$，则记作 $X \not\rightarrow Y$。

全码对应的函数依赖是平凡函数依赖

#### 完全函数依赖
在 $R(U)$ 中，如果 $X \rightarrow Y$，并且对于 $X$ 的任何一个真子集 $X'$，都有 $X' \not\rightarrow Y$，则称 $Y$ 对 $X$ **完全函数依赖**，记作
$$X \overset{F}{\rightarrow} Y$$

若 $X \rightarrow$ Y，但 $Y$ 不完全函数依赖于 $X$，则称 $Y$ 对 $X$ **部分函数依赖（partial functional dependency）**，记作
$$X \overset{P}{\rightarrow} Y$$

取决于 $X$ 的真子集能否决定 $Y$

完全函数依赖对应候选码，部分函数依赖对应超码

#### 传递函数依赖
在 $R(U)$ 中，如果 $X \rightarrow Y (Y \not\subseteq X), Y \not\rightarrow X, Y \rightarrow Z, Z \not\subseteq Y$ 则称 $Z$ 对 $X$ **传递函数依赖（transitive functional dependency）**。记为 $X \overset{传递}{\rightarrow} Z$。

这里加上条件 $Y \not\rightarrow X$，是因为如果 $Y \rightarrow X$，则 $X \leftarrow\rightarrow Y$，实际上是 $X \overset{直接}{\rightarrow} Z$，是直接函数依赖而不是传递函数依赖。

#### 函数依赖图
有关系模式 $S-L-C(Sno, Sdept, Sloc, Cno, Grade)$，其中 $Sloc$ 为学生的住处，并且每个系的学生住在同一个地方。$S-L-C$ 的码为 $(Sno,Cno)$。则函数依赖有

- $(Sno,Cno) \overset{F}{\rightarrow} Grade$
- $Sno \rightarrow Sdept, (Sno,Cno) \overset{P}{\rightarrow} Sdept$
- $Sno \rightarrow Sloc, (Sno, Cno) \overset{P}{\rightarrow} Sloc,$
- $Sdept \rightarrow Sloc$（每个系的学生只住在一个地方）

![](../images/normalization/diagram.png)

两个部分函数依赖，一个传递函数依赖。

## 3NF
设关系模式 $R<U,F>\in\text{1NF}$，若 $R$ 中不存在这样的码 $X$，属性组 $Y$ 及非主属性 $Z (Z\not\supseteq Y)$ 使得 $X\rightarrow Y, Y\rightarrow Z$ 成立， $Y \not\rightarrow X$，则称 $R<U,F>\in\text{3NF}$。

即 R 中不存在从码 X 到非主属性 Z 的传递函数依赖

## EKNF
[Elementary key normal form - Wikipedia](https://en.wikipedia.org/wiki/Elementary_key_normal_form)

## BCNF（3.5NF）
关系模式 $R<U,F>\in\text{1NF}$，若 $X \rightarrow Y$ 且 $Y \not\subseteq X$ 时 $X$ 必含有码，则 $R<U,F>\in\text{BCNF}$。

也就是说，关系模式 $R<U,F>$ 中，若每一个决定因素都包含码，则 $R<U,F>\in\text{BCNF}$。

全码必是 BCNF

## 4NF
关系模式 $R<U,F>\in\text{1NF}$，如果对于 $R$ 的每个非平凡多值依赖 $X \rightarrow\rightarrow Y(Y \not\subseteq X)$， $X$ 都含有码，则称 $R<U,F>\in\text{4NF}$。

4NF 就是限制关系模式的属性之间不允许有非平凡且非函数依赖的多值依赖。因为根据定义，对于每一个非平凡的多值依赖 $X \rightarrow\rightarrow Y$， $X$ 都含有候选码，于是就有 $X \rightarrow Y$，所以 4NF 所允许的非平凡的多值依赖实际上是函数依赖。

![](../images/Normalization/4NF.png)

$C \rightarrow\rightarrow B$，参考书多值依赖于课程  
$C \rightarrow\rightarrow T$，教师多值依赖于课程  
而码是 $(C,T,B)$，该关系模式不满足 4NF

多值依赖指的是“水平”多值依赖

### 多值依赖（4NF）
设 $R(U)$ 是属性集 $U$ 上的一个关系模式。$X,Y,Z$ 是 $U$ 的子集，并且 $Z=U-X-Y$。关系模式 $R(U)$ 中**多值依赖** $X \rightarrow\rightarrow Y$ 成立，当且仅当对 $R(U)$ 的任一关系 $r$，给定的一对 $(x,z)$ 值，有一组 $Y$ 的值，这组值仅仅决定于 $x$ 值而与 $z$ 值无关。

若 $X \rightarrow\rightarrow Y$，而 $Z=\emptyset$，即 $Z$ 为空，则称 $X \rightarrow\rightarrow Y$ 为**平凡的多值依赖**。即对于 $R(X,Y)$，如果有 $X \rightarrow\rightarrow Y$ 成立，则 $X \rightarrow\rightarrow Y$ 为平凡的多值依赖。

多值依赖的性质：
- 对称性：若 $X \rightarrow\rightarrow Y$，则 $X \rightarrow\rightarrow Z$
- 传递性：若 $X \rightarrow\rightarrow Y$， $Y \rightarrow\rightarrow Z$，则 $X \rightarrow\rightarrow Z-Y$
- 函数依赖可以看作是多值依赖的特殊情况

## 5NF（PJNF）
[第五范式 - 维基百科](https://zh.wikipedia.org/wiki/%E7%AC%AC%E4%BA%94%E8%8C%83%E5%BC%8F)

不存在非函数依赖的连接依赖

### 连接依赖（5NF）

## DKNF
[域键范式 - 维基百科](https://zh.wikipedia.org/wiki/%E5%9F%9F%E9%94%AE%E8%8C%83%E5%BC%8F)

## 6NF
[第六范式 - 维基百科](https://zh.wikipedia.org/wiki/%E7%AC%AC%E5%85%AD%E8%8C%83%E5%BC%8F)

## 关系模式分解
目标：
- 无损连接性
- 函数依赖保持性
- 更高级范式