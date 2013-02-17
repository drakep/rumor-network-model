function A = buildneighborhood(N,RC)
figure('visible','on');
A = gnp(N,RC);
imagesc(A)
while ((prod(sum(A)) == 0) | numel(graphtraverse(sparse(A),N)) ~= N)
    A = gnp(N,RC);
    imagesc(A)
    pause(.01)
end