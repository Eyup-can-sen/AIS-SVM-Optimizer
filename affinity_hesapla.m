function affinity_hesapla()
    global n pop Egitim Egitimc affinity_skorlari
    
    kernel_listesi = {'linear', 'gaussian', 'polynomial'};
    std_listesi = {true, false};
    affinity_skorlari = zeros(n, 1);
    
    for i = 1:n
        bc_val = pop(i, 1);
        ks_val = pop(i, 2);
        
        k_idx = max(1, min(3, round(pop(i, 3))));
        secilen_kernel = kernel_listesi{k_idx};
        
        p_order = max(2, min(5, round(pop(i, 4))));
        
        std_idx = max(1, min(2, round(pop(i, 5))));
        secilen_std = std_listesi{std_idx};
        
        try
            % Parametreleri listele (Eğer kernel polynomial değilse PolynomialOrder girilmemeli!)
            args = {'BoxConstraint', bc_val, 'KernelScale', ks_val, 'Standardize', secilen_std};
            if strcmp(secilen_kernel, 'polynomial')
                args = [args, {'KernelFunction', 'polynomial', 'PolynomialOrder', p_order}];
            else
                args = [args, {'KernelFunction', secilen_kernel}];
            end
            
            % Dinamik olarak üretilen parametrelerle modeli eğit
            model = fitcsvm(Egitim, Egitimc, args{:}); 
            
            cv = crossval(model, 'KFold', 5);
            affinity_skorlari(i) = 1 - kfoldLoss(cv);
        catch
            % Hatalı parametre kombinasyonlarını cezalandır
            affinity_skorlari(i) = 0.0001; 
        end
    end
end