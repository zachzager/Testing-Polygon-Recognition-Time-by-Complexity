function ttestResults = runTTests(forAnova)
% function ttestResults = runTTests(forAnova)

% Purpose:
%   Runs t-tests for statistical significance between
%   all levels of the experimental results.
%   This follows an ANOVA test to check
%
% Input:
%   forAnova = matrix of values fitted for Anova testing
%
% Output:
%   ttestResults = struct containing all of the t-test results
%

% significance between the triangle and the square
[ttestResults.h12,ttestResults.p12] = ttest(forAnova(:,1),forAnova(:,2));

% significance between the square and the pentagon
[ttestResults.h23,ttestResults.p23] = ttest(forAnova(:,2),forAnova(:,3));

% significance between the pentagon and the hexagon
[ttestResults.h34,ttestResults.p34] = ttest(forAnova(:,3),forAnova(:,4));

% significance between the triangle and the pentagon
[ttestResults.h13,ttestResults.p13] = ttest(forAnova(:,1),forAnova(:,3));

% significance between the triangle and the hexagon
[ttestResults.h14,ttestResults.p14] = ttest(forAnova(:,1),forAnova(:,4));

% significance between the square and the hexagon
[ttestResults.h24,ttestResults.p24] = ttest(forAnova(:,2),forAnova(:,4));

