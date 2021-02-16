%% load data
data = readtable("co.csv");

% remove missing data
data = data(~any(ismissing(data),2),:);
count = height(data);

%% create X, Y
X = data(:,2:3);
X = X{:,:};

mean_X = mean(X);
std_X = std(X);
X = (X - mean_X) ./ std_X;

Y = data(:,1);
Y = Y{:,:};

%% cross-validate: h1 for RH, h2 for T

N_grid = 30;
h1_grid = linspace(0.05, 0.3, N_grid);
r_grid = linspace(0.1, 2.5, N_grid);
loss = zeros(N_grid, N_grid);
for i=1:N_grid
    h1 = h1_grid(i);
    for j=1:N_grid
        r = r_grid(j);
        h2 = h1 / r;
        h = [h1, h2];
        loss(i,j) = cross_validate_kernel_regression(X, Y, h);
        fprintf('i= %d, j= %d\n', i, j)
    end
end

save('cross_validate_result.mat', 'h1_grid', 'r_grid', 'loss')

[xaxis, yaxis] = meshgrid(h1_grid, r_grid);
mesh(xaxis, yaxis, loss);

[min_value, arg_min] = min(loss(:));
[h1_index, r_index] = ind2sub(size(loss), arg_min);

optimal_h1 = h1_grid(h1_index);
optimal_r = r_grid(r_index);
optimal_h2 = optimal_h1 / optimal_r;

fprintf('Select h1= %f, r = %f, h2 = %f, n = %f', optimal_h1, optimal_r, optimal_h2, count)

optimal_h = [optimal_h1, optimal_h2];

save('optimal_h.mat', 'optimal_h')