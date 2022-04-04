
library(RSelenium)

ff=remoteDriver(browserName = "firefox")
ff$open()
ff$navigate('https://www.tianyancha.com/advance/search/e-pc_homeicon#rollback')
# 不可以登录 但是仍然可以进行各项指标的筛选