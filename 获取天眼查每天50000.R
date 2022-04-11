
library(RSelenium)
library(dplyr)

ff=remoteDriver(browserName = "firefox")
ff$open()
ff$navigate('https://www.tianyancha.com/')
# 先在首页登录，再打开高级检索

ff$navigate('https://www.tianyancha.com/advance/search/e-pc_homeicon#rollback')


#设置开始、结束日期
fc=function(starttime,endtime){
  retTimeStart=ff$findElement("retTimeStart",using ='id') 
retTimeStart$executeScript(paste0("document.getElementById('retTimeStart').value='",starttime,"';"))

retTimeEnd=ff$findElement("retTimeEnd",using ='id') 
retTimeEnd$executeScript(paste0("document.getElementById('retTimeEnd').value='",endtime,"';"))

riqiqueding=ff$findElement("/html/body/div[2]/div/div/div[2]/div[6]/div[2]/div[6]/div[3]",using = 'xpath')
riqiqueding$clickElement()

}

st=as.Date('2010-01-01')
et=as.Date('2011-12-31')
fc(st,et)


click.result.num=ff$findElement("click-result-num",using ='id') 
while (click.result.num$getElementText()[[1]]<5000) {
  
  if(click.result.num$getElementText()[[1]]<3000){ et=et+100}
  if(click.result.num$getElementText()[[1]]<4000){ et=et+70}
  et=et+10
  fc(st,et)
  click.result.num=ff$findElement("click-result-num",using ='id')
  print(et)
  print(click.result.num$getElementText()[[1]])
  Sys.sleep(5)
  if(click.result.num$getElementText()[[1]]>5000){
    fc(st,et-10)
  }
}
baocunxx=ff$findElement("/html/body/div[2]/div/div/div[3]/div/div[2]/div[2]",using = 'xpath')
baocunxx$clickElement()
xxmingzi=ff$findElement("/html/body/div[7]/div[2]/div/div[2]/div[1]/div[2]/input",using = 'xpath')
xxmingzi$clickElement()
xxmingzi$sendKeysToElement(list(et-10,key='enter'))



st=et-10+1
et=et+150
if(et>as.Date('2021-12-31')){et='2021-12-31'}else{
  # ff$executeScript('alert("+150超过2021年了!")')
  
}
fc(st,et)
click.result.num=ff$findElement("click-result-num",using ='id') 
Sys.sleep(6)
while (as.numeric(click.result.num$getElementText()[[1]])<5000) {
  
  if(click.result.num$getElementText()[[1]]<3000){ et=et+100}
  # if(click.result.num$getElementText()[[1]]<4000){ et=et+70}
  et=et+10
  fc(st,et)
  click.result.num=ff$findElement("click-result-num",using ='id')
  Sys.sleep(5)
  print(et)
  print(click.result.num$getElementText()[[1]])
  
  if(click.result.num$getElementText()[[1]]>5000){
    fc(st,et-10)
  }
}
Sys.sleep(3)
baocunxx=ff$findElement("/html/body/div[2]/div/div/div[3]/div/div[2]/div[2]",using = 'xpath')
baocunxx$clickElement()
Sys.sleep(3)
xxmingzi=ff$findElement("/html/body/div[7]/div[2]/div/div[2]/div[1]/div[2]/input",using = 'xpath')
xxmingzi$clickElement()
xxmingzi$sendKeysToElement(list(et-10,key='enter'))

