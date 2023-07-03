file = 'data 17 Januari.csv'
data = read.csv(file)

#cek data
View(data)
dim(data)
names(data)

#index
index = data[,c(2,3,6)]
rownames(index) = data$Provinsi[1:34]
names(index)
index

#identifikasi awal
summary(index)

library(PerformanceAnalytics)
chart.Correlation(index)

#uji asumsi multikolinieritas
library(car)
meninggal = lm(index$Meninggal~index$Masih.Aktif+index$Sembuh, data = index)
aktif = lm(index$Masih.Aktif~index$Sembuh+index$Meninggal, data = index)
sembuh = lm(index$Sembuh~index$Meninggal+index$Masih.Aktif, data = index)

summary(meninggal)$r.squared
summary(aktif)$r.squared
summary(sembuh)$r.squared

#membuat function untuk menghitung nilai VIF
vif_value = function(model){
  #mengambil nilai r squared
  summary_value = summary(model)
  r_squared = summary_value$r.squared
  
  #menghitung VIF
  vif_val = 1/(1-r_squared)
  print(vif_val)
}

vif_value(meninggal)
vif_value(aktif)
vif_value(sembuh)

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

#menentukan kluste optimal
fviz_nbclust(data_jarak_mat, kmeans, method = "wss")
fviz_nbclust(data_jarak_mat, kmeans, method = "silhouette")

#pembentukan cluster
kmean = kmeans(data_jarak_mat, centers = 2)
kmean$size
kmean$centers
#write.csv(kmean$centers, file = "centers.csv")

#visualisasi cluster
library(ggpubr)
fviz_cluster(kmean, data = index)

#hasil
hasil = cbind(index, cluster = kmean$cluster)
hasil
#write.csv(hasil, file = "hasil clustering.csv")

kluster1 = subset(hasil, kmean$cluster==1)
kluster2 = subset(hasil, kmean$cluster==2)

kluster1
kluster2

profil_kluster1 = sapply(kluster1, mean, ncol(kluster1))
profil_kluster2 = sapply(kluster2, mean, ncol(kluster2))

profil_kluster1
profil_kluster2

mean_total = rbind(profil_kluster1, profil_kluster2)
mean_total

#wss
kmean = kmeans(data_jarak_mat, centers = 1)
sum(kmean$withinss)

kmean = kmeans(data_jarak_mat, centers = 2)
sum(kmean$withinss)

kmean = kmeans(data_jarak_mat, centers = 3)
sum(kmean$withinss)

kmean = kmeans(data_jarak_mat, centers = 4)
sum(kmean$withinss)

kmean = kmeans(data_jarak_mat, centers = 5)
sum(kmean$withinss)
