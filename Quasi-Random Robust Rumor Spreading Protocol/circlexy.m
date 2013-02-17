function xy = makexy(g);
s = size(g);
N = s(1);
half = round(s(1)/2);
x = zeros(1,N);
x(1:half) = cos(pi*(1:(half))/(half+1));%linspace(-1,1,s(1));
h2 = N - half;
if h2 == half
	zz = 0;
else
	zz = 1;
end
x(h2:N) = cos(pi*(abs(-h2:zz))/(h2-1));
%x(1:half) = linspace(-1+(2/half),1-(2/half),half)
%x(h2:N) = linspace(-1+(2/h2),1-(2/h2),h2+1);
y = zeros(1,s(1));
for j=1:s(1)
	if j > half 
		y(j) = -sqrt(1 - x(j)^2);
	else
		y(j) = sqrt(1-x(j)^2) ;
	end
end
y;
xy = [x;y;]';
