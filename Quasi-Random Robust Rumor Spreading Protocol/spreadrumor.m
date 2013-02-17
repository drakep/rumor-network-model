function [Bb,r] = spreadrumor(A,B,Ag,gObj,d,g,r,N,PP,Cc,D,f)
while prod(prod(Cc)) == 0 % While at least one person is not informed do the following ::
    b = 0; %counter for loop below, when everyone who knows has informed someone, or had the chance to inform, jump out of the for loop
    d= d+1;
    Bb(d,:) = [sum(B),sum(D),(sum(B)/numel(B))];
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
                   %do fancy coloring stuff
                    [dist,path,pred] = shortestpath(gObj,k,j);
                    set(gObj.Nodes(path),'Color',[1 0.4 0.4])
                    edges = getedgesbynodeid(gObj,get(gObj.Nodes(path),'ID'));
                    set(edges,'LineColor',[1 0 0])
                    set(edges,'LineWidth',1.5)
                    for Ff = 1:N
                        if f(Ff) == 1;
                            set(gObj.nodes(Ff),'Color',[0 0 1]);
                        end
                    end
                    pause(PP)
                    Cc(k,j) = 2;
               end
               if (A(k,j) == 1) & (C(j) > c) & (((D(j) == 1) & (B(j) == 1)) | ((D(j) == 1) | (B(j) ==1))) %To prevent counting someone as being informed multiple times
                   b = b + 1;
                   c = c + 1;
                   if Cc(k,j) ~= 2
                    [dist,path,pred] = shortestpath(gObj,k,j);
                    edges = getedgesbynodeid(gObj,get(gObj.Nodes(path),'ID'));
                    set(edges,'LineColor',[0 1 0])
                    set(edges,'LineWidth',1.5)
                    for Ff = 1:N
                      if f(Ff) == 1;
                        set(gObj.nodes(Ff),'Color',[0 0 1]);
                      end
                    end
                    pause(PP)
                   end
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
    close(Ag.hgFigure)
    Ag = biograph.bggui(gObj);
    pause(PP)


%     
        %Animation Stuff End
%     
    
end