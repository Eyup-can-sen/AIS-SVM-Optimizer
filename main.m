% YAPAY BAĞIŞIKLIK ALGORİTMASI (AIS) İLE 5 PARAMETRELİ SVM OPTİMİZASYONU
clc; clear; close all;

% Global değişkenler
global n nc pop sinir_alt sinir_us Egitim Egitimc affinity_skorlari klon_pop

% VERİ YÜKLEME
disp('--- Veri Yükleniyor ---');
veri = readtable("diabetes.csv");
data = table2array(veri);
[Egitim, Egitimc, Test, Testc] = orneklem(data); 
disp('Veri başarıyla yüklendi.');


% ADIM 1: BAŞLANGIÇ PARAMETRELERİ
n = 20;            % Antikor sayısı (Popülasyon)
iterasyon = 25;    % Nesil sayısı
nc = 5;            % Klonlama sayısı

% PARAMETRE SIRASI: [BoxConstraint, KernelScale, KernelFunction_Idx, PolynomialOrder, Standardize_Idx]
% KernelFunction : 1='linear', 2='gaussian', 3='polynomial'
% Standardize    : 1=true, 2=false
sinir_alt = [0.01, 0.01, 1, 2, 1];  
sinir_us  = [100.0, 100.0, 3, 5, 2]; 

en_iyi_hata_gecmisi = zeros(iterasyon, 1);
en_iyi_antikor_gecmisi = zeros(iterasyon, 5);

% ADIM 2: BAŞLANGIÇ POPÜLASYONUNU OLUŞTURMA
disp('--- Adım 2: Başlangıç Popülasyonu Oluşturuluyor ---');
antikor_olustur();

% ADIM 3: AIS OPTİMİZASYON DÖNGÜSÜ
disp('--- Adım 3: Optimizasyon Döngüsü Başlıyor ---');
for iter = 1:iterasyon
    fprintf('\n>>> İterasyon %d \n', iter);
    
    % 1. Doğruluk (Affinity) Hesapla
    affinity_hesapla();
    
    % 2. En İyi Antikoru Bul
    [max_aff, max_indis] = max(affinity_skorlari);
    en_iyi_hata_gecmisi(iter) = 1 - max_aff;
    en_iyi_antikor_gecmisi(iter, :) = pop(max_indis, :);
    
    fprintf('Bu neslin en düşük hatası: %.4f (Doğruluk: %%%.2f)\n', 1-max_aff, max_aff*100);
    
    % 3. Klonlama, Mutasyon ve Seçim
    if iter < iterasyon
        klonlama();
        hipermutasyon();
        secim();
    end
end

% ADIM 4: SONUÇLARI SÖZEL HALE GETİRME VE YAZDIRMA
disp('-----------------------------------------------------------');
disp('Optimizasyon Tamamlandı! En iyi hiperparametreler çözümleniyor...');

en_iyi = en_iyi_antikor_gecmisi(end, :);

% 1 ve 2: Sayısal (Sürekli)
en_iyi_bc = en_iyi(1);
en_iyi_ks = en_iyi(2);

% 3: Kernel Sözlüğü
kernel_listesi = {'linear', 'gaussian', 'polynomial'};
en_iyi_kernel_idx = round(en_iyi(3));
secilen_kernel = kernel_listesi{en_iyi_kernel_idx};

% 4: Polinom Derecesi (Sayısal, Tam Sayı)
en_iyi_p_order = round(en_iyi(4));

% 5: Standardizasyon Sözlüğü
std_listesi = {true, false};
en_iyi_std_idx = round(en_iyi(5));
secilen_std = std_listesi{en_iyi_std_idx};

fprintf('\n=== BULUNAN EN İYİ 5 SVM HİPERPARAMETRESİ ===\n');
fprintf('1. BoxConstraint   (Sayısal) : %.4f\n', en_iyi_bc);
fprintf('2. KernelScale     (Sayısal) : %.4f\n', en_iyi_ks);
fprintf('3. KernelFunction  (Sözel)   : %s\n', secilen_kernel);
if strcmp(secilen_kernel, 'polynomial')
    fprintf('4. PolynomialOrder (Sayısal) : %d\n', en_iyi_p_order);
else
    fprintf('4. PolynomialOrder (Sayısal) : %d (Sadece Polynomial kernel için geçerlidir, bu yüzden modelde kullanılmadı)\n', en_iyi_p_order);
end
if secilen_std
    fprintf('5. Standardize     (Sözel)   : true\n');
else
    fprintf('5. Standardize     (Sözel)   : false\n');
end

fprintf('Elde Edilen En Düşük Hata    : %.4f\n', en_iyi_hata_gecmisi(end));

% Öğrenme Eğrisi Grafiği
figure('Name', 'AIS SVM 5-Parametre Optimizasyonu'); 
plot(1:iterasyon, en_iyi_hata_gecmisi, 'r-o', 'LineWidth', 2, 'MarkerFaceColor', 'k');
title('AIS ile 5 Parametreli SVM Optimizasyonu');
xlabel('İterasyon (Nesil)'); ylabel('Çapraz Doğrulama Hatası (5-Fold)'); grid on;
