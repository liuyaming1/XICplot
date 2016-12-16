library("xcms")
library("dplyr")
mzXML <- list.files("./rawdata",recursive = T,full.names = T)
xset <- xcmsSet(mzXML)
target <- read.csv("target.csv",header = T)
target<-mutate(target,mz_start=m_z-0.05,mz_end=m_z+0.05,rt_start=(RT-5)*60,rt_end=(RT+5)*60)
temple<-as.matrix(target)
mz_list<- vector("list",10)
for (i in 1:10) {
  mz_list[[i]]= t(as.matrix(temple[i,c(3,4)]))
}
rt_list<- vector("list",10)
for (i in 1:10) {
  rt_list[[i]]= t(as.matrix(temple[i,c(5,6)]))
}
XIC_list <- vector("list",10)
for (i in 1:10) {
  png(filename = paste("mz_",i,".png",sep = ""),width = 640,height = 480)
  XIC_list[[i]]= getEIC(xset,mz_list[[i]],rt_list[[i]],rt="raw")
  plot(XIC_list[[i]])
  dev.off()
}
