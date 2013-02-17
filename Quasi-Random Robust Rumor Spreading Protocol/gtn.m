function G = gtn(n,t)
G = zeros(n);
j = 0;
while j<t
	r = randint(1,2,[1 n]);
	if (G(r(1),r(2)) == 0) && (r(1) ~= r(2))
		G(r(1),r(2)) = 1;
		G(r(2),r(1)) = 1;
		j = j+1;
	end
end
