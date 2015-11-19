function [L] = computeCost(y, tX, beta)
    e = y-tX*beta; %compute the error
    N = length(y);
    L = e'*e/(2*N);
end
