function D = gradeconn(G)
N = length(G);
D = zeros(N);
for j=1:diameter(G)
	D = D + (1/j)*G^j;
end
