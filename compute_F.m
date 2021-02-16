function ret = compute_F(y, mu, sigma, t)

minus = t - (y - mu) ./ sqrt(sigma);

n = numel(y);

a = minus >=0;

a = double(a);

ret = sum(a)/n;

end

