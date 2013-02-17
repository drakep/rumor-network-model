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
clc
clear all
getlabels % load labels for nodes
N = 5; % Number of nodes 
M = 2; % number of informed
n = 5; % number of times to run the random walk
RC = .3;%Random Chance Value, must be less than 1
PP = .5; % Pause for animation
A = zeros(N);
Cc = zeros(N); % used to track who informs who
A = buildneighborhood(N,RC); % Build the adj matrix. Make sure its fully traversable from any node.
% Bc = informer(N,M); % Fix the first informed

for g = 1:n%Counter, will run through sim 100 times with matrix below
r(g) = 1;
%B = Bc % Fixed first informed, instead of changing like line below
B = informer(N,M);%Randomy choose Who is informed, play with above line to change to fixed infomers
D = zeros(1,N); % Place holder so newly informed neighbors don't inform on the same round they themselves were informed
d = 0;

% Set up graph stuff

A = sparse(A);
Labels4Graph = labels(1:N);
gObj = biograph(A,Labels4Graph);
Ag = biograph.bggui(gObj);
for j = 1:N
    Knod3(j) = find(strcmp(Labels4Graph(j),Labels4Graph));
end
f = B;
for Ff = 1:N
    if B(Ff) == 1;
    set(gObj.nodes(Ff),'Color',[0 0 1]);
    end
end

% Main inform people loop
fkk =figure('visible','on')
[Bb,r] = spreadrumor(A,B,Ag,gObj,d,g,r,N,PP,Cc,D,f)
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
