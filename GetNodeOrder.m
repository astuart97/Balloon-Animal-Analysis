function [node_order] = GetNodeOrder(G,path)
%Takes an Eulerian path and returns a vector of node
E = G.Edges.EndNodes;
path_edges = E(path,:);
 %Find last node of graph
 
    [last_node] = FindLastNode(G,path);
    
    %Use edges to find each preceding node in order
    node_order = last_node;
    current_node = last_node;
    for i = 0:length(path)-1
        current_edge = path_edges(length(path_edges)-i,:);
        next_node = current_edge(current_edge ~= current_node);
        node_order = [node_order , next_node];
        current_node = next_node;
        
    end
    
    %node_order = flip(node_order);
end

