function [fval, J] = test_function01(X)
    x1 = X(1);
    x2 = X(2);
    x3 = X(3);
    f1 = x1^2 + x2^2 - 6 - x3^5;
    f2 = x1*x3 + x2 - 12;
    f3 = sin(x1 + x2 + x3);
    fval = [f1; f2; f3];
    df1x1 = 2*x1;
    df1x2 = 2*x2;
    df1x3 = 5*x3;
    df2x1 = x3;
    df2x2 = 1;
    df2x3 = x1;
    df3x1 = cos(x1 + x2 + x3);
    df3x2 = cos(x1 + x2 + x3);
    df3x3 = cos(x1 + x2 + x3);

    J = [df1x1, df1x2, df1x3; df2x1, df2x2, df2x3; df3x1, df3x2, df3x3];
end    
