

library(tmap)
library(sf)
library(tmap)
library(rgdal)
library(tmap)
library(tmaptools)
library(sp)
library(ggplot2)
library(viridis)
library(grid)
setwd(getwd())




jiuduanxian=sf::read_sf("2019中国地图-审图号GS(2019)1822号\\九段线.shp")
jiuduanxian_map=tm_shape(jiuduanxian)+tm_lines(col = 'grey')
vip_map = viewport(0.91, 0.19, width = 0.28, height = 0.2)
jiuduanxian_map

xian.shp=st_read("2019中国地图-审图号GS(2019)1822号\\县（等积投影）.shp")
xian.shp=as_Spatial(xian.shp)
xian.shp[[2]]


dif2020=openxlsx::read.xlsx('2020数字普惠金融指数.xlsx')
dif2020[,'NAME']=dif2020[,'county_name_year14']
xiandifshp=merge(xian.shp,dif2020,by='NAME',all=T,duplicateGeoms = TRUE)
xiandifshp=as_Spatial(xiandifshp)

sheng.shp=read_sf("2019中国地图-审图号GS(2019)1822号\\省（等积投影）.shp")
sheng.shp=as_Spatial(sheng.shp)
ggplot(sheng.shp)+
  geom_sf(fill=sheng.shp$省代码)




xiandifshpmap=tm_shape(xiandifshp,bbox=st_bbox(c(xmin = 82, xmax = 128, ymax = 55, ymin = 15), crs = st_crs(4326)))

xiandifshpmap+tm_polygons( fill = "index_aggregate",breaks=c(0,10,50,100,500,1000,2000,5000),
             title =paste0( "申请量(件)"),
             labels = c('0-10','10-50','50-100','100-500','500-1000','1000-2000','2000-5000'))



tm_shape(xian.shp,) + tm_polygons(col = xian.shp$index_aggregate,breaks=c(0,10,50,100,500,1000,2000,5000))+ tm_layout(frame = FALSE)



ggplot(xiandifshp,aes(fill = `index_aggregate`))+
  geom_sf()+
  scale_color_gradient2(low = "#dd8a0b",high = "#32a676")


  tm_borders(col = "black",lwd = 1)+tm_layout(,
                                              legend.title.size = 1.3,
                                              legend.text.size = 1,
                                              legend.position = c("left","bottom"))+
  tm_fill(labels = c('0-10','10-50','50-100','100-500','500-1000','1000-2000','2000-5000'))+
  tm_scale_bar(position=c("center", "top"),just=c(0.5,0.5),text.size = 0.5)+  tm_graticules()

insetsmap=tm_shape(dishiApat,bbox=st_bbox(c(xmin = 107, xmax = 124, ymax = 24, ymin = 2.5), crs = st_crs(4326))) + 
  tm_fill( col = colnames(as.data.frame(dishiApat))[m],breaks=c(0,10,50,100,500,1000,2000,5000),legend.show = F)+tm_borders()+
  jiuduanxian_map+nanhaizhudao_map