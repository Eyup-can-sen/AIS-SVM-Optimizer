function hipermutasyon()
    global klon_pop sinir_alt sinir_us
    [r, ~] = size(klon_pop);
    for i = 1:r
        siddet = 0.1 * randn(1, 5);
        klon_pop(i, :) = klon_pop(i, :) .* (1 + siddet);
        
        % Sınır kontrolü
        klon_pop(i, :) = max(klon_pop(i, :), sinir_alt);
        klon_pop(i, :) = min(klon_pop(i, :), sinir_us);
    end
end
