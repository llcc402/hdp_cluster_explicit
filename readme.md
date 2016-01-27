# The Hierarchical Dirichlet Process for clustering

We assume the data set is a cluster of Gaussians. Further we know the data set is devided into groups and each group is a mixture of some clusters of the whole data set.

The model is summarized as:

	G0        ~  DP(gamma, H)
	G1,...,GK ~  DP(alpha, G0)
	z_{i,j}   ~  Gi
	d_{i,j}   ~  normal(mu_{z_{i,j}}, 1)
	mu_{k}    ~  H

Hence G1,...,GK share positions.

## Functions included:

1. data_generate: We generate K groups of data points and each group contains K/2 clusters. The data points in each group is a mixture of Gaussians.

2. hdp: sample the posterior distribution of the mixing measure for each group and the centers of the clusters.

## Scripts included:

1. main: An example of the repo.

## Figures included:

1. data.jpg: The histogram of the data set.

2. group1.jpg: The histogram of the first group.

3. mixing_1.jpg: The comparison of the mixing measure of the first group. It shows both the weights and the positions of the first mixing measure match.
