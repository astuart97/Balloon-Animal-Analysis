G = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);

%Isomorphism of first graph
H = graph ([1 1 1 2 3 4 5],[2 3 4 4 4 5 6]);
%H = graph([1 1 1 1],[2 2 2 2]);
%H = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);
H = graph([1 1 2 2 3 3 4 4 5],[2 3 3 4 4 5 5 6 6]);

[isEulerianG, path_G] = grIsEulerian(G.Edges.EndNodes);
[isEulerianH, path_H] = grIsEulerian(H.Edges.EndNodes);


if ((isEulerianG ~= 0) && (isEulerianH ~= 0))  

    g_node_order = GetNodeOrder(G,path_G);
    h_node_order = GetNodeOrder(H,path_H);
    
end

%% Generate additional nodes for overlaps

num_nodes = max(length(g_node_order),length(h_node_order));

GH = graph(1:num_nodes-1,2:num_nodes);
GH.Edges.Type(:) = {'tube'};

[GH,string_edges,dub_string_edges]= AddStrings(GH,g_node_order,[]);
[GH,string_edges,dub_string_edges] = AddStrings(GH,h_node_order,string_edges); 

figure;
h = plot(GH,'EdgeLabel',GH.Edges.Type);
highlight(h,string_edges(:,1),string_edges(:,2),'EdgeColor','r','LineWidth',1.5)
if ~isempty(dub_string_edges)
    highlight(h,dub_string_edges(:,1),dub_string_edges(:,2),'EdgeColor','g','LineWidth',1.5)
end





