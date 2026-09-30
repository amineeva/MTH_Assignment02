%Updates the plot objects that visualize the leg linkage
%for the current leg configuration
%INPUTS:
%complete_vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%leg_drawing: a struct containing all the plotting objects for the linkage
%       leg_drawing.linkages is a cell array, where each element corresponds
%       to a plot of a single link (excluding the crank)
%       leg_drawing.crank is a plot of the crank link
%       leg_drawing.vertices is a cell array, where each element corresponds
%       to a plot of one of the vertices in the linkage
function update_leg_drawing(complete_vertex_coords, leg_drawing, leg_params)
    %iterate through each link, and update corresponding link plot
    vlist1 = leg_params.link_to_vertex_list(:, 1);
    vlist2 = leg_params.link_to_vertex_list(:, 2);

    v = column_to_matrix(complete_vertex_coords)
    for linkage_index = 1:leg_params.num_linkages
        %linkage_index is the label of the current link
         a = vlist1(linkage_index);
         b = vlist2(linkage_index);

         x1 = v(a, 1); y1 = v(a, 2);
         x2 = v(b, 1); y2 = v(b, 2);

        %line_x and line_y should both be two element arrays containing
        %the x and y coordinates of the line segment describing the current link
        line_x = [x1, x2];
        line_y = [y1, y2];
        set(leg_drawing.linkages{linkage_index},'xdata',line_x,'ydata',line_y); 
    end

    %iterate through each vertex, and update corresponding vertex plot
    for vertex_index = 1:leg_params.num_vertices

        %vertex_index is the label of the current vertex

        %dot_x and dot_y should both be scalars
        %specifically the x and y coordinates of the corresponding vertex
        dot_x = v(vertex_index, 1);
        dot_y = v(vertex_index, 2);
        
        set(leg_drawing.vertices{vertex_index},'xdata',dot_x,'ydata',dot_y); 
    end

    %iterate through each vertex, and update corresponding vertex plot


    %crank_x and crank_y should both be two element arrays
    %containing the x and y coordinates of the line segment describing the crank
    crank_x = leg_params.crank_length*cos(leg_params.theta);
    crank_y = leg_params.crank_length*sin(leg_params.theta);
    
    set(leg_drawing.crank,'xdata',crank_x,'ydata',crank_y);
end
    crank_x = leg_params.crank_length*cos(leg_params.theta);
    crank_y = leg_params.crank_length*sin(leg_params.theta);
    
    set(leg_drawing.crank,'xdata',crank_x,'ydata',crank_y);
end
