function [node_order] = GetNodeOrdeV2(G,edges)
%Takes an Eulerian path and returns a vector of node

 %Find last node of graph
 
    num_edges = size(edges,1);
 
    [last_node] = FindLastNodeV2(G,edges);
    
    %Use edges to find each preceding node in order
    node_order = last_node;
    current_node = last_node;
    for i = 0:num_edges-1
        current_edge = edges(num_edges-i,:);
        next_node = current_edge(current_edge ~= current_node);
        node_order = [node_order , next_node];
        current_node = next_node;
        
    end
    
    %node_order = flip(node_order);
end

