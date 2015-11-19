function [ beta ] = leastSquaresGD( y, tX, alpha )
% algorithm parametes
maxIters = 1000;

D = size(tX,2)
% initialize
beta = (zeros(D,1));

% iterate
fprintf('Starting iterations, press Ctrl+c to break\n');
fprintf('L  beta0 beta1  iteration\n');
for k = 1:maxIters
    % FUNCTION FOR COMPUTING GRADIENT
    g = computeGradient(y,tX,beta);
    
    % FUNCTION FOR COMPUTING COST FUNCTION
    L = computeCost(y,tX,beta);
    
    % GRADIENT DESCENT UPDATE TO FIND BETA
    beta = beta - alpha.*g;
    
    % CODE FOR CONVERGENCE
    if(k-1 > 1)
        if (abs(L - L_all(k-1))<1e-7);
            break;
        end
    end
    % store beta and L
    beta_all(:,k) = beta;
    L_all(k) = L;
    
    % print
    fprintf('%.2f  %.2f %.2f %.2f\n', L, beta(1), beta(2), k);
end


