function [last_node] = FindLastNode(G,path)
%Takes a Eulerian path and a graph G and determines which node is the last
%one in the path

E = G.Edges.EndNodes;

for i = 0:length(E)-1
last_edge = E(path(length(path)-i),:);
second2last_edge = E(path(length(path)-i-1),:);
last_node = last_edge((last_edge ~= second2last_edge)&(last_edge ~= flip(second2last_edge)));
if (~isempty(last_node))
    break
end
end

%If last node can't be found by tracing the path back, then any node is
%fine, select first node as last node
if (isempty(last_node))
    last_node = 1;
end
    

end

