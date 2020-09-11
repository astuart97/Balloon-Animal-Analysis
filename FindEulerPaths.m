function [all_paths] = FindEulerPaths(G)
%Takes a graph G with an Eulerian path and returns all possible paths

[isEulerian] = grIsEulerian(G.Edges.EndNodes);

%If it's an Eulerian loop, all nodes are valid start nodes
if (isEulerian == 1)
    start_nodes = [1:numnodes(G)];
    
%If it's an Eulerian path, the two odd nodes are valid start nodes
elseif (isEulerian == 0.5)
    start_nodes = find(mod(degree(G),2) ~= 0);          
else
    return;
end

all_paths = [];
target_size = length(G.Edges.EndNodes);

%Find all paths from each start node
for i = 1:length(start_nodes)
    [a,paths] = FindEulerPathsHelper(G,start_nodes(i),target_size,[]);
    all_paths = [all_paths;paths];
end

end

