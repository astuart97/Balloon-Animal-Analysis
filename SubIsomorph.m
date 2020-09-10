clear all
G = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);
%Isomorphism of first graph
%H = graph ([1 1 1 2 3 4 5],[2 3 4 4 4 5 6]);
%H = graph([1 1 1 1],[2 2 2 2]);
%H = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);
%H = graph([1 1 2 2 3 3 4 4 5],[2 3 3 4 4 5 5 6 6]);
%H = graph([1 2 3 4],[2 3 4 1]);
H = graph ([3 3 3 3 1 2 4 6 6],[1 2 4 5 2 4 5 2 4]);


[isEulerianG, path_G] = grIsEulerian(G.Edges.EndNodes);
[isEulerianH, path_H] = grIsEulerian(H.Edges.EndNodes);


if ((isEulerianG ~= 0) && (isEulerianH ~= 0))  

    g_node_order = GetNodeOrder(G,path_G);
    h_node_order = GetNodeOrder(H,path_H);
    %h_node_order = [3 1 2 3 4 2 6 4 5 3];
    
end

%% Generate additional nodes for overlaps

num_nodes = max(length(g_node_order),length(h_node_order));

GH = graph(1:num_nodes-1,2:num_nodes);
GH.Edges.Type(:) = {'tube'};

[GH,g_string_edges,dub_string_edges]= AddStrings(GH,g_node_order,[],'G');
[GH,h_string_edges,dub_string_edges] = AddStrings(GH,h_node_order,g_string_edges,'H'); 

figure;
subplot(1,3,1), plot(G);
title('G');
subplot(1,3,2), plot(H);
title('H');
subplot(1,3,3), plot(GH,'EdgeLabel',GH.Edges.Type);

h = plot(GH,'EdgeLabel',GH.Edges.Type);

if ~isempty(h_string_edges)
    highlight(h,h_string_edges(:,1),h_string_edges(:,2),'EdgeColor','r','LineWidth',1.5)
end
highlight(h,g_string_edges(:,1),g_string_edges(:,2),'EdgeColor','c','LineWidth',1.5);
if ~isempty(dub_string_edges)
    highlight(h,dub_string_edges(:,1),dub_string_edges(:,2),'EdgeColor','m','LineWidth',1.5)
end