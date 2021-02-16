function [mu, sigma] = kernel_regression_with_var(X, X_data, Y_data, h)

K_train = kernel(X_data, X_data, h);

K_test = kernel(X, X_data, h);

mu_train = K_train * Y_data ./ sum(K_train, 2);

mu = K_test * Y_data ./ sum(K_test, 2);

sigma = K_test * ((Y_data - mu_train).^2) ./ sum(K_test, 2);

end

