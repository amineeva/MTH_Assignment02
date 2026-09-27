% Multidimensional Newton's method to find a root of f(X)

% X_n is input vector n, J is the partial derivative matrix, and F is the
% output vector

% thresholds
ftol = 1e-14; % ftol: termination threshold (stop when abs(f(x_{i}))<ftol
dxtol = 1e-14; % dxtol: termination threshold (stop when interval abs(x_{i+1}-x_i) < dxtol)
dxmax = 1e14;
max_iter = 1000; % number of iterations per trial
num_iter = 1000; % number of trials we would like to perform


%%% Function 01 test

% working example
X = [1 5 10]';
[fval, J] = test_function01(X);
[X_output, exit_flag] = multidim_newton_solver(@test_function01,X, dxtol, ftol, num_iter, dxmax);

%%% Function 02 test
X = [1 5 10]';
[fval, J] = test_function02(X);
[X_output, exit_flag] = multidim_newton_solver(@test_function02,X, dxtol, ftol, num_iter, dxmax);
disp('Function 02 solution: ')
disp(X_output)

%%% Projectile test
theta0 = pi/8; % rads
t0 = 2; %sec
X = [theta0 t0]';
[X_output, exit_flag] = multidim_newton_solver(@projectile_wrapper, X, dxtol, ftol, num_iter, dxmax);
theta = X_output(1);
t_collision = X_output(2);
disp('Projectile solution: ')
disp(theta)
disp(t_collision)
projectile_simulation(theta,t_collision)




% Inputs:
% X: vector function of all inputs

function [X_output, exit_flag] = multidim_newton_solver(fun,X,dxtol,ftol, max_iter,dxmax)
    % exit_flag: success (1), fail (0) -> whether the function finishes
    %Initialize the code
    exit_flag = 0;
    X_output = X;
    disp(fun)

    for i = 1:max_iter
        [f, J] = fun(X);
        %Pulls the value of the function and its derivative at x = x0
        if norm(f) == 0
            %Checks if it is a true root
            X_output = X;
            exit_flag = 1;
            return
        elseif (norm(f) < ftol)
            %Ensures the solution isn't too small
            X_output = X;
            exit_flag = 1;
            return
        elseif norm(J) <= ftol
            %Checks if the denominator will be too small
            X_output = X;
            return
        end
        X_next = X - (J\f);
        %Calculates a new x for the next iterations
        if norm(X_next - X) < dxtol
            %Ensures the calculated step isn't too small
            X_output = X;
            exit_flag = 1;
            return
        elseif norm(X_next-X) > dxmax
            %ensures the calculated step isn't too mlarge
            X_output = X;
            return

        else
            X = X_next;
            %Establishes new value for x0 for next iteration
        end
    end
end
