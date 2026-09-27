% wrapper for Part 5 of the first half of assignment 2

% wrapper finds the difference between current guess (projectile position) & target position and its derivatives with respect to
% theta and t

function [f_out, dfdx] = projectile_wrapper(X)
    % Unknown outputs
    theta = X(1);
    t = X(2);

    % constants
    g = 2.3; %m/sec^2
    v0 = 14; %m/sec
    px0 = 2; %m
    py0 = 4; %m

    % projectile x-y position
    px_proj = v0*cos(theta)*t + px0;
    py_proj = -0.5*g*t^2 + v0*sin(theta)*t + py0;

    % target position
    px_target = 7*cos(3*t-pi/7) + 2*cos(5*t+3*pi/2) + 28;
    py_target = 9*sin(3*t-pi/7) + 0.7*sin(5*t+3*pi/2) + 21;

    % difference between projectile and target positions
    f1 = px_proj - px_target;
    f2 = py_proj - py_target;
    f_out = [f1; f2];

    % jacobian
    df1_dtheta = -v0*t*sin(theta);
    df1_dt = v0*cos(theta) + 21*sin(3*t-pi/7) + 10*sin(5*t+3*pi/2);
    df2_dtheta = v0*t*cos(theta);
    df2_dt = -g*t + v0*sin(theta) - 27*cos(3*t-pi/7) - 3.5*cos(5*t+3*pi/2);

    dfdx = [df1_dtheta, df1_dt;
            df2_dtheta, df2_dt];

end