function [H] = AddMultiStrings(G,node_orders)
%Takes n different lists of ordered nodes and outputs the associated graph
%   Detailed explanation goes here

num_nodes = size(node_orders,1);
num_graphs = size(node_orders,2);
H = graph(1:num_nodes-1,2:num_nodes);
H.Edges.Type(:) = {'tube'};


for j = 1:num_graphs
    node_order = node_orders(:,j);
    visited_nodes = [];
    for i = 1:num_nodes
        current_node = node_order(i);
        
        %Stop if current node is 0 (path is complete)
        if current_node == 0
            break;
        end 
        
        %Check to see if we have already visited node
        if (ismember(current_node,visited_nodes))
            num_repeats = length(find(current_node == visited_nodes));
            %If we have already visited the node multiple times
            if (num_repeats > 1)
                %Check to see if there is an edge connecting the current
                %node to any previous occurance of that node
                for k = 1:num_repeats
                    repeat_nodes = find(node_order == current_node,i);
                    node_idx = repeat_nodes(last);
                    if findedge(H,i,node_idx)
                         idx = findedge(H,i,find(node_order == current_node,1));
                         type = H.Edges.Type(idx);
                         H.Edges.Type(idx) = {strcat(type{1},', G',num2str(j))};  
                         break;
                    end
                end
                %If no edge exists, add one to the first occurance of that
                %node
                H = addedge(H,i,find(node_order == current_node,1));
                idx = findedge(H,i,find(node_order == current_node,1));
                H.Edges.Type(idx) = {strcat('G',num2str(j))};  
            
            %If we have only visited the node once
            else  
                if findedge(H,i,find(node_order == current_node,1))
                    idx = findedge(H,i,find(node_order == current_node,1));
                    type = H.Edges.Type(idx);
                    H.Edges.Type(idx) = {strcat(type{1},', G',num2str(j))};  
                else
                    H = addedge(H,i,find(node_order == current_node,1));
                    idx = findedge(H,i,find(node_order == current_node,1));
                    H.Edges.Type(idx) = {strcat('G',num2str(j))};
                end
            end           
        else    
            visited_nodes = [visited_nodes, current_node];
        end    
    end
end