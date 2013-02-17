%reglattice(N,k) generates an adjacency matrix for a graph of N 
%verticies where each vertex is connected to k nearest neighbors.
% k MUST be EVEN. - the result is a undirected graph
function A = reglattice(M,n)
for j=1:M
	for k=-(n/2):(n/2)
		K = j+k;
		if (K > M)||(K<0)
        	         K = mod(K,M);
	        elseif K == 0
			K = 1;
		end

		A(j,K) = 1;
		A(K,j) = 1;
	end
	A(j,j) = 0;
end
