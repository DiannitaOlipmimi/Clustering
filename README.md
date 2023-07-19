# Clustering

## 📌Table of contents
- [Definisi](https://github.com/DiannitaOlipmimi/regresi_dan_asumsinya#definition)
- [Study Case](https://github.com/DiannitaOlipmimi/regresi_linier#study-case)
- [Step by Step analysis](https://github.com/DiannitaOlipmimi/regresi_dan_asumsinya#step-by-step-analysis)
- [Result](https://github.com/DiannitaOlipmimi/regresi_dan_asumsinya#step-by-step-analysis)
- [Dataset](https://github.com/DiannitaOlipmimi/regresi_dan_asumsinya#step-by-step-analysis)
- [Links](https://github.com/DiannitaOlipmimi/regresi_dan_asumsinya#step-by-step-analysis)

## 📌Definisi

### 📒Clustering
Analisis cluster merupakan salah satu analisis multivariat yang termasuk dalam metode interdependensi, yaitu variabel bebas 𝑥 atau faktor penyebab tidak dibedakan dengan variabel terikat 𝑦 atau respon. Analisis cluster adalah suatu metode statistik yang mengidentifikasi kelompok sampel berdasarkan karakteristik serupa. Analisis cluster mengelompokkan elemen mirip sebagai objek penelitian yang mempunyai tingkat homogenitas yang tinggi antar objek menjadi cluster yang berbeda dengan tingkat heterogenitas objek yang tinggi antar cluster (Sigit, 2008). 

terdapat 2 jenis clustering yaitu,
1. clustering hierarki
Analisis kelompok merupakan teknik peubah ganda yang mempunyai tujuan utama untuk mengelompokkan objek-objek berdasarkan kemiripan karakteristik yang dimilikinya. Karakteristik objek-objek dalam suatu kelompok memiliki tingkat kemiripan yang tinggi, sedangkan karakteristik antar objek pada suatu kelompok dengan kelompok lain memiliki tingkat kemiripan yang rendah.
Kemiripan antar objek diukur dengan menggunakan ukuran jarak. Beberapa ukuran jarak yang sering digunakan antara lain jarak Euclid, jarak mahalanobis, jarak Cityblock (Manhattan), dan lain-lain.

2. clustering non hierarki
Analisis kelompok non hirarki merupakan pengelompokan objek dengan jumlah kelompok yang telah ditentukan terlebih dahulu. Pada analisis non hirarki, data yang dapat digunakan lebih besar dari analisis hirarki. Namun, analisis ini memiliki kelemahan yaitu pada data outlier atau pencilan, ukuran jarak yang digunakan, dan kerelevannan suatu variabel.

## 📌Study Case
### **Mengelompokan Provinsi di Indonesia berdasarkan kasus COVID-19 menggunakan algoritma K-Means**

### 📒 Deskripsi Masalah:
Coronavirus (CoV) merupakan keluarga besar virus RNA (Ribonucleic Acid). Virus ini dapat menyebar dengan cepat dengan sumber infeksinya adalah penderita dengan pneumonia COVID-19 (WHO, 2020).nalisis cluster merupakan salah satu analisis multivariat yang termasuk dalam metode interdependensi, yaitu variabel bebas 𝑥 atau faktor penyebab tidak dibedakan dengan variabel terikat 𝑦 atau respon.-means clustering adalah teknik pengelompokan yang berupaya untuk mempartisi N individu dalam sebuah dataset multivariate kedalam kelompok atau k kelompok. Metode K-Means sering digunakan untuk pengelompokkan data yang besar dengan asumsi tidak adanya korelasi antar variabel independen atau multikolinieritas.

### 📒 Data dan Variabel:
- **Kasus Meninggal**: Total kasus angka kematian akibat COVID-19 sejak hari pertama hingga update data baru menurut Provinsi di Indonesia
- **Kasus Masih Sakit**: Total kasus aktif atau pasien COVID-19 yang menerima perawatan sejak hari pertama hingga update data baru menurut Provinsi di Indonesia
- **Kasus Sembuh**: Total kasus angka sembuh dari COVID-19 sejak hari pertama hingga update data baru menurut Provinsi di Indonesia

### 📒 Tujuan:
Mengelompokan provinsi-provinsi di Indonesia berdasarkan banyaknya kasus COVID-19

### 📒 Langkah Analisis:
✅ *Exploratory Data Analysis* (EDA):

✅ Analisis:

✅ Evaluasi:

## 📌Step by Step Analyis
✅ Menggunakan R/Rstudio:
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

✅ Menggunakan Python:

## 📌Result

## 📌Dataset
**kasus COVID-19 per Januari 2023**
|Provinsi|Meninggal|Masih Aktif|Suspek|Probable|Sembuh|
|:----|:----|:----|:----|:----|:----|
|Yogyakarta|6079|177|0|0|223946|
|Sumatera Utara|3390|83|865|38|160211|
|Sumatera Selatan|3457|16|67444|438|81596|
|Sumatera Barat|2421|108|0|0|103127|
|Sulawesi Utara|1259|125|0|0|52986|
|Sulawesi Tenggara|586|19|0|0|25975|
|Sulawesi Tengah|1753|90|0|0|61162|
|Sulawesi Selatan|2573|45|1021|0|145946|
|Sulawesi Barat|407|5|0|0|15637|
|Riau|4546|26|0|0|150333|
|Papua Barat|394|40|0|0|32582|
|Papua|581|34|1856|64|50613|
|Nusa Tenggara Timur|1565|69|4094|0|95643|
|Nusa Tenggara Barat|938|30|0|0|36336|
|Maluku Utara|335|27|61|4|14516|
|Maluku|306|8|14069|0|18675|
|Lampung|4255|115|0|359|73805|
|Kepulauan Riau|1927|35|0|0|70060|
|Kalimantan Utara|874|8|1021|0|45265|
|Kalimantan Timur|5796|56|647979|30|208616|
|Kalimantan Tengah|1556|4|0|0|57782|
|Kalimantan Selatan|2599|46|0|0|86270|
|Kalimantan Barat|1146|55|0|0|66380|
|Jawa Timur|32271|308|100|751|604693|
|Jawa Tengah|33991|2455|614835|0|619276|
|Jawa Barat|16106|1921|8688|276|1216009|
|Jambi|915|11|190|0|38494|
|Jakarta Raya|15918|457|109271|13|1521987|
|Gorontalo|486|128|72|3|13465|
|Bengkulu|529|1|18770|0|29337|
|Banten|2987|197|1333|4|362384|
|Bangka Belitung|1652|10|14195|3397|65526|
|Bali|4875|81|0|0|167585|
|Aceh|2267|26|9970|892|42576|


## 📌Links




