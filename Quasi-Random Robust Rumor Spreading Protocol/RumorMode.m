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
% N =   Number of nodes 
% M =   number of informed
% n =   number of times to run the random walk
% RC =  Random Chance Value, must be less than 1
function Bb = RumorMode(N,M,n,RC)
% N = 5; % Number of nodes 
% M = 2; % number of informed
% n = 5; % number of times to run the random walk
% RC = .3;%Random Chance Value, must be less than 1
Timezzz = 1;
PP = .0001;
A = zeros(N);
Cc = zeros(N); % used to track who informs who
A = buildneighborhood(N,RC); % Build the adj matrix. Make sure its fully traversable from any node.
%Bc = informer(N,M); % Fix the first informed

for g = 1:n%Counter, will run through sim 100 times with matrix below
tic
r(g) = 1;
g
%B = Bc; % Fixed first informed, instead of changing like line below
B = informer(N,M);%Randomy choose Who is informed, play with above line to change to fixed infomers
D = zeros(1,N); % Place holder so newly informed neighbors don't inform on the same round they themselves were informed
d = 0;
% Set up graph stuff
A = sparse(A);
f = B;
% Main inform people program
while prod(prod(B)) == 0 % While at least one person is not informed do the following ::
    b = 0; %counter for loop below, when everyone who knows has informed someone, or had the chance to inform, jump out of the for loop
    d= d+1;
    Bb(d,:,g) = [sum(B),sum(D),(sum(B)/numel(B))];
    g
    Timezzz
    (sum(B)/numel(B)) %completion percentage
    D = zeros(1,N); % Reset place holders
    C = zeros(1,N);
    %Ag = biograph.bggui(gObj);
    %user_entry = input('prompt') 
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
                   Cc(k,j) = 2;
               end
               if (A(k,j) == 1) & (C(j) > c) & (((D(j) == 1) & (B(j) == 1)) | ((D(j) == 1) | (B(j) ==1))) %To prevent counting someone as being informed multiple times
                   b = b + 1;
                   c = c + 1;
                   Cc(k,j) = 2;
               end
               if b == sum(B)
                   k = N; %end the for loop
               end
           end
        end
    end
    B = B + D; %Add placeholder to actualm aka, add "informed" to "newly informed"
    r(g) = r(g)+1; %count the number of rounds it takes to inform everyone
end
Timezzz = toc
%close(Ag.hgFigure)
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
figure('visible','on');
ch = subplot(2,2,2);
imagesc(A);
subplot(2,2,[3 4]);
diffxy2(A,M);
ah = subplot(2,2,1);
bh = bar(R);
