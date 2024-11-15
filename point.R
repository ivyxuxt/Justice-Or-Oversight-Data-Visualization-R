##Brooklyn地区的所有变量的情况--气泡图

#install.packages("reshape2")
#install.packages("ggplot2")

#加载包
library(reshape2)
library(ggplot2)

#读入数据
data <- read.csv("Intimate_Partner_Violence_Related_Snapshots__New_York_City_Community_Board_Districts.csv",
                 header = T,check.names = F)
data$Report_Year <- as.character(data$Report_Year)
data <- data[data$`Comm_Dist_ Boro` == "Brooklyn",]
data <- data[data$Comm_District !="Total",]   #删除total的数据
data <- data[,-c(2)]
data <- melt(data,id.vars = c("Report_Year","Comm_District"))
data$Comm_District <- factor(data$Comm_District,levels = rev(unique(data$Comm_District)))

#绘图
ggplot(data,aes(x=Report_Year,y=Comm_District))+
  geom_point(aes(color=log10(value+1),size=value))+
  facet_grid(. ~ variable)+
  scale_size_continuous(range = c(2,10))+
  scale_color_gradient(low = "#fffeb3",high = "#ae0001",breaks=c(1,2,3,4),
                       labels = c("1e1","1e2","1e3","1e4"))+
  labs(x="Report Year",y="Log of Crime Reported",color="",size="",title="Intimate Partner Violence in Brooklyn, NYC, 2016-2019")+
  theme_bw()+
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"))
ggsave("point.png",width = 15,height = 8)


