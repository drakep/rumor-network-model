%calculates connectivity of a digraph ignoring self connections 
%c = connectivity(G) where G is an adjacency matrix with nonzero entries 
%representing edges
function k = connectivity(G);
s = size(G);
n = s(1);
poss = n^2-n;
k = sum(sum(G>0))/poss;
