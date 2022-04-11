
dif=openxlsx::read.xlsx("D:\\WPS Office\\WPS Cloud Files\\博士论文开题\\乡村企业的生存与发展问题研究\\基于河南省的初步研究结果\\北京大学数字普惠金融指数（PKU-DFIIC）2011_2020.xlsx",6)

library(reshape2)
colnames(dif)
each.index=dcast(dif,county_name_year14+county_code_year14~year,value.var = 'index_aggregate')
apply(8:17, 1,function(n){
  each.index=dcast(dif,county_name_year14+county_code_year14~year,value.var = dif[,n])
  
})

library(dplyr)
library(table1)
library(rvest)
for (n in 8:17) {
  each.index=dcast(dif,county_name_year14+county_code_year14~year,value.var = colnames(dif)[n])
  openxlsx::write.xlsx( each.index,file =paste0('分县历年',colnames(dif)[n],'指数.xlsx'))
}
summary(filter(dif,prov_name=='河南省',))
henandesc=table1(~ index_aggregate +coverage_breadth +usage_depth+digitization_level|year, data=filter(dif,prov_name=='河南省',!grepl('区',county_name_year14),year>2010), overall = F)

library(flextable)
library(magrittr)
t1flex(henandesc) %>% 
  save_as_docx(path="henandesc.docx")
tbl1<- table1(~Sepal.Length+Sepal.Width|Species,data=iris)
flextable(summary(filter(dif,prov_name=='河南省',!grepl('区',county_name_year14),year>2010)))
summary(filter(dif,prov_name=='河南省',!grepl('区',county_name_year14),year>2010))
func <- function(x)(c(n = length(x),mean=mean(x,na.rm = T),max = max(x,na.rm = T), min = min(x,na.rm = T),sd=sd(x,na.rm = T),cv=sd(x,na.rm = T)/mean(x,na.rm = T)*100))
aggregate(index_aggregate~year,
          filter(dif,prov_name=='河南省',!grepl('区',county_name_year14),year>2010),func)
t1kable(henandesc)
as.data.frame(henandesc) %>% html_table(fill = T)
