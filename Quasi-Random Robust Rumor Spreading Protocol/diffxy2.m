function   diffxy(G,T)
N = length(G);
outdeg = sum(G');
indeg = sum(G);
%x = rand(1,N);
%xy = [x' x'];%
xy = circlexy(G);
	do = log10((outdeg/max(outdeg))+1) ;
	di = exp(-(indeg/max(indeg)).^2);
%xy(:,2) = xy(:,2).*outdeg';
for t=1:T
	y = xy(:,2);
	x=xy(:,1);
	do = (do);
	di = (di);
	Gxo = (G+eye(N))*diag(x); %x coordinates of outgoing neighbors
	Gyo = (G+eye(N))*diag(y); % y
	Gxi = (G'*diag(x))';%x coordinates of incoming neighbors
	Gyi = (G'*diag(y))';% y  - each row is the coords
	Gdx = ((Gxo - Gxi));
	Gdy = ((Gyo - Gyi));
	%Gy = Gdy./sqrt((Gdx + Gdy).^2);
	%Gx = Gdx./sqrt((Gdx +  Gdy).^2);
	y = y + Gdy*di'*.01 - Gdy'*do'*.01 ;
	x = x + Gdx*di'*.01 - Gdx'*do'*.01 ;	
		xy = [x y];
%	Hp = G'*do'
%	Hr = G*di';
%	y = y - Hp*.01.*y -Hr*.01.*y + do'*.04.*y;
%	x = x - Hp*.01.*x -Hr*.01.*x + do'*.04.*x;

	
	%gplot(G,xy,'ro');
	%gplot(G,xy,'k')
	
end

gplot(G,xy);
