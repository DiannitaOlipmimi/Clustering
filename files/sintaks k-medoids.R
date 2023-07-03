file = 'data.csv'
data = read.csv(file)
#View(data)
dim(data)

#index
index = data[,c(2:6)]
rownames(index) = data$Provinsi[1:34]
names(index)
index

#identifikasi awal
summary(index)

library(PerformanceAnalytics)
chart.Correlation(index[-1])

#uji asumsi multikolinieritas
library(car)
meninggal = lm(Meninggal.Total~Sembuh.Total+Masih.Aktif+Suspek, data = index)
sembuh = lm(Sembuh.Total~Masih.Aktif+Suspek+Meninggal.Total, data = index)
masih_aktif = lm(Masih.Aktif~Suspek+Meninggal.Total+Sembuh.Total, data = index)
suspek = lm(Suspek~Meninggal.Total+Sembuh.Total+Masih.Aktif, data = index)

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
vif_value(sembuh)
vif_value(masih_aktif)
vif_value(suspek)

#k-medoids clustering
library(factoextra)
library(cluster)
pam(index, 3, metric = "euclidean", stand = FALSE)

#menentukan kluste optimal
fviz_nbclust(index, kmeans, method = "wss")
#fviz_nbclust(data_jarak, kmeans, method = "silhouette")

#pembentukan cluster
kmed = pam(index, k = 3)

#visualisasi cluster
library(ggpubr)
fviz_cluster(kmed, data = index)

#hasil
hasil = cbind(index, cluster = kmed$cluster)
hasil

kluster1 = subset(hasil, kmed$cluster==1)
kluster2 = subset(hasil, kmed$cluster==2)
kluster3 = subset(hasil, kmed$cluster==3)

kluster1
kluster2
kluster3

profil_kluster1 = sapply(kluster1, mean)
profil_kluster2 = sapply(kluster2, mean)
profil_kluster3 = sapply(kluster3, mean)

profil_kluster1
profil_kluster2
profil_kluster3

mean_total = rbind(profil_kluster1, profil_kluster2, profil_kluster3)
mean_total

#standar deviasi
kluster1 = c(1381182.50, 15974.500, 1355431.50,9776.5000, 58979.5)
kluster2 = c(501515.00, 23969.667, 475918.67, 1626.6667, 420971.3)
kluster3 = c(84200.93, 1949.172, 82029.31, 222.4483, 4623.0)

sd_kluster1 = sd(kluster1)
sd_kluster2 = sd(kluster2)
sd_kluster3 = sd(kluster3)

sd_kluster1
sd_kluster2
sd_kluster3

sw = (sd_kluster1+sd_kluster2+sd_kluster3)/3
sb = sqrt(1/2 * ((sd_kluster1-sw)^2+(sd_kluster2-sw)^2+(sd_kluster3-sw)^2))

sw
sb
