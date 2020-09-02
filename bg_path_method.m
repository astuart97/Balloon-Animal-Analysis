G = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);
%G = graph([1 2 3 4 1],[2 3 4 1 3]);
%G = graph([1 1 1 1],[2 2 2 2]);
%G = graph([1 1 2 2 3 3 4 4 5],[2 3 3 4 4 5 5 6 6]);

G.Edges.Type(:) = {'tube'};
deg = degree(G);
h = plot(G,'EdgeLabel',G.Edges.Type);

%% Determing if path is Graph is Eulerian (Can be made with one tube)

E = G.Edges.EndNodes;
[isEulerian, path] = grIsEulerian(E);
path_edges = E(path,:);

%% Generate node order from Eulerian Path

if (isEulerian ~= 0)  
    
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
    
end
%% Make directed graph using node orders

%Generate vectors for dir graph
s = node_order(1:length(node_order)-1);
t = node_order(2:length(node_order));

D = digraph(s,t);
plot(D)

%% Generate additional nodes for overlaps

H = graph([1:length(node_order)-1],[2:length(node_order)]);
H.Edges.Type(:) = {'tube'};

visited_nodes = [];
string_edges = [];

for i = 1:length(node_order)
    current_node = node_order(i);
    if (ismember(current_node,visited_nodes))
        H = addedge(H,i,find(node_order == current_node,1));
        idx = findedge(H,i,find(node_order == current_node,1));
        H.Edges.Type(idx) = {'string'};
        string_edges = [string_edges; i,find(node_order == current_node,1)];
    else    
        visited_nodes = [visited_nodes, current_node];
    end    
end

figure;
plot(G)

figure;
h = plot(H,'EdgeLabel',H.Edges.Type);
highlight(h,string_edges(:,1),string_edges(:,2),'EdgeColor','r','LineWidth',1.5)