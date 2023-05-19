% dijkstra.m
% Dijkstra shortest-path routing
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
C = [ 0   4    2  inf  inf ; ...
      4   0   inf  3    10 ; ...
      2  inf   0   8   inf ; ...
     inf  3    8   0    6  ; ...
     inf  10  inf  6    0  ] ;

M = size(C, 1);

fprintf(1, 'C (cost between nodes) matrix) is \n');
for k = 1:M
    fprintf(1, ' %6d', C(k, :));
    fprintf(1, '\n');
end
fprintf(1, '\n');

d = C(1, :);   % distance vector - initial setting

fprintf(1, 'd (distance vector from origin) is initially ');
fprintf(1, ' %d', d);
fprintf(1, '\n');

cnode = 0;    % current node we are working on
S = [1];      % set of nodes examined

NodeCan = true(M, 1);   % flag if node is still a candidate
NodeCan(1) = false;
P = ones(M, 1);         % predecessor node list
%---------------------------------------------------------------

%---------------------------------------------------------------
for i = 1:M-1
    fprintf(1, 'Step i=%d\n', i);

    % choose a node
    dmin = inf;
    cnode = 0;
    for v = 1:M
        if( NodeCan(v) )
            if( d(v) < dmin)
                dmin = d(v);
                cnode = v;
            end
        end
    end
    fprintf(1, 'chose node cnode=%d as best dmin=%d so far\n', cnode, dmin);

    S = [S cnode];
    NodeCan(cnode) = false;

    for v = 1:M
        if( NodeCan(v) )
            fprintf(1, 'Node %d, choice %d+%d < %d\n', ...
                v, d(cnode), C(cnode, v), d(v));
            if( d(cnode) + C(cnode, v) < d(v) )
                d(v) = d(cnode) + C(cnode, v);
                P(v) = cnode;
            end

            %pause
        end
    end
    fprintf(1, 'd (distance vector from origin) is now ');
    fprintf(1, ' %d', d);
    fprintf(1, '\n');

    fprintf(1, 'P (backtrack path) is now ');
    fprintf(1, ' %d', P);
    fprintf(1, '\n');

    fprintf(1, 'S (set of nodes we have checked) is now ');
    fprintf(1, ' %d', S);
    fprintf(1, '\n');

    pause
end

fprintf(1, 'Path cost = %d\n', d(M));
fprintf(1, 'P is now ');
fprintf(1, ' %d', P);
fprintf(1, '\n');
%---------------------------------------------------------------

%---------------------------------------------------------------
% backtrack to work out shortest path
i = M;
optpath = [i];
while( i ~= 1 )
    i = P(i);
    optpath = [i optpath];
end

fprintf(1, 'optpath is ');
fprintf(1, ' %d', optpath);
fprintf(1, '\n');
%---------------------------------------------------------------

