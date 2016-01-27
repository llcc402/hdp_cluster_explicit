% Input:
%      N         a scalar. The number of observations in each group.
%      K         a scalar. The number of groups.
% Output:
%      data      a matrix of order K * N.
%      mixing    a matrix of order K * K.
%      mu        a row vector of length K. 
% Model:
% We assume there are K groups, and in each group we randomly pick K/2
% clusters, and the observations in this group are belong to one of these
% cluster.
function [data, mixing, mu, Z] = data_generate(N, K)
if nargin < 1
    N = 500;
end
if nargin < 2
    K = 5;
end
if K < 2
    error('The number of groups should be at least 2')
end

%--------------------------------------------------------------------------
% STEP 1: Generate group mixture measures
%--------------------------------------------------------------------------
mixing = zeros(K);
for k = 1:K
    ix = randperm(K, fix(K/2));
    mixing(k,ix) = rand(1, length(ix));
    mixing(k,:) = mixing(k,:) / sum(mixing(k,:));
end

%--------------------------------------------------------------------------
% STEP 2: Generate cluster centers
%--------------------------------------------------------------------------
mu = rand(1,K);
mu = mu + (0 : 4 : 4*(K-1));
mu = mu - mean(mu);

%--------------------------------------------------------------------------
% STEP 3: Generate latent variable
%--------------------------------------------------------------------------
Z = zeros(K, N);
for i = 1:K
    [~,~,Z(i,:)] = histcounts(rand(1, N), [0,cumsum(mixing(i,:))]);
end

%--------------------------------------------------------------------------
% STEP 4: Generate observations
%--------------------------------------------------------------------------
data = randn(K, N) + mu(Z);

end