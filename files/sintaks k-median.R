file = 'data.csv'
data = read.csv(file)
View(data)
dim(data)

#index
index = data[,c(2:7)]
rownames(index) = data$Provinsi[1:34]
names(index)
index

#identifikasi awal
summary(index)

library(PerformanceAnalytics)
chart.Correlation(index[c(-1,-6)])

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

kmedians <- function(df, k, n_iter) {
  # define manhattan distance
  manhattan_distance <- function(x, y){
    return(sum(abs(x - y)))
  }
  
  # Initialize centers randomly
  centers <- df[sample(nrow(df), k), ]
  
  # Perform n_iter iterations
  for (iter in 1:n_iter) {
    # Calculate distances
    distances <- data.frame(matrix(NA, nrow = nrow(df), ncol = k))
    for (object_id in 1:nrow(df)) {
      for (center_id in 1:nrow(centers)) {
        # Use manhattan metric.
        distances[object_id, center_id] <- manhattan_distance(df[object_id, ], centers[center_id, ])
      }
    }
    
    # Assign each point to the closest center
    cluster_id <- apply(distances, 1, which.min)
    
    # Calculate new centers
    for (i in seq_len(k)) {
      this_cluster <- df[cluster_id == i,]
      # Calculate median instead of mean
      centers[k, ] <- apply(this_cluster, 2, median)
    }
  }
  hasil = list(centers, distances, cluster_id)
  return(hasil)
}

#kmedians(index, 3, 1000)

index$cluster = c(3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2,
                  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)
index

#visualisasi cluster
# Scatter plot
jarak = c(1254315,647699,1144498,682468,536519,269634,878461,154452,135839,
          119464,105817,21118,0,22789,91031,30371,18384,10284,26474,0,
          7178,17248,25450,34421,47926,47100,51172,59758,84810,72574,101767,
          93594, 96003,97583)
kluster = c(3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2,
            2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)
provinsi = c(1:34)
kelompok = data.frame(jarak, kluster, provinsi)

# Define shapes
shapes = c(16, 17, 18) 
shapes <- shapes[as.numeric(kelompok$kluster)]

plot(kelompok$jarak,
     pch = shapes,
     col = colors,
     lwd = 0.9, cex = 1.5)

legend("topright", legend = c("cluster 1", "cluster 2", "cluster 3"),
       col =  c("#00AFBB", "#E7B800", "#FC4E07"),
       pch = c(16, 17, 18) )

text(jarak, labels = data$Provinsi, pos = 3)

#hasil
kluster1 = subset(index, cluster==1)
kluster2 = subset(index, cluster==2)
kluster3 = subset(index, cluster==3)

profil_kluster1 = sapply(kluster1, mean)
profil_kluster2 = sapply(kluster2, mean)
profil_kluster3 = sapply(kluster3, mean)

profil_kluster1
profil_kluster2
profil_kluster3

mean_total = rbind(profil_kluster1, profil_kluster2, profil_kluster3)
mean_total

#standar deviasi
kluster1 = c(165782.73, 3655.636, 161745.00, 382.0909, 65622.000,  46.36364)
kluster2 = c(43818.58, 1163.474, 42531.47, 123.6316, 3168.632, 248.36842)
kluster3 = c(1013143.50, 24516.500, 982544.00, 6083.0000, 183223.500, 260.000)

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
