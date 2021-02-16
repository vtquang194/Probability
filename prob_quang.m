
%% compute probability

optimal_hr = [0.067 , 2.334];
[mu, sigma] = kernel_regression_with_var(X, X, Y, optimal_hr);


exceeding_Y = 0.7;

temperatures = [-3:3:24];
RH = linspace(1,100,100);
for temp=temperatures
    N_test = 100;
    temp =  temp * ones(1,100);
    X_test = [temp', RH'];
    
    X_test = (X_test - mean_X) ./ std_X;
    
    [mu_test, sigma_test] = kernel_regression_with_var(X_test, X, Y, optimal_hr);
    input_to_F = (exceeding_Y - mu_test) ./sqrt(sigma_test);
    
    prob = zeros(1,100);
    for i=1:100
        prob(i) = compute_F(Y, mu, sigma, input_to_F(i));
    end
    
    plot(RH, 1- prob, 'LineWidth', 2);
    a = gca;
    % set box property to off and remove background color
    set(a,'box','off','color','none')
    % create new, empty axes with box but without ticks
    b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
    % set original axes as active
    axes(a)
   
%     plot(RH, mu_test)
    hold on
end
