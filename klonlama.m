function [ ] = klonlama()
    % İhtiyacımız olan global değişkenleri çağırıyoruz
    global n nc pop affinity_skorlari klon_pop
    
    % 1. Skorları Büyükten Küçüğe Sırala
    % sort(..., 'descend'): Değerleri en yüksekten en düşüğe doğru sıralar.
    % Bizim için asıl önemli olan skorun kendisi değil, o skorun 'pop' dizisinde kaçıncı satırda (indekste) olduğudur.
    % Bu yüzden ilk çıktıyı '~' ile çöpe atıyor, sadece 'idx' (indeksler) dizisini alıyoruz.
    [~, idx] = sort(affinity_skorlari, 'descend');
    
    % 2. En İyi Antikorları Seç (Elitizm)
    % round(n/2): Popülasyonun tam yarısını (en başarılı %50'lik kısmı) seçiyoruz.
    % idx(1:round(n/2)): Sıralanmış indeks listesinin ilk yarısını alır (Yani en yüksek skorlu olanların adreslerini).
    % pop(..., :): Bu adreslere gidip, o başarılı antikorların tüm özelliklerini (sütunlarını) 'secilenler' matrisine kopyalar.
    secilenler = pop(idx(1:round(n/2)), :);
    
    % 3. Seçilenleri Çoğalt (Klonla)
    % repmat(matris, satir_tekrari, sutun_tekrari): Bir matrisi istenilen sayıda kopyalayıp alt alta veya yan yana ekler.
    % Biz 'secilenler' matrisini alt alta 'nc' (örneğin 5) kez kopyalıyoruz.
    % Eğer 10 tane 'secilen' antikorumuz varsa ve nc=5 ise, klon_pop 50 satırlık dev bir matris olur.
    klon_pop = repmat(secilenler, nc, 1);
end