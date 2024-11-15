##不同地区每年的DV_Fel_Assault分布情况--小提琴图

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

#绘图
ggplot(data,aes(x=Report_Year,y=DV_Fel_Assault))+
  geom_violin(aes(fill=Report_Year),alpha=0.6)+
  geom_jitter(aes(color=Report_Year),width=0.2)+
  facet_grid(.~`Comm_Dist_ Boro`,scales = "free")+
  labs(x="Report Year",y="The Number of Felony Assaults that Involve Domestic Violence",fill="Report Year",color="Report Year",title="Felony Assaults with Domestic Violence in NYC, 2016-2019")+
  theme_bw()+
  theme(axis.text.x = element_text(color = "black",size=10),
        axis.text.y = element_text(color = "black",size = 10))+
  guides(fill="none")
ggsave("violin.png",width = 10,height = 5)  #保存为pdf图片

