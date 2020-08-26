function [last_node] = FindLastNode(G,path)
%Takes a Eulerian path and a graph G and determines which node is the last
%one in the path

E = G.Edges.EndNodes;
match_count = 0;

%Trace path back to find last node
last_edge = E(path(length(path)),:);

for i = 1:length(E)-1   
second2last_edge = E(path(length(path)-i),:);

if (mod(match_count,2) == 0) 
    last_node = last_edge((last_edge ~= second2last_edge)&(last_edge ~= flip(second2last_edge)));

else
    not_last_node = last_edge((last_edge ~= second2last_edge)&(last_edge ~= flip(second2last_edge)));
    if (~isempty(not_last_node))
        last_node = last_edge(last_edge ~= not_last_node);
    end
end

if (~isempty(last_node))
    break
end
match_count = match_count + 1;
end

%If last node can't be found,any node is fine. Select largest node as last node
if (isempty(last_node))
    last_node = size(G.Nodes,1);
    last_edge = size(E,1);
end
    

end

