#K-Means Clustering on Mall Customer

**Clustering**

Analisis cluster merupakan salah satu analisis multivariat yang termasuk dalam metode interdependensi, yaitu variabel bebas 𝑥 atau faktor penyebab tidak dibedakan dengan variabel terikat 𝑦 atau respon. Analisis cluster adalah suatu metode statistik yang mengidentifikasi kelompok sampel berdasarkan karakteristik serupa. Analisis cluster mengelompokkan elemen mirip sebagai objek penelitian yang mempunyai tingkat homogenitas yang tinggi antar objek menjadi cluster yang berbeda dengan tingkat heterogenitas objek yang tinggi antar cluster (Sigit, 2008). 

terdapat 2 jenis clustering yaitu,
1. clustering hierarki
Analisis kelompok merupakan teknik peubah ganda yang mempunyai tujuan utama untuk mengelompokkan objek-objek berdasarkan kemiripan karakteristik yang dimilikinya. Karakteristik objek-objek dalam suatu kelompok memiliki tingkat kemiripan yang tinggi, sedangkan karakteristik antar objek pada suatu kelompok dengan kelompok lain memiliki tingkat kemiripan yang rendah.
Kemiripan antar objek diukur dengan menggunakan ukuran jarak. Beberapa ukuran jarak yang sering digunakan antara lain jarak Euclid, jarak mahalanobis, jarak Cityblock (Manhattan), dan lain-lain.

2. clustering non hierarki
Analisis kelompok non hirarki merupakan pengelompokan objek dengan jumlah kelompok yang telah ditentukan terlebih dahulu. Pada analisis non hirarki, data yang dapat digunakan lebih besar dari analisis hirarki. Namun, analisis ini memiliki kelemahan yaitu pada data outlier atau pencilan, ukuran jarak yang digunakan, dan kerelevannan suatu variabel.

⛳Deskripsi Masalah:


⛳Tujuan:

Mengelompokan Provinsi di Indonesia berdasarkan kasus COVID-19 menggunakan algoritma K-Means

## 📌Table of contents
- [Dataset dan Variabel](https://github.com/DiannitaOlipmimi/regresi_dan_asumsinya#step-by-step-analysis)
- [Result](https://github.com/DiannitaOlipmimi/regresi_dan_asumsinya#step-by-step-analysis)
- [Links](https://github.com/DiannitaOlipmimi/regresi_dan_asumsinya#step-by-step-analysis)


## 🧵Data dan Variabel:

**📒Dataset:**

| CustomerID | Gender | Age | Annual Income (k$) | Spending Score (1-100) |
| ---------- | ------ | --- | ------------------ | ---------------------- |
| 1          | Male   | 19  | 15                 | 39                     |
| 2          | Male   | 21  | 15                 | 81                     |
| 3          | Female | 20  | 16                 | 6                      |
| 4          | Female | 23  | 16                 | 77                     |
| 5          | Female | 31  | 17                 | 40                     |

**📒Variabel:**


## 🧵Result
**📒 Langkah Analisis:**

✅ Data Preparation:
1. Memuat data kasus COVID-19
2. Melakukan pemilihan variabel yang digunakan
3. Melakukan Identifikasi awal menggunakan matriks korelasi
Handle missing values, if any, by imputing them or removing the corresponding records.

✅Feature Scaling:
1. Melakukan standarisasi data agar hasil clustering K-means menjadi lebih tepat
2. Menggunakan *Elbow method* untuk menentukan berapa banyak k cluster yang paling optimal
3. Memilih k cluster menggunakan plot *sum of square distances*

✅K-Means Clustering:
1. Menggunakan jumlah k cluster yang didapatkan pada *elbow method* pada algoritma K-means 
2. Memilah masing-masing cluster yang dihasilkan beserta anggotanya
3. Menghitung *centroid* masing-masing cluster yang telah dihasilkan untuk dianalsis lebih lanjut

✅Evaluasi:
1. Menganalisis karakteristik atau kesamaan dari setiap cluster
2. Menghitung statistik deskriptif dari maisng-masing cluster untuk mendapatkan nilai-nilai seperti rata-rata
3. Memvisualisasikan cluster untuk memudahkan gambaran penempatan cluster berdasarkan *sum of square distances*
4. Interpretasi masing-masing cluster

**✅ Menggunakan R/Rstudio:**
```R
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
```

## 🧵Links



