function [ ] = hipermutasyon()
    % Global değişkenleri çağırıyoruz.
    global klon_pop sinir_alt sinir_us
    
    % klon_pop matrisinin satır sayısını (kaç tane klon antikor olduğunu) buluyoruz.
    % Sütun sayısı (5) bizim için bu aşamada r değişkenine atanmak zorunda değil, bu yüzden '~' ile çöpe atıyoruz.
    [r, ~] = size(klon_pop);
    
    % Her bir klon antikor için tek tek döngüye giriyoruz.
    for i = 1:r
        
        % 1. Mutasyon Şiddetini Belirle
        % randn(1, 5): Normal (Gauss) dağılımlı, ortalaması 0, varyansı 1 olan 5 adet rastgele sayı üretir.
        % 0.1 ile çarpmak: Mutasyonun ortalama olarak +%10 ile -%10 arasında bir şiddette olmasını sağlar.
        siddet = 0.1 * randn(1, 5);
        
        % 2. Mutasyonu Uygula
        % Klonun mevcut parametrelerini, mutasyon şiddeti ile çarpıyoruz.
        % Örnek: Eğer siddet 0.05 ise, (1 + 0.05) = 1.05 olur. Mevcut parametre %5 oranında büyür.
        % Eğer siddet -0.03 ise, (1 - 0.03) = 0.97 olur. Mevcut parametre %3 oranında küçülür.
        klon_pop(i, :) = klon_pop(i, :) .* (1 + siddet);
        
        % 3. Sınır Kontrolü (Clipping)
        % Mutasyon sonucunda değerler, bizim belirlediğimiz aralıkların dışına taşmış olabilir.
        
        % Alt Sınır Kontrolü: Antikorun değerleri ile 'sinir_alt' değerlerini kıyaslar. 
        % Hangisi BÜYÜKSE onu alır. Böylece değer asla sinir_alt'ın altına düşemez.
        klon_pop(i, :) = max(klon_pop(i, :), sinir_alt);
        
        % Üst Sınır Kontrolü: Antikorun güncel değerleri ile 'sinir_us' değerlerini kıyaslar.
        % Hangisi KÜÇÜKSE onu alır. Böylece değer asla sinir_us'u geçemez.
        klon_pop(i, :) = min(klon_pop(i, :), sinir_us);
    end
end