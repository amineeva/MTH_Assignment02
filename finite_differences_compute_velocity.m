function dVdtheta_fd = finite_differences_compute_velocity(vertex_coords_root, leg_params, theta)
    % use function and jacobian approximation function to compute dV/dtheta
    % wrapper is now f(theta) = V(theta)
    compute_coords_theta = @(theta_input) compute_coords(vertex_coords_root, leg_params, theta_input);

    % using approximate jacobian, 14 rows 1 column -> J = df/dX where X is
    % theta
    J = approximate_jacobian(compute_coords_theta, theta);

    dVdtheta_fd = J;
end
