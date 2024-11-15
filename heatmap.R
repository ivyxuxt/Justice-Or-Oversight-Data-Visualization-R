##2018年的所有变量的Total的情况--热图

#install.packages("pheatmap")

#加载包
library(pheatmap)

#读入数据
data <- read.csv("Intimate_Partner_Violence_Related_Snapshots__New_York_City_Community_Board_Districts.csv",
                 header = T,check.names = F)
data$Report_Year <- as.character(data$Report_Year)
data <- data[data$Report_Year == "2018",]
data <- data[data$Comm_District =="Total",]   #只保留total的数据
rownames(data) <- data$`Comm_Dist_ Boro`
data <- data[,-c(1:3)]
plot <- data

for (i in 1:ncol(data)) {
  data[,i] <- sprintf("%.2e",data[,i])
}

#绘图
png("heatmap.png", width = 3400, height = 1800, res = 300)
pheatmap(plot,
         scale = "column",  
         cluster_rows = F,
         cluster_cols = F,
         border_color = NA,
         display_numbers = data,
         number_color = "black",
         color = colorRampPalette(c("#4d7358","white","#ee5d6c"))(10),  #指定热图的颜色
         main = "Intimate Partner Violence in NYC, 2018" 
         )
dev.off()


