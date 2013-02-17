function [Xout,Yout]=gplot(A,xy,lc)
%GPLOT Plot graph, as in "graph theory".
%   GPLOT(A,xy) plots the graph specified by A and xy. A graph, G, is
%   a set of nodes numbered from 1 to n, and a set of connections, or
%   edges, between them.  
%
%   In order to plot G, two matrices are needed. The adjacency matrix,
%   A, has a(i,j) nonzero if and only if node i is connected to node
%   j.  The coordinates array, xy, is an n-by-2 matrix with the
%   position for node i in the i-th row, xy(i,:) = [x(i) y(i)].
%   
%   GPLOT(A,xy,LineSpec) uses line type and color specified in the
%   string LineSpec. See PLOT for possibilities.
%
%   [X,Y] = GPLOT(A,xy) returns the NaN-punctuated vectors
%   X and Y without actually generating a plot. These vectors
%   can be used to generate the plot at a later time if desired.  As a
%   result, the two argument output case is only valid when xy is of type
%   single or double.
%   
%   See also SPY, TREEPLOT.

%   John Gilbert, 1991.
%   Copyright 1984-2006 The MathWorks, Inc. 
%   $Revision: 5.12.4.1 $  $Date: 2006/12/15 19:28:12 $

[i,j] = find(A);
[ignore, p] = sort(max(i,j));
i = i(p);
j = j(p);

X = [ xy(i,1) xy(j,1)]';
Y = [ xy(i,2) xy(j,2)]';

if nargout == 0,
    if nargin < 3
        lc = '';
    end
    [lsty, csty, msty] = gplotGetRightLineStyle(gca,lc);    
    %plot(X,Y,'LineStyle',lsty,'Color','Black');
    %plot(X,Y,'Color',csty,'Marker',msty);

	plot(X,Y,'k');
	hold on		
	plot(X,Y,'g*');
	hold off
else
    Xout = [X; NaN(size(i))'];
    Xout = Xout(:);
    Yout = [Y; NaN(size(i))'];
    Yout = Yout(:);
end

function [lsty, csty, msty] = gplotGetRightLineStyle(ax, lc)
%  gplotGetRightLineStyle
%    Helper function which correctly sets the color, line style, and marker
%    style when plotting the data above.  This style makes sure that the
%    plot is as conformant as possible to gplot from previous versions of
%    MATLAB, even when the coordinates array is not a floating point type.
co = get(ax,'ColorOrder');
lo = get(ax,'LineStyleOrder');
holdstyle = getappdata(gca,'PlotHoldStyle');
if isempty(holdstyle)
    holdstyle = 0;
end
lind = getappdata(gca,'PlotLineStyleIndex');
if isempty(lind) || holdstyle ~= 1
    lind = 1;
end
cind = getappdata(gca,'PlotColorIndex');
if isempty(cind) || holdstyle ~= 1
    cind = 1;
end
nlsty = lo(lind);
ncsty = co(cind,:);
nmsty = 'none';
%  Get the linespec requested by the user.
[lsty,csty,msty] = colstyle(lc);
if isempty(lsty)
    lsty = nlsty;
end
if isempty(csty)
    csty = ncsty;
end
if isempty(msty)
    msty = nmsty;
end

