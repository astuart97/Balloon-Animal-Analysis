function [output] = isValidNextEdge(G,u,v)
%   Checks if edge u-v can be considered as the next edge in the Euler Tour

%Verify edge u-v exist in the graph 
if findedge(G,u,v) == 0
    output = false;
    return;
end

% The edge u-v is valid in one of the following two cases:   
% 1) If v is the only adjacent vertex of u 
if (neighbors(G,u) == v)
    output = true;
    
%If there are multiple adjacents, then u-v is not a bridge 
% Do following steps to check if u-v is a bridge 
else  
    % 2.a) count of vertices reachable from u 
    count = length(dfsearch(G,u));
    % 2.b) Remove edge (u, v) and after removing the edge, count vertices reachable from u 
    G_copy = rmedge(G,u,v);
    new_count = length(dfsearch(G_copy,u));
    
    %2.c) If count is greater, then edge (u, v) is a bridge
    output = (count <= new_count);
    
end
end

