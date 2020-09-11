function [edge,good_paths] = FindEulerPathsHelper(G,u,target_size,good_paths)
%Recursively finds Euler path

%Recur for all the vertices adjacent to this vertex 

  edge = [];
  neighborss = neighbors(G,u);
  %Iterate through all neighboring nodes
  for (i = 1:length(neighborss))      
      v = neighborss(i);  
      
      %If there is a valid next edge between sourcen node and neighbor
      if (isValidNextEdge(G,u,v)) 
          E = findedge(G,u,v);
          edge2remove = E(1);
          edge = [u,v];
          
          %Remove edge from graph and recursively call function on subgraph
          G_copy = rmedge(G,edge2remove);
          [next_edge, good_paths] = FindEulerPathsHelper(G_copy,v,target_size,good_paths);
          edge = [edge ;next_edge];
      end
      
      % Record all paths that have the right number of edges (full path)
      if (size(edge,1) == target_size)        
          good_paths = [good_paths; edge];
      end
  end
      
end

