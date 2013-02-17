% In each round, every informed
% vertex v chooses a neighbor uv 2 N(v) := {u 2 V | {u, v} 2 E} uniformly at
% random and sends a copy of the information to it. This results in uv becoming
% informed, if it is not already, and in uv participating in the dissemination
% process in subsequent rounds.

clear all 
clc
N = 10;
M = 20;
n = 100;
RC = .9; %Random Chance Value, must be less than 1

A = zeros(N);
for j = 1:N %Create an NxN Matrix with random elements
    for k = 1:j-1%Step it down, so when Transposed
        K = rand(); % It is an adjacency matrix
        if K > RC %Randomly filled by RC value
            A(j,k) = 1;% Ohhh Yeaaaaaaah
        end
    end
end% Problem, if there an NxN and a node that isnt connected, this fails.
A = A' + A;%Tranpose + Reg = Populated Adjaceny Matrix, hopefully connected
if prod(sum(A)) == 0
    disp('Shit is broked')
    break
end
for g = 1:n %Counter, will run through sim 100 times with matrix below
r(g) = 0;
B = zeros(1,N);
B(myrandint(1,1,[1:numel(B)])) = 1; %Randomy choose Who is informed
D = zeros(1,N); % Place holder so newly informed neighbors don't inform on the same round they themselves were informed
d = 0;
while prod(B) ~= 1 % While at least one person is not informed do the following ::
    b = 0; %counter for loop below, when everyone who knows has informed someone, or had the chance to inform, jump out of the for loop
    B = B + D; % Add "informed" to "newly informed"
    D = zeros(1,N); % Reset place holders
    C = zeros(1,N);
    for k = 1:N
        if B(k) == 1    % If the person knows they...
           c = rand();  %Roll the dice
           e = 1; % And reset a counter
           for j = 1:numel(A(k,:))  
               if A(k,j) == 1   
                   C(j) = e/(sum(A(k,:)));  %And assign a probabilty based on who they know
                   e = e+1; % And increment that counter
               else
                   C(j) = 0;    %If they don't know them, zero probabilty
               end
           end
           for j =1:numel(A(k,:)) %Check each element until they inform someone
               if (A(k,j) == 1) & (C(j) > c) & (D(j) ~= 1) & (B(j) ~= 1) 
                   D(j) = 1; % Put that person in the place holder as knowing
                   b = b + 1; %add one to the counter, if this equals sum(B), end the for loop
                   c = c + 1;
               end
               if (A(k,j) == 1) & (C(j) > c) & (((D(j) == 1) & (B(j) == 1)) | ((D(j) == 1) | (B(j) ==1))) %To prevent counting someone as being informed multiple times
                   b = b + 1;
                   c = c + 1;
               end
               if b == sum(B)
                   k = N; %end the for loop
               end
           end
        end
    end
    r(g) = r(g)+1; %count the number of rounds it takes to inform everyone
end

end      
min(r);
max(r);
R = zeros(1,max(r));    %This stuff makes a neat barplot of the number of rounds
for j = 1:max(r)
    for k = 1:numel(r)
        if r(k) == j
            R(j) = R(j) + 1;
        end
    end
end
ZZ = 1:30;
[RR,XY] = bucky;
ch = subplot(2,1,2);
%gplot(A,XY(ZZ,:),'-*');
diffxy2(A,M);
ah = subplot(2,1,1);
bh = bar(R);