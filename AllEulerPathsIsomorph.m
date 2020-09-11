clear all;
close all;
G = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);
%H = graph ([1 1 1 2 3 4 5],[2 3 4 4 4 5 6]);
%H = graph([1 1 1 1],[2 2 2 2]);
H = graph ([3 3 3 3 1 2 4 6 6],[1 2 4 5 2 4 5 2 4]);

%Verify that paths G and H have Eulerian paths
[isEulerianG, path_G] = grIsEulerian(G.Edges.EndNodes);
[isEulerianH, path_H] = grIsEulerian(H.Edges.EndNodes);

if ((isEulerianG ~= 0) && (isEulerianH ~= 0)) 
    %Find all Eulerian Paths for Graph G
    paths_G = FindEulerPaths(G);
    g_size = size(G.Edges.EndNodes,1);
    
    %Find all Eulerian Paths for Graph H
    paths_H = FindEulerPaths(H);
    h_size = size(H.Edges.EndNodes,1);
    
    max_dub_string_edges = 0;
   
    %Iterate through all Eulerian paths for G
    for i = 0:(size(paths_G,1)/g_size -1)
        %Generate path and calculate node order
        path_G = paths_G(g_size*i + 1:(g_size*(i + 1)), :);       
        g_node_order = GetNodeOrderV2(G,path_G);
        
        %Iterate through all Eulerian paths for H
        for j = 0:(size(paths_H,1)/h_size -1)
            %Generate path and calculate node order
            path_H = paths_H(h_size*j + 1:(h_size*(j + 1)), :);       
            h_node_order = GetNodeOrderV2(H,path_H);
            
            %Create combined graph GH and add string componentss
            num_nodes = max(length(g_node_order),length(h_node_order));
            GH = graph(1:num_nodes-1,2:num_nodes);
            GH.Edges.Type(:) = {'tube'};
            [GH,g_string_edges,dub_string_edges]= AddStrings(GH,g_node_order,[],'G');
            [GH,h_string_edges,dub_string_edges]= AddStrings(GH,h_node_order,g_string_edges,'H'); 
            
            %Find best graph (most overlapping string edges)
            if (size(dub_string_edges,1) >= max_dub_string_edges)
                max_dub_string_edges = size(dub_string_edges,1);
                GH_best = GH;
                g_string_edges_best = g_string_edges;
                h_string_edges_best = h_string_edges;
                dub_string_edges_best = dub_string_edges;
            end
            
%             %Plot and highlight combined graph
%             figure;
%             subplot(1,3,1), plot(G);
%             title(strcat('G',i+1));
%             subplot(1,3,2), plot(H);
%             title(strcat('H',j+1));
%             subplot(1,3,3), plot(GH,'EdgeLabel',GH.Edges.Type);
%             h = plot(GH,'EdgeLabel',GH.Edges.Type);
%             
%             %Highlight string edges
%             if ~isempty(h_string_edges)
%                 highlight(h,h_string_edges(:,1),h_string_edges(:,2),'EdgeColor','r','LineWidth',1.5)
%             end
%             highlight(h,g_string_edges(:,1),g_string_edges(:,2),'EdgeColor','c','LineWidth',1.5);
%             if ~isempty(dub_string_edges)
%                 highlight(h,dub_string_edges(:,1),dub_string_edges(:,2),'EdgeColor','m','LineWidth',1.5)
%             end
        end
    end
end


%% Optimal Graph
close all
figure;
subplot(1,3,1), plot(G);
title(strcat('G',i+1));
subplot(1,3,2), plot(H);
title(strcat('H',j+1));
subplot(1,3,3), plot(GH_best,'EdgeLabel',GH_best.Edges.Type);
h = plot(GH_best,'EdgeLabel',GH_best.Edges.Type);

%Highlight string edges
if ~isempty(h_string_edges_best)
    highlight(h,h_string_edges_best(:,1),h_string_edges_best(:,2),'EdgeColor','r','LineWidth',1.5)
end
highlight(h,g_string_edges_best(:,1),g_string_edges_best(:,2),'EdgeColor','c','LineWidth',1.5);
if ~isempty(dub_string_edges_best)
    highlight(h,dub_string_edges_best(:,1),dub_string_edges_best(:,2),'EdgeColor','m','LineWidth',1.5);
end
