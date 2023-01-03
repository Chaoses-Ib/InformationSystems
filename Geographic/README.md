# Geographic Information Systems
[人人都在说GIS，究竟什么才是GIS - 知乎](https://zhuanlan.zhihu.com/p/27660261)

## 什么是 GIS？它具有什么特点？ 
地理信息系统既是管理和分析空间数据的应用工程**技术**，又是跨越地球科学、信息科学和空间科学的**应用基础学科**。其技术系统由计算机硬件、软件和相关的方法过程所组成，用以支持**空间数据**的采集、管理、处理、建模、分析和显示，以便解决复杂的规划和管理问题。

特点：
1. 研究对象有地理分布特征。
2. 强调空间分析的能力。
3. 对图形操作，且图形和属性一体化管理。 
4. 是一项工程，不但取决于技术体系，还取决于工程组织体系。

## GIS 与其它相关技术有什么区别与联系？
1. GIS 与 CAD 系统的区别
   - CAD（Computer Aided Design）图形处理功能强大，制图、编辑、输出等，但属性功能很弱。
   - GIS 对图形属性综合管理，具有较强的空间分析能力。
   
   二者不能互相替代，CAD 可作为 GIS 数据采集的工具。

2. GIS 与数字地图制图的区别
   - 数字地图制图通常只对图形数据进行管理，缺少管理非图形数据的能力。
   - GIS 同时管理图形非图形数据，把两者结合起来作深层次分析。
   - 数字地图是地理信息系统重要的数据源。

3. GIS 与一般的数据管理系统的区别
   - GIS 处理的是空间数据和属性数据的综合。
   - 一般的数据库管理系统数据处理对象是非空间数据，多为关系型二维表格。
   - GIS 对计算机软硬件要求比后者高。
   - 用数据库管理系统建立的数据库可以作为地理信息系统空间数据库的属性库的数据源。

## GIS 的组成是怎样的？
- 硬件：计算机、外设、网络设备
- 软件： 计算机系统软件
  - 理信息系统软件
  - 应用分析软件
- 数据：图形和非图形数据、定性和定量数据、影像数据及多媒体数据（**核心**）
- 应用模型
- 用户、系统管理人员及界面

## GIS 的发展方向有哪些？
- 数字地球：对真实地球及其相关现象的统一性的数字化重现和认识。
- 技术集成
  - 图形与属性结合
  - GIS 与 RS 的结合
  - GIS 与 GPS 的结合
  - GIS 与 ES（专家系统）的结合

- 数据管理
  - GIS 信息的深加工
  - GIS 多源数据的无缝集成
  - GIS 数据的互操作
  - 多尺度 GIS 数据的自动综合
  - 空间数据仓库技术
  - 网络数据的存储与传输

- 软件系统的发展
  - 面向对象技术的 GIS 研究
  - 时态 GIS 或动态 GIS 的研究
  - GIS 的数学建模系统
  - 真三维 GIS 的建立
  - 网络和因特网 GIS 的建立（云 GIS）
  - 无线和移动 GIS 技术

- OpenGIS：开放的 GIS
- 组件 GIS 和 WebGIS （云）
- 超图空间数据仓库（Hypergraph）
- 实用 GIS
  - GIS 的网络化
  - GIS 的标准化
  - GIS 数据的商业化
  - GIS 的专门化、专业化
  - GIS 的企业化
  - GIS 的全球化
  - GIS 的大众化、社会化
  - GIS 的智能化

## 举例说明 GIS 可应用的行业？
- 空间基础数据建设部门：勘测测绘、遥感等
- 城市市政管理部门：规划、土地、房地产、市政水电气
- 能源部门：石油、天然气、地质
- 自然利用：农林、水利、环保
- 公众服务部门：公安、消防、紧急救援、医疗
- 金融服务部门：银行、保险
- 社会经济部门：统计局、信息中心

## Open source
[OSGeo](https://www.osgeo.org/)

## Implementations
- [ArcGIS](ArcGIS/README.md)
- SuperMap
- MapGIS
- [QGIS](https://qgis.org/en/site/) ([GitHub](https://github.com/qgis/QGIS))

## Information sources
<details><summary>Blogs</summary>

- [GIS Geography](https://gisgeography.com/)
- [GIS乱弹 - 知乎](https://www.zhihu.com/column/gisluantan)
- [麻辣GIS | 麻辣地信网 - 小而美的地理信息系统博客 - 立足GIS 放眼3S](https://malagis.com/)
- [遥感家园](https://www.rserforum.com/)
</details>

[Awesome GIS](https://github.com/sshuair/awesome-gis)