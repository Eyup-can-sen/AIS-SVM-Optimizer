function secim()
    global n pop klon_pop Egitim Egitimc affinity_skorlari
    gecici_pop = [pop; klon_pop];
    toplam = size(gecici_pop, 1);
    affs = zeros(toplam, 1);
    
    kernel_listesi = {'linear', 'gaussian', 'polynomial'};
    std_listesi = {true, false};
    
    for i = 1:toplam
        try
            bc_val = gecici_pop(i, 1);
            ks_val = gecici_pop(i, 2);
            k_idx = max(1, min(3, round(gecici_pop(i, 3))));
            secilen_kernel = kernel_listesi{k_idx};
            p_order = max(2, min(5, round(gecici_pop(i, 4))));
            std_idx = max(1, min(2, round(gecici_pop(i, 5))));
            secilen_std = std_listesi{std_idx};
            
            args = {'BoxConstraint', bc_val, 'KernelScale', ks_val, 'Standardize', secilen_std};
            if strcmp(secilen_kernel, 'polynomial')
                args = [args, {'KernelFunction', 'polynomial', 'PolynomialOrder', p_order}];
            else
                args = [args, {'KernelFunction', secilen_kernel}];
            end
            
            m = fitcsvm(Egitim, Egitimc, args{:});
                
            cv = crossval(m, 'KFold', 5);
            affs(i) = 1 - kfoldLoss(cv);
        catch
            affs(i) = 0;
        end
    end
    [~, s_idx] = sort(affs, 'descend');
    pop = gecici_pop(s_idx(1:n), :);
    affinity_skorlari = affs(s_idx(1:n));
end