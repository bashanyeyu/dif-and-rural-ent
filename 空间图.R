

library(tmap)
library(sf)
library(tmap)
library(rgdal)
library(tmap)
library(tmaptools)
library(sp)
library(ggplot2)
library(grid)
setwd(getwd())


jiuduanxian=sf::read_sf("2019中国地图-审图号GS(2019)1822号\\九段线.shp")
jiuduanxian_map=tm_shape(jiuduanxian)+tm_lines(col = 'grey')
vip_map = viewport(0.91, 0.19, width = 0.28, height = 0.2)
jiuduanxian_map

xian.shp=st_read("2019中国地图-审图号GS(2019)1822号\\县（等积投影）.shp")
tm_shape(xian.shp) + tm_polygons(col = 'grey' )


sheng.shp=read_sf("2019中国地图-审图号GS(2019)1822号\\省（等积投影）.shp")
sheng.shp=as_Spatial(sheng.shp)
shengmap=tm_shape(sheng.shp) +tm_polygons()
vip_map = viewport(0.91, 0.19, width = 0.28, height = 0.2)
shengmap
ggplot(data = sheng.shp,aes(fill=省)) + 
  geom_sf(color = "black")


tm_shape(xian.shp,bbox=st_bbox(c(xmin = 82, xmax = 128, ymax = 50, ymin = 15), crs = st_crs(4326))) + tm_polygons( )+ tm_layout(frame = FALSE)
  
  
  
  tm_polygons( col = colnames(as.data.frame(xian.shp))[m],breaks=c(0,10,50,100,500,1000,2000,5000),
               title =paste0(colnames(as.data.frame(xian.shp))[m],  "申请量(件)"),
               labels = c('0-10','10-50','50-100','100-500','500-1000','1000-2000','2000-5000'))+
  tm_borders(col = "black",lwd = 1)+tm_layout(,
                                              legend.title.size = 1.3,
                                              legend.text.size = 1,
                                              legend.position = c("left","bottom"))+
  tm_fill(labels = c('0-10','10-50','50-100','100-500','500-1000','1000-2000','2000-5000'))+
  tm_scale_bar(position=c("center", "top"),just=c(0.5,0.5),text.size = 0.5)+  tm_graticules()

insetsmap=tm_shape(dishiApat,bbox=st_bbox(c(xmin = 107, xmax = 124, ymax = 24, ymin = 2.5), crs = st_crs(4326))) + 
  tm_fill( col = colnames(as.data.frame(dishiApat))[m],breaks=c(0,10,50,100,500,1000,2000,5000),legend.show = F)+tm_borders()+
  jiuduanxian_map+nanhaizhudao_map