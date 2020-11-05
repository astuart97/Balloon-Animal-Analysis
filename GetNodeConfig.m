function [H_best] = GetNodeConfig(G)
%Takes a cell aray of target graphs G, and outputs a graph H containing
%node configuration needed to make all graphs

H_best = 0; 

%Verify that all target graphs have Eulerian paths
for i = 1:length(G)    
    if  (grIsEulerian(G{i}.Edges.EndNodes) == 0) 
        return;
    end  
end

%Compute all possible Eulerian paths for each target graph
paths = cell(1,length(G));
path_sizes = zeros(1,length(G));

total_combos = 1;
for i = 1:length(G)  
    paths{i} = FindEulerPaths(G{i});
    path_sizes(i) = size(G{i}.Edges.EndNodes,1);
    total_combos = total_combos * length(paths{i})/path_sizes(i);
end

%define ones vector v = #graphs
v = ones(1,length(G));
%define least strings = inf
least_edges = inf; 

%for loop i = 1 : (product total # of eulerian paths)
for i = 1:total_combos

    node_orders = zeros(max(path_sizes)+1,length(G));

    %for loop j = 1: (#graphs)
        %grab the v(j) Eulerian path
        %calculate node order
        %Add to jth colum of node_orders matrix
    for j = 1:length(G)
        graph_paths = paths{j};
        path_id = v(j);
        path_length = path_sizes(j);
        path = graph_paths((path_id*path_length)-(path_length -1) :path_id*path_length,:);
        node_order = GetNodeOrderV2(G{j},path);
        if (length(node_order) < max(path_sizes)+1)
            node_order = [node_order, zeros(1,max(path_sizes)+1 - length(node_order))];
        end
        node_orders(:,j) = node_order';           

    end
    %Call AddStrings to generate Graph H
    H = AddMultiStrings(G,node_orders);

    %Count number of strings in H
    num_edges = size(H.Edges,1);
    if num_edges < least_edges
        H_best = H;
        least_edges = num_edges;
    end
    
    % add 1 to first element of v
    v(1) = v(1) + 1;
    if (i == total_combos)
        return;
    end
    for j = 1:length(G)
        %if jth element of vector > number of Eulerian paths in the jth graph
        if v(j) > (length(paths{j}) / path_sizes(j))
            %add 1 to the j+1 element 
            v(j+1) = v(j+1) + 1;
            %set all elements from 0 to j to 1
            v(1:j) = ones(1,j);
        end
    end

end

end

