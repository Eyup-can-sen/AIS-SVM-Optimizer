# SVM Hyperparameter Optimization using Artificial Immune System (AIS)
## Yapay Bağışıklık Algoritması (YBA/AIS) ile SVM Hiperparametre Optimizasyonu

This project implements a metaheuristic approach to optimize the hyperparameters of a Support Vector Machine (SVM) model using the **Artificial Immune System (AIS)** algorithm on the **Pima Indians Diabetes Database**.

Bu proje, **Pima Indians Diabetes** veri seti üzerinde çalışan bir Destek Vektör Makinesi (SVM) modelinin hiperparametrelerini, **Yapay Bağışıklık Algoritması (AIS)** kullanarak optimize eden meta-sezgisel bir yaklaşım sunmaktadır.

---

## 🇹🇷 Türkçe Açıklama

### Proje Özeti
Makine öğrenmesi modellerinde manuel parametre araması yerine, biyolojik bağışıklık sisteminin mekanizmalarından esinlenen AIS algoritması kullanılmıştır. Optimizasyon sonucunda 5-Fold Cross Validation (Çapraz Doğrulama) hatası minimize edilerek en iyi model konfigürasyonu bulunur.

### Optimize Edilen 5 Hiperparametre:
1. **BoxConstraint**: Hata toleransını belirleyen sürekli değer.
2. **KernelScale**: Çekirdek fonksiyonu yayılım parametresi.
3. **KernelFunction**: Çekirdek tipi (`linear`, `gaussian`, `polynomial`).
4. **PolynomialOrder**: Polinom çekirdek derecesi (2-5).
5. **Standardize**: Veri ölçeklendirme durumu (`true`, `false`).

### 📂 Dosya Yapısı
* `main.m`: Optimizasyon döngüsünü yöneten ana dosya.
* `antikor_olustur.m`: Başlangıç antikor popülasyonunu üretir.
* `affinity_hesapla.m`: Uygunluk (affinity) skorlarını hesaplar.
* `klonlama.m`: En iyi antikorları kopyalar.
* `hipermutasyon.m`: Klonlar üzerinde rastgele mutasyon gerçekleştirir.
* `secim.m`: Yeni nesle geçecek antikorları seçer.
* `orneklem.m`: Veriyi eğitim/test olarak ayıran yardımcı fonksiyon (Ders sorumlusu tarafından hazırlanmıştır).

### 📊 Veri Seti
Projeler kullanılan veri setine aşağıdaki bağlantıdan ulaşabilirsiniz:
[Pima Indians Diabetes Database](https://www.kaggle.com/code/nancyalaswad90/diabetes-database/input)

---

## 🇺🇸 English Description

### Project Overview
Instead of manual parameter search, the AIS algorithm, inspired by the mechanisms of the biological immune system, is used to find optimal hyperparameters. The objective is to minimize the 5-Fold Cross Validation error to achieve the best model performance.

### Optimized Hyperparameters:
1. **BoxConstraint**: Continuous value for error tolerance.
2. **KernelScale**: Kernel function spread parameter.
3. **KernelFunction**: Type of kernel (`linear`, `gaussian`, `polynomial`).
4. **PolynomialOrder**: Degree for the polynomial kernel (2-5).
5. **Standardize**: Data scaling flag (`true`, `false`).

### 📂 File Structure
* `main.m`: The main script that runs the optimization loop.
* `antikor_olustur.m`: Generates the initial antibody population.
* `affinity_hesapla.m`: Calculates the affinity (fitness) scores.
* `klonlama.m`: Clones the best-performing antibodies.
* `hipermutasyon.m`: Performs random mutation on clones.
* `secim.m`: Selects the survivors for the next generation.
* `orneklem.m`: Data sampling function (Provided by the instructor).

### 📊 Dataset
You can access the dataset used in this project here:
[Pima Indians Diabetes Database](https://www.kaggle.com/code/nancyalaswad90/diabetes-database/input)

---

## 📈 Sample Output / Örnek Çıktı

**🇬🇧 EN:** Below is a sample output of the algorithm optimizing hyperparameters over 25 generations.
**🇹🇷 TR:** Aşağıda algoritmanın 25 nesil boyunca hiperparametreleri optimize ettiği örnek bir çalışma çıktısı bulunmaktadır.

```text
--- Adım 3: Optimizasyon Döngüsü Başlıyor ---

>>> İterasyon 1 
Bu neslin en düşük hatası: 0.2175 (Doğruluk: %78.25)
...
>>> İterasyon 12 
Bu neslin en düşük hatası: 0.2082 (Doğruluk: %79.18)
...
>>> İterasyon 19 
Bu neslin en düşük hatası: 0.2063 (Doğruluk: %79.37)
...
>>> İterasyon 25 
Bu neslin en düşük hatası: 0.2100 (Doğruluk: %79.00)

=== BULUNAN EN İYİ 5 SVM HİPERPARAMETRESİ ===
1. BoxConstraint   (Sayısal) : 89.1488
2. KernelScale     (Sayısal) : 91.7941
3. KernelFunction  (Sözel)   : polynomial
4. PolynomialOrder (Sayısal) : 4
5. Standardize     (Sözel)   : true
Elde Edilen En Düşük Hata    : 0.2100
```

---

## 🚀 Usage / Kullanım
1. Clone the repository / Repoyu klonlayın.
2. Ensure all `.m` files and `diabetes.csv` are in the same folder / Tüm dosyaların aynı klasörde olduğundan emin olun.
3. Run `main.m` in MATLAB / MATLAB üzerinde `main.m` dosyasını çalıştırın.

**Author / Yazar:** Eyüp Can