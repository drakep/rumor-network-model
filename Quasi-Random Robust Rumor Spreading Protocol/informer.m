function B = informer(N,M)
B = zeros(1,N);
while sum(B) < M
    f = myrandint(1,1,[1:numel(B)]);
    if B(f) == 0
        B(f) = 1;
    end
end