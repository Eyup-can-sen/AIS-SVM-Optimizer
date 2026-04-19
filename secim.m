function [ ] = secim()
    % Global değişkenleri çağırıyoruz.
    global n pop klon_pop Egitim Egitimc affinity_skorlari
    
    % 1. Arenayı Kur (Havuzları Birleştir)
    % Eski popülasyon ile yeni klonları alt alta ekleyerek dev bir geçici havuz oluşturuyoruz.
    gecici_pop = [pop; klon_pop];
    
    % Bu birleşik havuzda toplam kaç antikor olduğunu buluyoruz.
    toplam = size(gecici_pop, 1);
    
    % Her birinin skorunu tutmak için hafızada yer ayırıyoruz.
    affs = zeros(toplam, 1);
    
    % Sözel/Mantıksal çeviriciler
    kernel_listesi = {'linear', 'gaussian', 'polynomial'};
    std_listesi = {true, false};
    
    % 2. Birleşik Havuzdaki Her Antikoru Test Et
    for i = 1:toplam
        
        % Sayısal ve Sözel/Mantıksal dönüşümleri (affinity_hesapla fonksiyonundaki gibi) yapıyoruz
        bc_val = gecici_pop(i, 1);
        ks_val = gecici_pop(i, 2);
        
        k_idx = max(1, min(3, round(gecici_pop(i, 3))));
        secilen_kernel = kernel_listesi{k_idx};
        
        p_order = max(2, min(5, round(gecici_pop(i, 4))));
        
        std_idx = max(1, min(2, round(gecici_pop(i, 5))));
        secilen_std = std_listesi{std_idx};
        
        % Argüman paketini hazırlıyoruz
        args = {'BoxConstraint', bc_val, 'KernelScale', ks_val, 'Standardize', secilen_std};
        
        if strcmp(secilen_kernel, 'polynomial')
            args = [args, {'KernelFunction', 'polynomial', 'PolynomialOrder', p_order}];
        else
            args = [args, {'KernelFunction', secilen_kernel}];
        end
        
        % SVM modelini bu hiperparametrelerle eğitiyoruz
        m = fitcsvm(Egitim, Egitimc, args{:});
            
        % 5-Fold Cross Validation ile modeli test edip uygunluk (başarı) skorunu affs dizisine kaydediyoruz
        cv = crossval(m, 'KFold', 5);
        affs(i) = 1 - kfoldLoss(cv);
    end
    
    % 3. En İyileri Seç (Elitizm)
    % Tüm havuzun skorlarını büyükten küçüğe sıralayıp orijinal indekslerini 's_idx' değişkenine alıyoruz.
    [~, s_idx] = sort(affs, 'descend');
    
    % Geçici havuzdan sadece en yüksek skora sahip ilk 'n' (örneğin 20) antikoru seçip,
    % bir sonraki iterasyonda kullanılacak olan YENİ ana popülasyonu belirliyoruz.
    pop = gecici_pop(s_idx(1:n), :);
    
    % Seçilen bu elit grubun skorlarını da yeni neslin skorları olarak kaydediyoruz.
    affinity_skorlari = affs(s_idx(1:n));
end