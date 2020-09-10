function [edge] = FindEulerPathsHelper(G,u,target_size)
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
          edge = [edge ;FindEulerPathsHelper(G_copy,v,target_size)];
          disp(edge);
      end
      
      % Record all paths that have the right number of edges (full path)
      if (length(edge) == target_size)
          disp("AYYYYE LEGGO");
          disp(edge);
      end
  end
      
end

