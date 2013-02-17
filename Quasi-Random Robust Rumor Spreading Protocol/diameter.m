%calculates diameter of a digraph by the geometric series method
%d = diameter(G) where G is an adjacency matrix
%if G is not connected it calculates the longest 
%direct path that can be taken between two points within G
%this translates to the diameter of the largest cluster
function d = diameter(G)
N = length(G);
s = 0;
S = zeros(N);
for j=1:N
	so = s;
	S = G^j + S;
	s = sum(sum(S>0));
	if so == s
		break
	end
end
d = j-1;
