function mu = kernel_regression(X, X_data, Y_data, h)

K_test = kernel(X, X_data, h);

mu = K_test * Y_data ./ sum(K_test, 2);

end

