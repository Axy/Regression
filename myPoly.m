function Xpoly = myPoly(X,degree)
% build the matrix Phi for polynomial regression of a given degree
Xpoly = [];
for k = 1:degree
    Xpoly = [Xpoly X.^k];
    %fprintf(' x = %2f\n', Xpoly(:,k));
end

