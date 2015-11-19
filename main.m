clear all
load regression.mat;

X = X_train;
X = rescaleData(X);

y = y_train;
% idx = find (y(:)< 8900);
% y = y(idx);
% X = X(idx,:);

%%
%X(:,[4,8,23]) = [];


% Form (y,tX) to get regression data in matrix form
N = length(y);
D = size(X,2);

% split data in K fold
setSeed(1);
N = size(y,1);
idx = randperm(N);
alpha = 0.2;


% lambda values (INSERT CODE)
lambda = logspace(-6,5,100);
%lambda = 0;
degree = 3;
errStar = [];
for degree = 1:3
    for K = 2:6
        N = size(y,1);
        idx = randperm(N);
        Nk = floor(N/K); %suppose Nk = floor(101/4) = 25
        idxCV = [];
        for k = 1:K
            idxCV(k,:) = idx(1+(k-1)*Nk:k*Nk); %(1:25) / (26:50) / (51:75) /(76:100)
        end
        for i = 1:length(lambda)
            mseTeSub = [];
            mseTrSub = [];
            for k = 1:K
                % get k'th subgroup in test, others in train
                idxTe = idxCV(k,:);
                idxTr = idxCV([1:k-1 k+1:end],:); %[1:3 5:6] = [1 2 3 5 6]
                idxTr = idxTr(:); %transformed to column vector in order to have them all together in a vector
                yTe = y(idxTe); XTe = X(idxTe,:); yTr = y(idxTr); XTr = X(idxTr,:);
                % form tX (INSERT CODE)
                tXTr = [ones(length(yTr),1) myPoly(XTr,degree)];
                tXTe = [ones(length(yTe),1) myPoly(XTe,degree)];
                % least squares (INSERT CODE)
                if rank(X) == size(X,2)
                    beta = leastSquares(yTr,tXTr);
                    %beta = ridgeRegression(yTr, tXTr, lambda(i));
                    %beta = leastSquaresGD(yTr,tXTr,alpha);
                else
                    fprintf('RIDGE REGRESSION');
                    beta = ridgeRegression(yTr, tXTr, lambda(i));
                end
                % training and test MSE(INSERT CODE)
                mseTrSub(k) = sqrt(2*computeCost(yTr,tXTr,beta));
                % testing MSE using least squares
                mseTeSub(k) = sqrt(2*computeCost(yTe,tXTe,beta));
            end
            mseTr(i) = mean(mseTrSub);
            mseTe(i) = mean(mseTeSub);
        end

        [errStar2, lambdaStar] = min(mseTe);
        errStar(degree,K) = errStar2;
        fprintf('lambdaStar: %.6f   ', lambda(lambdaStar));
        fprintf('ErrStar: %.3f\n', errStar2);
        
        semilogx(lambda,mseTr,'b.', lambda, mseTe, 'r.');
    end
end
fprintf('NoDummy\n');
errStar