function [a,Sr,SE,St,rSqrd,yReg] = makeRegLine(means)
% function [a SR SE St rSquared yReg] = makeRegLine(means)

% Purpose:
%   Calculates the regression line for the inputted values
%
% Inputs:
%   means = vector of means
%
% Outputs:
%   a = vector of least-squares regression line coefficients
%   Sr = Sum of Squared Residuals to Model (Sr)
%   SE = Standard Error (Sy/x)
%   St = Sum of residuals to mean (St)
%   rSqrd = Coefficient of determination (r^2)
%   yReg = Calculate y-values of regression line

x = 1:4;

% Calculate least-squares regression line coefficients
a = [length(x) sum(x); sum(x) sum(x.^2)]\[sum(means); sum(x.*means)];

% Sum of Squared Residuals to Model (Sr)
Sr = sum((means-a(1)-a(2)*x).^2);

% Standard Error (Sy/x)
SE = sqrt(Sr/(length(x)-2));

% Sum of residuals to mean (St)
St = sum((means-mean(means)).^2);

% Coefficient of determination (r^2)
rSqrd = 1-(Sr/St);

% Calculate y-values of regression line
yReg = a(1) + a(2)*x;

