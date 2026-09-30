function [dvdtheta] = M_function(vertex_coords, leg_params)
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
    ];

M=zeros(10,14);
I=zeros(4,14);

%Row 1
M(1,1)=-2*(vertex_coords_guess(3,1)-vertex_coords_guess(1,1));
M(1,2)=-2*(vertex_coords_guess(3,2)-vertex_coords_guess(1,2));
M(1,5)=2*(vertex_coords_guess(3,1)-vertex_coords_guess(1,1));
M(1,6)=2*(vertex_coords_guess(3,2)-vertex_coords_guess(1,2));

%Row 2
M(2,1)=-2*(vertex_coords_guess(6,1)-vertex_coords_guess(1,1));
M(2,2)=-2*(vertex_coords_guess(6,2)-vertex_coords_guess(1,2));
M(2,11)=2*(vertex_coords_guess(6,1)-vertex_coords_guess(1,1));
M(2,12)=2*(vertex_coords_guess(6,2)-vertex_coords_guess(1,2));

% Row 3
M(3,5) = 2*(vertex_coords_guess(3,1)-vertex_coords_guess(2,1));
M(3,6) = 2*(vertex_coords_guess(3,2)-vertex_coords_guess(2,2));
M(3,3) = -2*(vertex_coords_guess(3,1)-vertex_coords_guess(2,1));
M(3,4) = -2*(vertex_coords_guess(3,2)-vertex_coords_guess(2,2));

% Row 4
M(4,7) = 2*(vertex_coords_guess(4,1)-vertex_coords_guess(2,1));
M(4,8) = 2*(vertex_coords_guess(4,2)-vertex_coords_guess(2,2));
M(4,3) = -2*(vertex_coords_guess(4,1)-vertex_coords_guess(2,1));
M(4,4) = -2*(vertex_coords_guess(4,2)-vertex_coords_guess(2,2));

% Row 5
M(5,7) = 2*(vertex_coords_guess(4,1)-vertex_coords_guess(3,1));
M(5,8) = 2*(vertex_coords_guess(4,2)-vertex_coords_guess(3,2));
M(5,5) = -2*(vertex_coords_guess(4,1)-vertex_coords_guess(3,1));
M(5,6) = -2*(vertex_coords_guess(4,2)-vertex_coords_guess(3,2));

% Row 6
M(6,9)  = 2*(vertex_coords_guess(5,1)-vertex_coords_guess(4,1));
M(6,10) = 2*(vertex_coords_guess(5,2)-vertex_coords_guess(4,2));
M(6,7)  = -2*(vertex_coords_guess(5,1)-vertex_coords_guess(4,1));
M(6,8)  = -2*(vertex_coords_guess(5,2)-vertex_coords_guess(4,2));

% Row 7
M(7,11) = 2*(vertex_coords_guess(6,1)-vertex_coords_guess(5,1));
M(7,12) = 2*(vertex_coords_guess(6,2)-vertex_coords_guess(5,2));
M(7,9)  = -2*(vertex_coords_guess(6,1)-vertex_coords_guess(5,1));
M(7,10) = -2*(vertex_coords_guess(6,2)-vertex_coords_guess(5,2));

% Row 8
M(8,13) = 2*(vertex_coords_guess(7,1)-vertex_coords_guess(5,1));
M(8,14) = 2*(vertex_coords_guess(7,2)-vertex_coords_guess(5,2));
M(8,9)  = -2*(vertex_coords_guess(7,1)-vertex_coords_guess(5,1));
M(8,10) = -2*(vertex_coords_guess(7,2)-vertex_coords_guess(5,2));

% Row 9
M(9,13) = 2*(vertex_coords_guess(7,1)-vertex_coords_guess(6,1));
M(9,14) = 2*(vertex_coords_guess(7,2)-vertex_coords_guess(6,2));
M(9,11) = -2*(vertex_coords_guess(7,1)-vertex_coords_guess(6,1));
M(9,12) = -2*(vertex_coords_guess(7,2)-vertex_coords_guess(6,2));

% Row 10
M(10,3)  = 2*(vertex_coords_guess(2,1)-vertex_coords_guess(6,1));
M(10,4)  = 2*(vertex_coords_guess(2,2)-vertex_coords_guess(6,2));
M(10,11) = -2*(vertex_coords_guess(2,1)-vertex_coords_guess(6,1));
M(10,12) = -2*(vertex_coords_guess(2,2)-vertex_coords_guess(6,2));

%Row 11
I(1,1) = 1;

%Row 12
I(2,2) = 1;

%Row 13
I(3,3) = 1;

%Row 14
I(4,4) = 1;

M = [I; M]
B=zeros(14,1);
B(1)= -leg_params.crank_length*sin(leg_params.theta);
B(2)= leg_params.crank_length*cos(leg_params.theta);
dvdtheta=M\B;
end




    