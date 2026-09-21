% Multidimensional Newton's method to find a root of f(X)

% X_n is input vector n, J is the partial derivative matrix, and F is the
% output vector

X_next = X_n - J\F;
