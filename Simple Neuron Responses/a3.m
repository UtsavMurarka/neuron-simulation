k = 0;

x = -10:.1:10; 
y = -10:.1:10; 
[X,Y] = meshgrid(x,y);
arr = zeros(100);
arrk = zeros(100);
for i = 1:100
    k=(0.1*i) - 5;
    F = (5*cos(k.*X).*exp(-X.^2-Y.^2).*cos(2.*X));
    I = trapz(y,trapz(x,F,2));
    arr(i) = I;
    arrk(i) = k;
end

plot(arrk, arr);
xlabel('K');
ylabel('Ls');