# Digital Elevation Model
A **digital elevation model (数字高程模型, DEM)** or **digital surface model (数字表面模型, DSM)** is a 3D computer graphics representation of elevation data to represent terrain or overlaying objects, commonly of a planet, moon, or asteroid. A "global DEM" refers to a discrete global grid. DEMs are used often in GIS, and are the most common basis for digitally produced relief maps.

A **digital terrain model (数字地形模型, DTM)** represents specifically the ground surface while DEM and DSM may represent tree top canopy or building roofs. While a DSM may be useful for landscape modeling, city modeling and visualization applications, a DTM is often required for flood or drainage modeling, land-use studies, geological applications, and other applications, and in planetary science.[^wiki]

DEM 的核心是地形表面特征点的三维坐标数据和一套对地表提供连续描述的算法，即：

$$Z=f(x,y)$$

## Triangulated irregular network
DEM 可以使用 **triangulated irregular network (不规则三角网, TIN)** 进行构建，常使用 [Delaunay triangulation](https://en.wikipedia.org/wiki/Delaunay_triangulation)。

[^wiki]: [Digital elevation model - Wikipedia](https://en.wikipedia.org/wiki/Digital_elevation_model)