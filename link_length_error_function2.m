function [length_errors,J] = link_length_error_function2(vertex_coords, leg_params)
vertex_coords_guess=column_to_matrix(vertex_coords);
length_errors=[...
    [(vertex_coords_guess(3,1)-vertex_coords_guess(1,1))^2+(vertex_coords_guess(3,2)-vertex_coords_guess(1,2))^2-leg_params.link_lengths(1)^2];...
    [(vertex_coords_guess(6,1)-vertex_coords_guess(1,1))^2+(vertex_coords_guess(6,2)-vertex_coords_guess(1,2))^2-leg_params.link_lengths(7)^2];...
    [(vertex_coords_guess(3,1)-vertex_coords_guess(2,1))^2+(vertex_coords_guess(3,2)-vertex_coords_guess(2,2))^2-leg_params.link_lengths(3)^2];...
    [(vertex_coords_guess(4,1)-vertex_coords_guess(2,1))^2+(vertex_coords_guess(4,2)-vertex_coords_guess(2,2))^2-leg_params.link_lengths(4)^2];...
    [(vertex_coords_guess(4,1)-vertex_coords_guess(3,1))^2+(vertex_coords_guess(4,2)-vertex_coords_guess(3,2))^2-leg_params.link_lengths(2)^2];...
    [(vertex_coords_guess(5,1)-vertex_coords_guess(4,1))^2+(vertex_coords_guess(5,2)-vertex_coords_guess(4,2))^2-leg_params.link_lengths(5)^2];...
    [(vertex_coords_guess(6,1)-vertex_coords_guess(5,1))^2+(vertex_coords_guess(6,2)-vertex_coords_guess(5,2))^2-leg_params.link_lengths(8)^2];...
    [(vertex_coords_guess(7,1)-vertex_coords_guess(5,1))^2+(vertex_coords_guess(7,2)-vertex_coords_guess(5,2))^2-leg_params.link_lengths(9)^2];...
    [(vertex_coords_guess(7,1)-vertex_coords_guess(6,1))^2+(vertex_coords_guess(7,2)-vertex_coords_guess(6,2))^2-leg_params.link_lengths(10)^2];...
    [(vertex_coords_guess(2,1)-vertex_coords_guess(6,1))^2+(vertex_coords_guess(2,2)-vertex_coords_guess(6,2))^2-leg_params.link_lengths(6)^2];...
    [vertex_coords_guess(2,1)-leg_params.vertex_pos2(1)];...
    [vertex_coords_guess(2,2)-leg_params.vertex_pos2(2)];...
    [vertex_coords_guess(1,1)-leg_params.crank_length*cos(leg_params.theta)];...
    [vertex_coords_guess(1,2)-leg_params.crank_length*sin(leg_params.theta)];...
    ];

J=zeros(10,14);

%Row 1
J(1,1)=-2*(vertex_coords_guess(3,1)-vertex_coords_guess(1,1));
J(1,2)=-2*(vertex_coords_guess(3,2)-vertex_coords_guess(1,2));
J(1,5)=2*(vertex_coords_guess(3,1)-vertex_coords_guess(1,1));
J(1,6)=2*(vertex_coords_guess(3,2)-vertex_coords_guess(1,2));

%Row 2
J(2,1)=-2*(vertex_coords_guess(6,1)-vertex_coords_guess(1,1));
J(2,2)=-2*(vertex_coords_guess(6,2)-vertex_coords_guess(1,2));
J(2,11)=2*(vertex_coords_guess(6,1)-vertex_coords_guess(1,1));
J(2,12)=2*(vertex_coords_guess(6,2)-vertex_coords_guess(1,2));

% Row 3
J(3,5) = 2*(vertex_coords_guess(3,1)-vertex_coords_guess(2,1));
J(3,6) = 2*(vertex_coords_guess(3,2)-vertex_coords_guess(2,2));
J(3,3) = -2*(vertex_coords_guess(3,1)-vertex_coords_guess(2,1));
J(3,4) = -2*(vertex_coords_guess(3,2)-vertex_coords_guess(2,2));

% Row 4
J(4,7) = 2*(vertex_coords_guess(4,1)-vertex_coords_guess(2,1));
J(4,8) = 2*(vertex_coords_guess(4,2)-vertex_coords_guess(2,2));
J(4,3) = -2*(vertex_coords_guess(4,1)-vertex_coords_guess(2,1));
J(4,4) = -2*(vertex_coords_guess(4,2)-vertex_coords_guess(2,2));

% Row 5
J(5,7) = 2*(vertex_coords_guess(4,1)-vertex_coords_guess(3,1));
J(5,8) = 2*(vertex_coords_guess(4,2)-vertex_coords_guess(3,2));
J(5,5) = -2*(vertex_coords_guess(4,1)-vertex_coords_guess(3,1));
J(5,6) = -2*(vertex_coords_guess(4,2)-vertex_coords_guess(3,2));

% Row 6
J(6,9)  = 2*(vertex_coords_guess(5,1)-vertex_coords_guess(4,1));
J(6,10) = 2*(vertex_coords_guess(5,2)-vertex_coords_guess(4,2));
J(6,7)  = -2*(vertex_coords_guess(5,1)-vertex_coords_guess(4,1));
J(6,8)  = -2*(vertex_coords_guess(5,2)-vertex_coords_guess(4,2));

% Row 7
J(7,11) = 2*(vertex_coords_guess(6,1)-vertex_coords_guess(5,1));
J(7,12) = 2*(vertex_coords_guess(6,2)-vertex_coords_guess(5,2));
J(7,9)  = -2*(vertex_coords_guess(6,1)-vertex_coords_guess(5,1));
J(7,10) = -2*(vertex_coords_guess(6,2)-vertex_coords_guess(5,2));

% Row 8
J(8,13) = 2*(vertex_coords_guess(7,1)-vertex_coords_guess(5,1));
J(8,14) = 2*(vertex_coords_guess(7,2)-vertex_coords_guess(5,2));
J(8,9)  = -2*(vertex_coords_guess(7,1)-vertex_coords_guess(5,1));
J(8,10) = -2*(vertex_coords_guess(7,2)-vertex_coords_guess(5,2));

% Row 9
J(9,13) = 2*(vertex_coords_guess(7,1)-vertex_coords_guess(6,1));
J(9,14) = 2*(vertex_coords_guess(7,2)-vertex_coords_guess(6,2));
J(9,11) = -2*(vertex_coords_guess(7,1)-vertex_coords_guess(6,1));
J(9,12) = -2*(vertex_coords_guess(7,2)-vertex_coords_guess(6,2));

% Row 10
J(10,3)  = 2*(vertex_coords_guess(2,1)-vertex_coords_guess(6,1));
J(10,4)  = 2*(vertex_coords_guess(2,2)-vertex_coords_guess(6,2));
J(10,11) = -2*(vertex_coords_guess(2,1)-vertex_coords_guess(6,1));
J(10,12) = -2*(vertex_coords_guess(2,2)-vertex_coords_guess(6,2));

% Row 11
J(11,3) = 1;

% Row 12
J(12,4) = 1;

% Row 13
J(13,1) = 1;

% Row 14
J(14,2) = 1;

end




    