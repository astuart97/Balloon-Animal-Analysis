%% Generating Simple Graphs

%G = graph([1 2 3 4 1],[2 3 4 1 3]);
%G = graph([1 2 3 4 1 2],[2 3 4 1 3 4]);
%G = graph ([3 3 3 3 1 2 4],[1 2 4 5 2 4 5]);
%G = graph([1 2 3 4],[2 3 4 1]);
%G = graph([1 1 1 1],[2 2 2 2]);

G.Edges.Type(:) = {'tube'};
deg = degree(G);
h = plot(G,'EdgeLabel',G.Edges.Type);

%% Determing if path is Graph is Eulerian (Can be made with one tube)

E = G.Edges.EndNodes;
[isEulerian, path] = grIsEulerian(E);
H = G;

%% Handling Eulerian Path
string_edges = [];

if (isEulerian ~= 0)   
    %Find nodes with greater than two edges
    big_nodes = find(deg > 2);
    
    %Calculate last node
    [last_node] = FindLastNode(H,path);
    
    %Iterate through all nodes with greater than two edges (except last node)
    for i = 1:size(big_nodes,1)
        node2split = big_nodes(i);
        node_deg = deg(node2split);
        
        while ((node_deg > 2) && (node2split ~= last_node))
            %Find the last two edges in the eulerian path that go through this node
            [r,c] = find (E(path,:) == node2split);
            row2delete = maxk(r,2);

            %Save the other nodes that they are connected to
            edg = E(row2delete,:);
            nodesid = find(edg ~= node2split);
            connected_nodes = edg(nodesid);

            %delete these edges 
            %BUG!!! Can't deal with edge case when edges to delete are identical
            edges2delete = [max(findedge(H,connected_nodes(1),node2split)), max(findedge(H,connected_nodes(2),node2split))] ;  
            H = rmedge(H,edges2delete);

            %connect old nodes to a new node with a "tube" edge
            new_node = size(H.Nodes,1)+ 1;
            H = addedge(H,connected_nodes(1),new_node);
            if (connected_nodes(1) ~= connected_nodes(2))
                H = addedge(H,connected_nodes(2),new_node);
            end
            

            idx = findedge(H,connected_nodes(1),new_node);
            H.Edges.Type(idx) = {'tube'};       
            idx = findedge(H,connected_nodes(2),new_node);
            H.Edges.Type(idx) = {'tube'};

            %record where "string" edges should go
            string_edges = [string_edges;node2split,new_node];
           
            %decrement the degree of the larger node
            node_deg = node_deg - 2;
        end
        
        %Calculate a new Eulerian path for the updated graph
        E = H.Edges.EndNodes;
        [isEulerian, path] = grIsEulerian(E); 
        
        %Calculate new end node in path 
        [last_node] = FindLastNode(H,path);
    end
    
    % Split the end node (requires different method):   
    
    %Create a new node
    last_edge = E(path(length(path)),:);
    new_node = size(H.Nodes,1)+ 1;
    old_node = last_edge(last_edge ~= last_node); 
    %Remove the last edge
    H = rmedge(H,path(length(path)));
    %add a 'tube' edge from the new node to the node the last edge was
    %previously attached to
    H = addedge(H,old_node,new_node);
    idx = findedge(H,old_node,new_node);
    H.Edges.Type(idx) = {'tube'};

    string_edges = [string_edges;last_node,new_node];
    
    %add in string edges
    for i = 1:size(string_edges,1)
        H = addedge(H,string_edges(i,1),string_edges(i,2));
        idx = findedge(H,string_edges(i,1),string_edges(i,2));
        H.Edges.Type(idx) = {'string'};        
    end  

%Plot new graph    
figure;
plot(H)
h = plot(H,'EdgeLabel',H.Edges.Type);
highlight(h,string_edges(:,1),string_edges(:,2),'EdgeColor','r','LineWidth',1.5)
   
else 
    disp("NO LOOP");
end


%string_id = find(contains(G.Edges.Type,'string'));
%tube_id = find(contains(G.Edges.Type,'tube'));

