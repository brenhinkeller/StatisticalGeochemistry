Guide to files in this directory:

ign.mat (.xlsx, .csv.gz, igntext.mat) — the raw igneous dataset used in Keller and Schoene 2012, 2016, …

montecarlo.m — General purpose bootstrap resampling code with time as the independent variable. Relies on mctask.m within parallel for loop.

montecarlomelt.m — Bootstrap resampling code to calculate best-fit mantle melting with time as the independent variable. Relies on mctaskmelt.m within parallel for loop. Substitute mctaskmeltrejectr.m to reject samples with high residuals.

mctest.m — Precompute a ~10^7-row bootstrap-resampled dataset, for quick inspection. Can plot elemental trends from this dataset with plotmcvariable.m and ratios with plotmcvariables.m 

BasaltCrossplots.m — Explore a variety of geochemical crossplots as in Figure 5 of Keller and Schoene 2016. Relies on the precomputed dataset from mctest.m

plotMeltsPressureSeries.m — Explore the effect of melting pressure and mantle melting extent on various geochemical trends, c.f. BasaltCrossplots.m

CalculateMeltsBatchForwardTrace.m - Calculate trace element trends based on MELTS simulations and GERM partition coefficients, as in Figures 9-10 of Keller and Schoene 2016. Relies on the output of montecarlomelt.m

plotcovariance.m — Plot a graphical covariance matrix showing positive and negative correlations between different of elements in the igneous dataset.

