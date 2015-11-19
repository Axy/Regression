function [Y,meanX,stdX] = rescaleData(X)
    
    meanX = mean(X);
    Y = bsxfun(@minus, X, meanX);
    stdX = std(X);
    Y = bsxfun(@times, Y, 1./stdX);
end