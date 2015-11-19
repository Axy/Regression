function [beta] = ridgeRegression(y, tX, lambda)
    M = (size(tX, 2)); %extract # of columns of Phi
    I = eye(M);
    I(1,1) = 0; 	%Because we want to penalize all beta but beta0 
    beta = (tX'*tX + lambda*I)\(tX'*y);
end

