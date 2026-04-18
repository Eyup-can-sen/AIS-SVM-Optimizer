function antikor_olustur()
    global n pop sinir_alt sinir_us
    pop = sinir_alt + (sinir_us - sinir_alt) .* rand(n, 5);
end