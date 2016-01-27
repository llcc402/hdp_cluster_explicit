function [mixing_post, Z_post, mu_post] = hdp(data, gamma, alpha, maxIter, actN)
if nargin < 4
    maxIter = 1000;
end
if nargin < 5
    actN = 100;
end

%--------------------------------------------------------------------------
% STEP 1: Init
%--------------------------------------------------------------------------
Z_post = ones(size(data)); % init all observations to be in cluster 1
mixing_post = zeros(size(data, 1), actN);
mu_post = randn(1, actN);

%--------------------------------------------------------------------------
% STEP 2: Gibbs sampling
%--------------------------------------------------------------------------
for iter = 1:maxIter
    
    % sample G0
    a = histcounts(Z_post(:), 1:actN+1);
    b = [cumsum(a(2:end), 'reverse'), 0];
    a = a + 1;
    b = b + gamma;
    V = betarnd(a,b);
    G0 = V;
    V = cumprod(1-V);
    G0(2:end) = G0(2:end) .* V(1:end-1);
    
    % sample G1:GK
    for i = 1:size(data,1)
        counts = histcounts(Z_post(i,:), 1:actN+1);
        a = alpha * G0 + counts;
        b = [cumsum(a(2:end), 'reverse'), 0];
        V = betarnd(a,b);
        mixing_post(i,:) = V;
        V = cumprod(1-V);
        mixing_post(i,2:end) = mixing_post(i,2:end) .* V(1:end-1);
    end
    
    % sample mu
    centers = accumarray(Z_post(:), data(:), [], @mean);
    ix = find(centers ~= 0);
    mu_post(ix) = centers(ix);
    
    % sample Z_post
    for i = 1:size(data, 1)
        for j = 1:size(data, 2)
            p = log(mixing_post(i,:)) + log(normpdf(data(i,j), mu_post)) ;
            p = p - max(p);
            p = exp(p);
            p = p / sum(p);
            [~,~,Z_post(i,j)] = histcounts(rand(1), [0, cumsum(p)]);
        end
    end
end

end