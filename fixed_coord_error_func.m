% Strandbeest step 2!!

%Error function that encodes the fixed vertex constraints
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% same input as link_length_error_func
%leg_params: a struct containing the parameters that describe the linkage
% importantly, leg_params.crank_length is the length of the crank
% and leg_params.vertex_pos0 and leg_params.vertex_pos2 are the
% fixed positions of the crank rotation center and vertex 2.
%theta: the current angle of the crank
%OUTPUTS:
%coord_errors: a column vector of height four corresponding to the differences
% between the current values of (x1,y1),(x2,y2) and
% the fixed values that they should be
function coord_errors = fixed_coord_error_func(vertex_coords, leg_params, theta)
    % crank rotation point
    x0 = leg_params.vertex_pos(1);
    y0 = leg_params.vertex_pos(2);

    % crank radius
    r_crank = leg_params.crank_length;

    % desired position of vertex 1
    x1_desired = x0 + r_crank * cos(theta);
    y1_desired = y0 + r_crank * sin(theta);

    % desired position of vertex 2 (fixed!!)
    x2_desired = leg_params.vertex_pos2(1);
    y2_desired = leg_params.vertex_pos2(2);

    % current vertex positions
    x1 = vertex_coords(1);
    y1 = vertex_coords(2);
    x2 = vertex_coords(3);
    y2 = vertex_coords(4);

    coord_errors = [x1 - x1_desired;
                    y1 - y1_desired;
                    x2 - x2_desired;
                    y2 - y2_desired];

end