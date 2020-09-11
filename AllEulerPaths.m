clear all;
close all;
G = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);
%G = graph ([1 1 1 2 3 4 5],[2 3 4 4 4 5 6]);
%G = graph([1 1 1 1],[2 2 2 2]);

[isEulerianG, path_G] = grIsEulerian(G.Edges.EndNodes);

if ((isEulerianG ~= 0))  
    paths_G = FindEulerPaths(G);
    g_size = size(G.Edges.EndNodes,1);
   
    for i = 0:(size(paths_G,1)/g_size -1)
        path_G = paths_G(g_size*i + 1:(g_size*(i + 1)), :);       
        disp(path_G);
        g_node_order = GetNodeOrderV2(G,path_G);
        
        num_nodes = (length(g_node_order));

        H = graph(1:num_nodes-1,2:num_nodes);
        H.Edges.Type(:) = {'tube'};
        [H,g_string_edges,dub_string_edges]= AddStrings(H,g_node_order,[],'string');
        
        figure;
        h = plot(H,'EdgeLabel',H.Edges.Type);
        title(strcat('G ',num2str(i+1)));
        highlight(h,g_string_edges(:,1),g_string_edges(:,2),'EdgeColor','r','LineWidth',1.5);
       
    
    end
end