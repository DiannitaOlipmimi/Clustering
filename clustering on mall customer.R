data=read.csv(file.choose(), header = TRUE, sep = ",")

# pengecekan data
dim(data)
names(data)

# missing value 
sum(is.na(data)) # total keseluruhan NA bila ada
colSums(is.na(data)) # total NA per kolom

# Statistik Deskriptif 
#install.packages("pastecs")
library(pastecs)
stat.desc(data)

# Data wrangling
data$Gender=as.factor(data$Gender)

#EDA
library(tidyverse)
library(ggplot2)

#install.packages('epiDisplay')
library(epiDisplay)
tab1(data$Gender, sort.group = "decreasing", cum.percent = TRUE, graph = F)

names(data)
# scatter plot
plot1 = ggplot(data, aes(x=Age, y=Annual.Income..k..))+geom_point()+geom_smooth(method = lm)+ggtitle("Age vs Annual Income")
plot2 = ggplot(data, aes(x=Age, y=Spending.Score..1.100.))+geom_point()+geom_smooth(method = lm)+ggtitle("Age vs Spending Score")
plot3 = ggplot(data, aes(x=Annual.Income..k.., y=Spending.Score..1.100.))+geom_point(method = lm)+geom_smooth()+ggtitle("Spending Score vs Annual Income")

library(gridExtra)
grid.arrange(plot1, plot2, 
             plot3, 
             nrow = 2, ncol = 2)

# bar plot
plot4 = ggplot(data, aes(x = Age)) + geom_bar(aes(fill = Gender))
plot5 =ggplot(data, aes(x = Spending.Score..1.100.)) + geom_bar(aes(fill = Gender))

# Data Wrangling
# Encoding data
data$Gender=as.numeric(data$Gender)

names(data)

# Mendeteksi Outlier
plot6=ggplot(data, aes(x=Age)) + geom_boxplot(fill='blue')+coord_flip()
plot7=ggplot(data, aes(x=Annual.Income..k..)) + geom_boxplot(fill='blue')+coord_flip()
plot8=ggplot(data, aes(x=Spending.Score..1.100.)) + geom_boxplot(fill='blue')+coord_flip()

grid.arrange(plot6, plot7, 
             plot8, 
             nrow = 2, ncol = 2)

# mencari limit outlier
upper_limit = quantile(data$Annual.Income..k..,0.75)+1.5*IQR(data$Annual.Income..k..)
lower_limit = quantile(data$Annual.Income..k..,0.25)-1.5*IQR(data$Annual.Income..k..)

# mencari letak outlier pada data
outlier=data[!(data$Annual.Income..k.. > lower_limit & data$Annual.Income..k.. < upper_limit),]
outlier

# membuat data baru tanpa outlier
new_data=data[!(data$Annual.Income..k.. < lower_limit & data$Annual.Income..k.. > upper_limit),]
head(new_data)

# Matriks korelasi
library(PerformanceAnalytics)
chart.Correlation(new_data, histogram = TRUE, method = "pearson")

#index
index = new_data[,c(2:5)]
rownames(index) = data$CustomerID
names(index)
head(index)

#uji asumsi multikolinieritas
library(car)

Gender=lm(index$Gender~index$Age+index$Annual.Income..k..+index$Spending.Score..1.100., new_data = index)
age=lm(index$Age~index$Gender+index$Annual.Income..k..+index$Spending.Score..1.100., new_data = index)
annual=lm(index$Annual.Income..k..~index$Spending.Score..1.100.+index$Age+index$Gender, new_data = index)
spending=lm(index$Spending.Score..1.100.~index$Age+index$Gender+index$Annual.Income..k.., new_data = index)

#membuat function untuk menghitung nilai VIF
vif_value = function(model){
  #mengambil nilai r squared
  summary_value = summary(model)
  r_squared = summary_value$r.squared
  
  #menghitung VIF
  vif_val = 1/(1-r_squared)
  print(vif_val)
}

vif_value(Gender)
vif_value(age)
vif_value(annual)
vif_value(spending)

#standarisasi data
data_standarisasi = scale(index)
data_standarisasi_mat = as.matrix(data_standarisasi)
#View(data_standarisasi_mat)
#write.csv(data_standarisasi_mat, file = "standarisasi.csv")

#k-means clustering
#menghitung jarak antar pengamatan
library(factoextra)
data_jarak = get_dist(index)
data_jarak_mat = as.matrix(data_jarak)

#menentukan kluster optimal
fviz_nbclust(data_jarak_mat, kmeans, method = "wss")
fviz_nbclust(data_jarak_mat, kmeans, method = "silhouette")

#pembentukan cluster
kmean = kmeans(data_jarak_mat, centers = 5)
kmean$size
kmean$centers
#write.csv(kmean$centers, file = "centers.csv")

#visualisasi cluster
library(ggpubr)
fviz_cluster(kmean, new_datadata = index, ggtheme = theme_minimal())

#hasil
hasil = cbind(index, cluster = kmean$cluster)
hasil
#write.csv(hasil, file = "hasil clustering.csv")

kluster1 = subset(hasil, kmean$cluster==1)
kluster2 = subset(hasil, kmean$cluster==2)
kluster3 = subset(hasil, kmean$cluster==3)
kluster4 = subset(hasil, kmean$cluster==4)
kluster5 = subset(hasil, kmean$cluster==5)

profil_kluster1 = sapply(kluster1, mean, ncol(kluster1))
profil_kluster2 = sapply(kluster2, mean, ncol(kluster2))
profil_kluster3 = sapply(kluster3, mean, ncol(kluster3))
profil_kluster4 = sapply(kluster4, mean, ncol(kluster4))
profil_kluster5 = sapply(kluster5, mean, ncol(kluster5))

mean_total = rbind(profil_kluster1, profil_kluster2, profil_kluster3, profil_kluster4,
                   profil_kluster5)
mean_total
