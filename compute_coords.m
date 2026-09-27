% Strandbeest step 4, actually runs newton's method

%Computes the vertex coordinates that describe a legal linkage configuration
%INPUTS:
%vertex_coords_guess: a column vector containing the (x,y) coordinates of every vertex
% these coords are just a GUESS! It's used to seed Newton's method
%leg_params: a struct containing the parameters that describe the linkage
%theta: the desired angle of the crank
%OUTPUTS:
%vertex_coords_root: a column vector containing the (x,y) coordinates of every vertex
% these coords satisfy all the kinematic constraints!
function vertex_coords_root = compute_coords(vertex_coords_guess, leg_params, theta)

    % need to get function for newton's method
    fun = @(vertex_coords) linkage_error_func(vertex_coords, leg_params, theta);

    % newton's method thresholds
    ftol = 1e-14; % ftol: termination threshold (stop when abs(f(x_{i}))<ftol
    dxtol = 1e-14; % dxtol: termination threshold (stop when interval abs(x_{i+1}-x_i) < dxtol)
    dxmax = 1e14;
    max_iter = 1000; % number of iterations per trial
    num_iter = 1000; % number of trials we would like to perform

    % run newton's method
    [vertex_coords_root, exit_flag] = multidim_newton_solver(fun,vertex_guess_coords,dxtol,ftol, max_iter,dxmax);

end