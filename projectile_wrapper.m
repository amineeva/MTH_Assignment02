% wrapper for Part 5 of the first half of assignment 2

% wrapper finds the difference between current guess (projectile position) & target position and its derivatives with respect to
% theta and t

function [f_out, dfdx] = projectile_wrapper(X)
    % Unknown outputs
    theta = X(1);
    t = X(2);

    % projectile and target positions
    V_p = projectile_traj(theta,t);
    V_t = target_traj(t);
    f_out = V_p - V_t;

    % constants
    g = 2.3; %m/sec^2
    v0 = 14; %m/sec


    % Jacobian
    df1_dtheta = -v0*t*sin(theta);
    df1_dt = v0*cos(theta) + 21*sin(3*t-pi/7) + 10*sin(5*t+3*pi/2);
    df2_dtheta = v0*t*cos(theta);
    df2_dt = -g*t + v0*sin(theta) - 27*cos(3*t-pi/7) - 3.5*cos(5*t+3*pi/2);

    dfdx = [df1_dtheta, df1_dt;
            df2_dtheta, df2_dt];

end