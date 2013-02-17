%gnp(n,p) generates the adjacency matrix of a graph we call G(n,p)
%G(n,p) is a undirected graph of n verticies where all possible 
%connections form with independent probability p
function G = gnp(m,p)
G = zeros(m);
Z = zeros(m);
for j = 1:m
	for k=j+1:m
		if (rand > 1-p)
			G(j,k) = 1;
			G(k,j) = 1;
		end
	end
end


%hist(degs);
%sum(degs)
