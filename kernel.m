function output = kernel(X1,X2,h)

rescale_X1 = X1 ./h;
rescale_X2 = X2 ./h;

distance = sq_dist(rescale_X1', rescale_X2');

output = 0.5 * pi * h(1) * h(2) * exp(-0.5 * distance);

end

