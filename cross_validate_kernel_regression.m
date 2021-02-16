function loss = cross_validate_kernel_regression(X, Y, h)

mean = kernel_regression(X, X, Y, h);

n = size(X, 1);

error = Y - mean;

K_0 = kernel(0,0, h);
K_X = kernel(X,X,h);

column_sum = sum(K_X,2);

denom = 1 - K_0 ./ column_sum;

loss = sum((error./denom).^2) /n;

end
