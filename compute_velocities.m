% method 1 for tip velocity

%Computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% these are assumed to be legal values that are roots of the error funcs!
%leg_params: a struct containing the parameters that describe the linkage
%theta: the current angle of the crank
%OUTPUTS:
%dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta = compute_velocities(vertex_coords, leg_params, theta)
    %Create function
    length_errors = @(v) link_length_error_func(v, leg_params);
    %Create Jacobian matrix
    J = approximate_jacobian(length_errors, vertex_coords);
    %Find derivatives of (x1, y1) and (x2, y2) using known derivative
    %equations for sin(x) (cos(x)) and cos(x) (-sin(x))
    clengths = link_params.crank_length; %Pulling lengths for derivatives
    dxdtheta = clengths*-sin(theta) %derivative of cos(theta), or x value
    dydtheta = clengths*cos(theta) %derivative of sin(theta), or y value

    %Create M and B matrices
    M = [eye(4), 0; J];
    B = zeros(14);
    B(1) = dxdtheta; B(2) = dydtheta;

    %Compute dVdtheta
    dVdtheta = M\B;
end
