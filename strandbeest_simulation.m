%runs strandbeest simulation
function strandbeest_simulation()

    % linkage parameters
    leg_params = define_leg_parameters();

    %column vector of initial guesses
    %for each vertex location.
    %in form: [x1;y1;x2;y2;...;xn;yn]
    vertex_coords_guess = [...
    [   0;   50];... %vertex 1 guess
    [ -50;    0];... %vertex 2 guess
    [ -50;   50];... %vertex 3 guess 
    [-100;    0];... %vertex 4 guess
    [-100;  -50];... %vertex 5 guess
    [ -50;  -50];... %vertex 6 guess
    [ -50; -100]...  %vertex 7 guess  
    ];

    % choosing 1 rotation for assignment
    theta_vals = linspace(0, 2*pi, 120);


    %%% Set up figure for plot!!
    fig = figure();
    set(fig, 'Units', 'pixels');
    set(fig, 'Position', [100 100 1200 900]);
    video_name = 'strandbeest_animation.avi';
    writerObj = VideoWriter(video_name);
    writerObj.FrameRate = 30;
    writerObj.Quality = 100;
    open(writerObj);
    hold on;
    axis equal;
    grid on;


    % Fixed axis limits -- these DO NOT change during animation
    axis([-130 30 -130 50]);

    % LaTeX interpreters
    set(gca,'TickLabelInterpreter','latex');

    xlabel('$x\;(-)$','Interpreter','latex');
    ylabel('$y\;(-)$','Interpreter','latex');
    title('Strandbeest Linkage Animation','Interpreter','latex');

    % initialize linkage grawing
    leg_drawing = initialize_leg_drawing(leg_params);

    % need to overlay the leg tip in the animation
    vertex_seven_x = [];
    vertex_seven_y = [];
    vertex_seven_path = plot(nan, nan, 'LineWidth', 1.5);



    % main loop (frames!!)
    for i = 1:length(theta_vals)
        theta = theta_vals(i); % current crank angle
        vertex_coords = compute_coords(vertex_coords_guess, leg_params, theta);
        update_leg_drawing(vertex_coords, leg_drawing, leg_params);
        coords = column_to_matrix(vertex_coords);
        % record vertex 7 (f00t) position
        vertex_seven_x(end + 1) = coords(7, 1);
        vertex_seven_y(end + 1) = coords(7, 2);
        set(vertex_seven_path, 'XData', vertex_seven_x, 'YData', vertex_seven_y);

        % use current solution as next guess for newton solver
        vertex_coords_guess = vertex_coords;
        drawnow;
        frame = getframe(fig);
        writeVideo(writerObj,frame);
    end
    close(writerObj);

end