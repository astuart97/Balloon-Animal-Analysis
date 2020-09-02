function [H,string_edges,dub_string_edges] = AddStrings(G,node_order,string_edges)
%Takes node order and adds string edges to straight line plot G to make it
%work
%   Detailed explanation goes here
visited_nodes = [];
dub_string_edges = [];

for i = 1:length(node_order)
    current_node = node_order(i);
    if (ismember(current_node,visited_nodes))
        if ~findedge(G,i,find(node_order == current_node,1))      
            G = addedge(G,i,find(node_order == current_node,1));
            idx = findedge(G,i,find(node_order == current_node,1));
            G.Edges.Type(idx) = {'string'};
            string_edges = [string_edges; i,find(node_order == current_node,1)];
        else
            idx = findedge(G,i,find(node_order == current_node,1));
            G.Edges.Type(idx) = {'2x string'};  
            dub_string_edges = [dub_string_edges; i,find(node_order == current_node,1)];
        end
    else    
        visited_nodes = [visited_nodes, current_node];
    end    
end

H = G; 

end

