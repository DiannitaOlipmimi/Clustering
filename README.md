# K-Means Clustering on Mall Customer

**Clustering**

Analisis cluster merupakan salah satu analisis multivariat yang termasuk dalam metode interdependensi, yaitu variabel bebas 𝑥 atau faktor penyebab tidak dibedakan dengan variabel terikat 𝑦 atau respon. Analisis cluster adalah suatu metode statistik yang mengidentifikasi kelompok sampel berdasarkan karakteristik serupa. Analisis cluster mengelompokkan elemen mirip sebagai objek penelitian yang mempunyai tingkat homogenitas yang tinggi antar objek menjadi cluster yang berbeda dengan tingkat heterogenitas objek yang tinggi antar cluster (Sigit, 2008). 

terdapat 2 jenis clustering yaitu,
1. clustering hierarki
Analisis kelompok merupakan teknik peubah ganda yang mempunyai tujuan utama untuk mengelompokkan objek-objek berdasarkan kemiripan karakteristik yang dimilikinya. Karakteristik objek-objek dalam suatu kelompok memiliki tingkat kemiripan yang tinggi, sedangkan karakteristik antar objek pada suatu kelompok dengan kelompok lain memiliki tingkat kemiripan yang rendah.
Kemiripan antar objek diukur dengan menggunakan ukuran jarak. Beberapa ukuran jarak yang sering digunakan antara lain jarak Euclid, jarak mahalanobis, jarak Cityblock (Manhattan), dan lain-lain.

2. clustering non hierarki
Analisis kelompok non hirarki merupakan pengelompokan objek dengan jumlah kelompok yang telah ditentukan terlebih dahulu. Pada analisis non hirarki, data yang dapat digunakan lebih besar dari analisis hirarki. Namun, analisis ini memiliki kelemahan yaitu pada data outlier atau pencilan, ukuran jarak yang digunakan, dan kerelevannan suatu variabel.

⛳Context:

This data set is created only for the learning purpose of the customer segmentation concepts , also known as market basket analysis . I will demonstrate this by using unsupervised ML technique (KMeans Clustering Algorithm) in the simplest form.

⛳Content:

You are owing a supermarket mall and through membership cards , you have some basic data about your customers like Customer ID, age, gender, annual income and spending score.
Spending Score is something you assign to the customer based on your defined parameters like customer behavior and purchasing data.

⛳Deskripsi Masalah:
You own the mall and want to understand the customers like who can be easily converge [Target Customers] so that the sense can be given to marketing team and plan the strategy accordingly.

⛳Tujuan:

Melakukan segmentasi dengan menggunakan algoritma K-Means pada customer mall

## 📌Table of contents
- [Dataset dan Variabel](https://github.com/DiannitaOlipmimi/Clustering_on_Mall_Customer#data-dan-variabel)
- [Result](https://github.com/DiannitaOlipmimi/Clustering_on_Mall_Customer#result)
- [Links](https://github.com/DiannitaOlipmimi/Clustering_on_Mall_Customer#links)


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
- `CustomerID`
- `Gender`
- `Age`
- `Annual Income (k$)`
- `Spending Score (1-100)`

## 🧵Result

✅ Data Preparation:
1. Memuat data kasus COVID-19
2. Melakukan pemilihan variabel yang digunakan
3. Melakukan Identifikasi awal menggunakan matriks korelasi
Handle missing values, if any, by imputing them or removing the corresponding records.

✅ Exploratory Data Analysis (EDA):
1. Membuat scatter plot untuk melihat hubungan masing-masing variabel

    

    berdasarkan plot yang terbentuk:
    - Age VS Annual Income memiliki hubungan yang lemah bahkan hampir tidak ada
    - Age VS Spending Score memiliki hubungan yang lemah negatif, dimana semakin besar `Age` atau usia maka semakin kecil `Spending Score` atau nilai pengeluarannya
    - Spending Csore VS Annual Income memiliki hubungn yang lemah

2. Membuat Bar plot untuk melihat lebih jauh mengenai variabel 

    

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

## 🧵Links

📊 Kaggle Dataset

https://www.kaggle.com/datasets/vjchoudhary7/customer-segmentation-tutorial-in-python

📊github dataset knowledgement

https://github.com/SteffiPeTaffy/machineLearningAZ/blob/master/Machine%20Learning%20A-Z%20Template%20Folder/Part%204%20-%20Clustering/Section%2025%20-%20Hierarchical%20Clustering/Mall_Customers.csv


