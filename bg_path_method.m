G = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);

G.Edges.Type(:) = {'tube'};
deg = degree(G);
h = plot(G,'EdgeLabel',G.Edges.Type);

%% Determing if path is Graph is Eulerian (Can be made with one tube)

E = G.Edges.EndNodes;
[isEulerian, path] = grIsEulerian(E);
path_edges = E(path,:);

%% Construct new graph

if (isEulerian ~= 0)  
    
    %Find last node of graph
    [last_node] = FindLastNode(G,path);
    
    %Use edges to find each preceding node
    node_order = last_node;
    current_node = last_node;
    for i = 0:length(path)-1
        current_edge = path_edges(length(path_edges)-i,:);
        next_node = current_edge(current_edge ~= current_node);
        node_order = [node_order , next_node];
        current_node = next_node;
    end
    
end
%% Make directed graph

%Generate vectors for dir graph
s = node_order(1:length(node_order)-1);
t = node_order(2:length(node_order));

H = digraph(s,t);
plot(H)