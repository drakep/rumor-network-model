function xy = makexy(g);
s = size(g);
N = s(1);
x = cos(pi*(0:(N-1))/(N-1));%linspace(-1,1,s(1));
y = zeros(1,s(1));
for j=1:s(1)
	xx(j) = j;
	y(j) = sqrt(1 - x(j)^2)*(-1).^j;
end
y;
xy = [x;y;]';
