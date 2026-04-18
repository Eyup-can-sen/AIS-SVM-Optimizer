function klonlama(nc)
    global n pop affinity_skorlari klon_pop
    [~, idx] = sort(affinity_skorlari, 'descend');
    secilenler = pop(idx(1:round(n/2)), :);
    klon_pop = repmat(secilenler, nc, 1);
end