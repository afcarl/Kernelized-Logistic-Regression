function [W, iterations, costT] = SGD100(Y, K, YT, KT, eta)
%StochasticGradientDescent100 This function finds the optimum model by
%incrementally updating the model using only 100 random points.

% Y - Vector of desired output values in training set 
% K - gram matrix for training input values
% YT - Vector of desired output values in test set
% KT - gram matrix for test input values
% eta - step size
% costT - test cost iteration by iteration
% W - model after BGD converges
% iterations - number of iterations in which BGD converges

n = length(Y);

W = ones(1000,1);
newW = zeros(1000,1);

epsilon = 1e-5;
lambda = 1e-3;
error = norm(newW - W);
iterations = 0;

tic
while error > epsilon && toc < 10
    iterations = iterations + 1;
    costT(iterations) = CostFunction(W, KT, YT);
    disp(strcat(num2str(iterations), ' : ' , num2str(error)))
    sigma = Sigma(Y .* (W'*K)');
    tmp = 0;
    for j = 1:100
        i = randi(1000);
        tmp = tmp/100 + (-K(:,i)*Y(i) + K(:,i)*(Y(i)*sigma(i)));
    end
    delta = tmp + 2*lambda*W;
    newW = W - delta*eta;
    error = norm(newW - W);
    W = newW;
end
toc
end

