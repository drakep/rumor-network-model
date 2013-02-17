%meanlen(G) returns mean walk length for adjacency matrix G
%[l,L] = meanlen(G) returns mean walk length l and matrix L 
%that holds the length of the shortest walk from i to j in the i,j entry
function [l,L] = meanlen(G);
N = length(G);
L = zeros(N); S = zeros(N);
for j=1:diameter(G)
	A = (G^j)>0;
	L = ((A-S)>0)*j + L;
	S = (S+A)>0;
end
for k=1:N
	L(k,k) = 0;
end
l = sum(sum(L))/sum(sum(L>0));
