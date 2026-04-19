function[ ] = affinity_hesapla()
    % Global değişkenleri çağırıyoruz ki değerleri diğer fonksiyonlarla paylaşabilelim
    global n pop Egitim Egitimc affinity_skorlari
    
    % Sözel ve mantıksal değerleri indekslemek için liste oluşturuyoruz
    kernel_listesi = {'linear', 'gaussian', 'polynomial'};
    std_listesi = {true, false};
    
    % Her bir antikorun başarı skorunu tutacak diziyi sıfırlarla başlatıyoruz (Hafıza tahsisi - hız kazandırır)
    affinity_skorlari = zeros(n, 1);
    
    % Popülasyondaki (n adet) her bir antikor (çözüm adayı) için döngü başlatıyoruz
    for i = 1:n
        
        % 1. ve 2. Sütun: Sürekli sayısal parametreler doğrudan alınıyor
        bc_val = pop(i, 1);  % BoxConstraint değeri
        ks_val = pop(i, 2);  % KernelScale değeri
        
        % 3. Sütun: Kernel indeksi hesaplanıyor
        % round: Ondalıklı AIS değerini tam sayıya çevirir.
        % min/max: Değerin mutasyonla sınır dışına (1'den küçük, 3'ten büyük) çıkmasını engeller.
        k_idx = max(1, min(3, round(pop(i, 3))));
        secilen_kernel = kernel_listesi{k_idx}; % İndekse karşılık gelen kelimeyi listeden çeker
        
        % 4. Sütun: Polinom derecesi hesaplanıyor (Sadece 2 ile 5 arası tam sayı)
        p_order = max(2, min(5, round(pop(i, 4))));
        
        % 5. Sütun: Standardizasyon indeksi hesaplanıyor (1 veya 2)
        std_idx = max(1, min(2, round(pop(i, 5))));
        secilen_std = std_listesi{std_idx}; % İndekse karşılık gelen true/false değerini çeker
        
        % SVM fonksiyonuna gönderilecek temel parametreleri bir Hücre Dizisinde (Cell Array) topluyoruz
        args = {'BoxConstraint', bc_val, 'KernelScale', ks_val, 'Standardize', secilen_std};
        
        % Kernel kontrolü: Eğer polynomial seçildiyse PolynomialOrder değerini diziye ekle
        % Seçilmediyse sadece KernelFunction ismini ekle (MATLAB'in hata vermesini engellemek için)
        if strcmp(secilen_kernel, 'polynomial')
            args = [args, {'KernelFunction', 'polynomial', 'PolynomialOrder', p_order}];
        else
            args = [args, {'KernelFunction', secilen_kernel}];
        end
        
        % Modeli, hazırladığımız dinamik argüman dizisiyle (args{:}) eğitiyoruz
        model = fitcsvm(Egitim, Egitimc, args{:}); 
        
        % Çapraz Doğrulama (Cross Validation) ile modeli 5 parçaya bölerek test ediyoruz
        cv = crossval(model, 'KFold', 5);
        
        % K-Fold hatasını bulup 1'den çıkarıyoruz. 
        % Böylece HATA oranını, BAŞARI (Affinity) oranına çevirmiş oluyoruz.
        affinity_skorlari(i) = 1 - kfoldLoss(cv);
    end
end