function [fval, J] = test_function01(X)
    x1 = X(1);
    x2 = X(2);
    x3 = X(3);
    f1 = x1^2 + x2^2 - 6 - x3^5;
    f2 = x1*x3 + x2 - 12;
    f3 = sin(x1 + x2 + x3);
    fval = [f1; f2; f3];
    J = zeros([length(fval), length(X)]);
    for i = 1:3
        for n = 1:3
            J(i,n) = diff(fval(i), X(n))
        end
    end    
end
