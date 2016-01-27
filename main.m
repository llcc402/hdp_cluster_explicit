clear
clc

[data, mixing, mu, Z] = data_generate();

tic;
[mixing_post, Z_post, mu_post] = hdp(data, 2, 1);
toc

ix1 = unique(Z(1,:));
ix2 = unique(Z_post(1,:));
plot(mu(ix1), mixing(1,ix1), 'o', mu_post(ix2), mixing_post(1,ix2), '*')
xlim([-10, 10])
hold on
line([mu(ix1); mu(ix1)], [zeros(1, length(ix1)); mixing(1,ix1)], 'color', 'blue')
line([mu_post(ix2); mu_post(ix2)], [zeros(1, length(ix2)); mixing_post(1,ix2)], 'color', 'red')
title('The mixing measure of the first group')
xlabel('atoms')
ylabel('probabilities')
legend('theoretical', 'sampled')
hold off

figure(2)
hist(data(:), 50)
title('The histogram of the data set')

figure(3)
hist(data(1,:), 100)
title('The histogram of the first group of the data set')