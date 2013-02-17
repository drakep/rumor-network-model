% In each round, every informed
% vertex v chooses a neighbor uv 2 N(v) := {u 2 V | {u, v} 2 E} uniformly at
% random and sends a copy of the information to it. This results in uv becoming
% informed, if it is not already, and in uv participating in the dissemination
% process in subsequent rounds.

clear all 
clc
n = 50;
for g = 1:n %Counter, will run through sim 100 times with matrix below
r(g) = 0;
A = [0,1,1,0,0;1,0,1,0,0;1,1,0,1,1;0,0,1,0,0;0,0,1,0,0;]; % Test Matrix
B = [1,0,0,0,0]; %Who is informed
D = zeros(1,5); % Place holder so newly informed neighbors don't inform on the same round they themselves were informed
d = 0; % not sure
while prod(B) ~= 1 % While at least one person is not informed do the following ::
    b = 0; %counter for loop below, when everyone who knows has informed someone, or had the chance to inform, jump out of the for loop
    B = B + D; % Add "informed" to "newly informed"
    D = zeros(1,5); % Reset place holders
    C = zeros(1,5);
    for k = 1:5
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
                   k = 5; %end the for loop
               end
           end
        end
    end
    r(g) = r(g)+1; %count the number of rounds it takes to inform everyone
end

end      
min(r)
max(r)
R = zeros(1,max(r));    %This stuff makes a neat barplot of the number of rounds
for j = 1:max(r)
    for k = 1:numel(r)
        if r(k) == j
            R(j) = R(j) + 1;
        end
    end
end
bar(R)