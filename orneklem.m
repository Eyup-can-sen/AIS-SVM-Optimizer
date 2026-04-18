function [egitim, egitimc, test, testc] = orneklem(data)
ornekyuzde = 30 ;


N =  size(data,1);

n = floor(N*ornekyuzde/100) ;


d = round(N/n) ; 


a = 1 ;
s = size(data,2) ;

for i=1:n
    B=(a+d*(i-1));
    if (B>N)
        C=B-N;
    else
        C=B;
    end
	test1(i,:) = data(C,:) ;
end

test = test1(:,1:s-1) ;

testc = test1(:,s) ;

% Eðitim Veri seti

egitim1 = data ;
for i=1:n
	silme(i) = (a+d*(i-1)) ;
end    
    
silme=sort(silme,'descend');

for i=1:n
    k = silme(i) ;
    egitim1(k,:) = [] ;
end    

egitim = egitim1(:,1:s-1) ;

egitimc = egitim1(:,s) ;

end