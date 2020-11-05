G1 = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);
G2 = graph ([1 1 1 2 3 4 5],[2 3 4 4 4 5 6]);
G3 = graph([1 1 1 1],[2 2 2 2]);
G4 = graph ([3 3 3 3 1 2 4 6 6],[1 2 4 5 2 4 5 2 4]);

G = {G1, G2, G3, G4};

H = GetNodeConfig(G);

close all
figure;
for i = 1:length(G)
    subplot(1,length(G)+1,i), plot(G{i});
    title(strcat('G',num2str(i)));
    
end
subplot(1,length(G)+1,length(G)+1), plot(H,'EdgeLabel',H.Edges.Type);
title('H');

h = plot(H,'EdgeLabel',H.Edges.Type);
title('H');

edges = H.Edges{:,1};
tube_edges = find(strcmp(H.Edges.Type, 'tube'));



% %Highlight string edges
highlight(h,1:length(tube_edges),2:length(tube_edges)+1,'EdgeColor','k','LineWidth',1.5)

% if ~isempty(h_string_edges_best)
%     highlight(h,h_string_edges_best(:,1),h_string_edges_best(:,2),'EdgeColor','r','LineWidth',1.5)
% end
% highlight(h,g_string_edges_best(:,1),g_string_edges_best(:,2),'EdgeColor','c','LineWidth',1.5);
% if ~isempty(dub_string_edges_best)
%     highlight(h,dub_string_edges_best(:,1),dub_string_edges_best(:,2),'EdgeColor','m','LineWidth',1.5);
% end
