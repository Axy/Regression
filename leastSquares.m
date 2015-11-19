function [beta] = leastSquares(y, tX)
    beta = (tX\(tX'\(tX'*y)));
end

