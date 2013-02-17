% I n each round, every informed
% vertex v chooses a neighbor uv 2 N(v) := {u 2 V | {u, v} 2 E} uniformly at
% random and sends a copy of the information to it. This results in uv becoming
% informed, if it is not already, and in uv participating in the dissemination
% process in subsequent rounds.

%%%%%
%%%%%
%%%%% Stuff To Add
%%%%% 1 ) Tracking of spread
%%%%% 2 ) Rounds vs Connectivity
%%%%% 3 ) ???
%%%%% 4 ) Profit
%%%%%
%%%%%

clear all 
clc
AA = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; %Letters for Lables
N = 26; % Number of nodes 
M = 15; % unused unless using diffxy2 to plot
n = 50; % number of times to run the random walk
RC = .1; %Random Chance Value, must be less than 1
PP = .01; % Pause for animation
h = figure(1);
A = zeros(N);
A = gnp(N,RC); %Create a an adj. matrix populated randomly
while prod(sum(A)) == 0
    A = gnp(N,RC);
    imagesc(A)
    pause(.01)
end
for g = 1:n%Counter, will run through sim 100 times with matrix below
    g
r(g) = 1;
B = zeros(1,N); %Initialize the informed matrix
%B(myrandint(1,1,[1:numel(B)])) = 1;
B(myrandint(1,1,[1:numel(B)])) = 1;%Randomy choose Who is informed, maybe make more than one person informed at some point?
D = zeros(1,N); % Place holder so newly informed neighbors don't inform on the same round they themselves were informed
d = 0;
while prod(B) ~= 1 % While at least one person is not informed do the following ::
    b = 0; %counter for loop below, when everyone who knows has informed someone, or had the chance to inform, jump out of the for loop
    B = B + D;
    ch = subplot(2,2,2);
    imagesc(B')
    d= d+1;
    Bb(d,:,g) = [sum(B),sum(D),(sum(B)/numel(B))];
    sum(B)/numel(B)
    r(g)
%     Bb(d,3)
    pause(PP)% Add "informed" to "newly informed"
    D = zeros(1,N); % Reset place holders
    C = zeros(1,N);
    for k = 1:N
        if B(k) == 1    % If the person knows they...
           c = rand();  %Roll the dice
           e = 1; % And reset a counter
           for j = 1:numel(A(k,:))  
               if A(k,j) == 1 %& (B(j) ~= 1);
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
    r(g) = r(g)+1 %count the number of rounds it takes to inform everyone
        %
    %
       % Animation Stuff
    %
    %
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
    ch = subplot(2,2,2);
    h = imagesc(B');
    subplot(2,2,[3 4]);
    gplot(A,XY(ZZ,:),'-');
    for j = 1:N, % Comment out for N > 26, adds lables to adj graph
        text(XY(j,1),XY(j,2),AA(j),'FontSize',15);
    end
    ah = subplot(2,2,1);
    bh = bar(R);
    pause(PP)
%     
%     
        %Animation Stuff End
%     
%     
end

end
%final plot stuff ::
R = zeros(1,max(r));    %This stuff makes a neat barplot of the number of rounds
for j = 1:max(r)
    for k = 1:numel(r)
        if r(k) == j
            R(j) = R(j) + 1;
        end
    end
end
%dlmwrite('Bb',Bb)
ZZ = 1:30;
[RR,XY] = bucky;
ch = subplot(2,2,2);
imagesc(A);
subplot(2,2,[3 4]);
gplot(A,XY(ZZ,:),'-');
for j = 1:N, %comment out for N > 26
    text(XY(j,1),XY(j,2),AA(j),'FontSize',15);
end
ah = subplot(2,2,1);
bh = bar(R);