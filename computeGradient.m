function [g] = computeGradient(y, tX, beta)
    e = y-tX*beta; %compute the error
    N = length(y);
    g = -1/N*(tX'*e);
end

