%initialize leg_params structure
leg_params = struct();
%number of vertices in linkage
leg_params.num_vertices = 7;
%number of links in linkage
leg_params.num_linkages = 10;
%matrix relating links to vertices
leg_params.link_to_vertex_list = ...
[ 1, 3;... %link 1 adjacency
3, 4;... %link 2 adjacency
2, 3;... %link 3 adjacency
2, 4;... %link 4 adjacency
4, 5;... %link 5 adjacency
2, 6;... %link 6 adjacency
1, 6;... %link 7 adjacency
5, 6;... %link 8 adjacency
5, 7;... %link 9 adjacency
6, 7 ... %link 10 adjacency
];

%list of lengths for each link
%in the leg mechanism
leg_params.link_lengths = ...
[ 50.0,... %link 1 length
55.8,... %link 2 length
41.5,... %link 3 length
40.1,... %link 4 length
39.4,... %link 5 length
39.3,... %link 6 length
61.9,... %link 7 length
36.7,... %link 8 length
65.7,... %link 9 length
49.0 ... %link 10 length
];

%column vector of initial guesses
%for each vertex location.
%in form: [x1;y1;x2;y2;...;xn;yn]
vertex_coords_guess = [...
[ 0; 50];... %vertex 1 guess
[ -50; 0];... %vertex 2 guess
[ -50; 50];... %vertex 3 guess
[-100; 0];... %vertex 4 guess
[-100; -50];... %vertex 5 guess
[ -50; -50];... %vertex 6 guess
[ -50; -100]... %vertex 7 guess
];

%length of crank shaft
leg_params.crank_length = 15.0;
%fixed position coords of vertex 0
leg_params.vertex_pos0 = [0;0];
%fixed position coords of vertex 2
leg_params.vertex_pos2 = [-38.0;-7.8];
% 
leg_params.theta = pi/3;
% for plotting the velocity obtaining methods
    theta_velocity = linspace(0, 2*pi, 600);
    
    % Method 1 storage: implicit
    dxtip_implicit = zeros(size(theta_velocity));
    dytip_implicit = zeros(size(theta_velocity));

    % Method 2 storage: finite differences
    dxtip_fd = zeros(size(theta_velocity));
    dytip_fd = zeros(size(theta_velocity));

% calculate velocities
    % need to re-initialize the guesses
    vertex_coords_guess = [...
    [   0;   50];... %vertex 1 guess
    [ -50;    0];... %vertex 2 guess
    [ -50;   50];... %vertex 3 guess 
    [-100;    0];... %vertex 4 guess
    [-100;  -50];... %vertex 5 guess
    [ -50;  -50];... %vertex 6 guess
    [ -50; -100]...  %vertex 7 guess  
    ];
    
    for i = 1:length(theta_velocity) % running through all theta velocities we GAF about
    
        theta = theta_velocity(i);
    
        % need vertex coords for this theta
        vertex_coords = compute_coords(vertex_coords_guess, leg_params, theta);


        %%% method 1: implicit
        dVdtheta_1 = M_function(vertex_coords, leg_params);
        dxtip_implicit(i) = dVdtheta_1(end-1);
        dytip_implicit(i) = dVdtheta_1(end);

        %%% method 2: finite difference
        % get the theta 
        dVdtheta_2 = finite_differences_compute_velocity(vertex_coords, leg_params, theta); % also J
        %%%
    
        % Vertex 7 = entries 13 and 14
        dxtip_fd(i) = dVdtheta_2(end-1);
        dytip_fd(i) = dVdtheta_2(end);
    
        % Use current solution as next Newton guess
        vertex_coords_guess = vertex_coords;
    
    end



    %%% Plotting methods - method 1 in red, method 2 in blue
    
    % dx_tip/dtheta
    figure();
    hold on;
    plot(theta_velocity, dxtip_fd, 'r.', 'MarkerSize', 10);
    plot(theta_velocity, dxtip_implicit, 'b.', 'MarkerSize', 10);
    xlabel('$\theta\;(-)$', 'Interpreter', 'latex');
    ylabel('$dx_{\mathrm{tip}}/d\theta\;(-)$', 'Interpreter', 'latex');
    title('$x$-Direction Leg Tip (Vertex 7) Velocity', 'Interpreter', 'latex');
    legend({'Implicit', 'Finite Difference'},'Interpreter', 'latex');
    xlim([0 2*pi]);


    % dy_tip/dtheta
    figure();
    hold on;
    plot(theta_velocity, dytip_fd, 'r.', 'MarkerSize', 10);
    plot(theta_velocity, dytip_implicit, 'b.', 'MarkerSize', 10);
    xlabel('$\theta\;(-)$', 'Interpreter', 'latex');
    ylabel('$dy_{\mathrm{tip}}/d\theta\;(-)$', 'Interpreter', 'latex');
    title('$y$-Direction Leg Tip (Vertex 7) Velocity', 'Interpreter', 'latex');
    legend({'Implicit', 'Finite Difference'},'Interpreter', 'latex');
    xlim([0 2*pi]);

    %%%