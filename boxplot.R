##不同地区每年的所有变量分布情况--箱型图

#install.packages("reshape2")
#install.packages("ggplot2")

#加载包
library(reshape2)
library(ggplot2)

#读入数据
data <- read.csv("Intimate_Partner_Violence_Related_Snapshots__New_York_City_Community_Board_Districts.csv",
                 header = T,check.names = F)
data$Report_Year <- as.character(data$Report_Year)
data <- data[data$Comm_District !="Total",]   #删除掉total的数据
data <- melt(data,id.vars = c("Report_Year","Comm_Dist_ Boro","Comm_District"))

#绘图
ggplot(data,aes(x=Report_Year,y=value))+
  geom_boxplot(aes(fill=Report_Year),width=0.6)+
  facet_grid(variable~`Comm_Dist_ Boro`,scales = "free")+
  scale_fill_manual(values = c("#3A125B","#b77d77","#65AE81","#F0E266"))+  #指定箱型图的颜色
  labs(x="Report Year",y="Number of Crimes Reported",fill="Report Year",title="Intimate Partner Violence in NYC, 2016-2019")+
  theme_bw()+
  theme(axis.text.x = element_text(color = "black",size=10),
        axis.text.y = element_text(color = "black",size = 10))
ggsave("box.png",width = 15,height = 10)  #保存为pdf图片

