T = 0.1;
sum_size = 1000;
total = 1000;
dt = T/sum_size;

n = randn(sum_size * total, 1);

S = zeros(total, sum_size*total);
for i=1:total
  S(i, (i-1)*sum_size + 1 : i*sum_size) = ones(1,sum_size);
end

N = S*n*dt;

std(N)
mean(N)
