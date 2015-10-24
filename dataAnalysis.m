% ES 2 Final Project
% resultsAnalysis.m
% Zach Zager

%% Summary
% Loads recorded results for analysis (from 'CollectedData.mat').
% Finds mean response times, trims them down for analysis,
% fits them into a matrix for ANOVA testing, runs t-tests 
% to find location(s) of statistical significance.
% Plots results.

%% NOTES

% Saves plotted data at the end.
% Displays ANOVA results.
% Runs t-tests if ANOVA results are significant.
%    T-test results are stored in a struct. To access these values in the
%    struct type the letter corresponding to the value 
%    (h = hypothesis, i.e. if the results are statistically significant) 
%    (p = p-value, i.e. likelihood that difference are due to error)
%    then the numeric values of the two shapes 
%    {triangle(1) square(2) pentagon(3) hexagon(4)} 
%    you want to compare from smallest to greatest.
%    Examples:
%       1. To see if the difference between the triangle and the square data
%          is statistically significant, enter: 'h12' in the command prompt. 
%          It will return a boolean (0 or 1).
%       2. To see the p-value of the difference between the square and hexagon
%          data, enter: 'p23' in the command prompt. It will return a double.

%% Load Data
load('CollectedData.mat')

%% Concatenate data into matrices
responseTimes = cat(1,results.responseTime);
correctNumber = cat(1,results.correctNumber);
userCorrect = cat(1,results.userCorrect);

%% Group data into structs within cell arrays
% {triangle(1) square(2) pentagon(3) hexagon(4)}

shapeData = groupData(responseTimes,correctNumber,userCorrect);

%% store calculated results (means and SDs) in vectors
% [triangle(1) square(2) pentagon(3) hexagon(4)]

% Store untrimmed means and standard deviations
means=[shapeData{1}.Mean,shapeData{2}.Mean,shapeData{3}.Mean,shapeData{4}.Mean];
SDs = [shapeData{1}.SD shapeData{2}.SD shapeData{3}.SD shapeData{4}.SD];

% Store trimmed means and standard deviations
trimmedMeans = [shapeData{1}.trimmedMean,shapeData{2}.trimmedMean, ...
                shapeData{3}.trimmedMean,shapeData{4}.trimmedMean];
trimmedSDs = [shapeData{1}.trimmedSD,shapeData{2}.trimmedSD, ...
              shapeData{3}.trimmedSD,shapeData{4}.trimmedSD];

%% Calculate Regression Lines

% Untrimmed regression line
[a,SR,SE,St,rSqrd,yReg] = makeRegLine(means);

% Trimmed regression line
[aTrim,SrTrim,SETrim,StTrim,rSqrdTrim,yRegTrim] = makeRegLine(trimmedMeans);

%% Hypotheis Testing
% Tests for statistical significance of trimmed results

% Vector of lengths
AllLengthVec = [length(shapeData{1}.trimmedTimes), ...
                length(shapeData{2}.trimmedTimes), ...
                length(shapeData{3}.trimmedTimes), ...
                length(shapeData{4}.trimmedTimes)];

% cell array of the times
allTimes = {shapeData{1}.trimmedTimes shapeData{2}.trimmedTimes ...
            shapeData{3}.trimmedTimes shapeData{4}.trimmedTimes};

% fit the data into a matrix for anova testing
forAnova = makeAnovaMatrix(AllLengthVec,allTimes,trimmedMeans);

% RUN THE ANOVA (using the built-in ANOVA function)
% ANOVA = ANalysis Of VAriance
% p_anova stores p-value of the ANOVA
p_anova = anova1(forAnova);

% runs t-test (post-hoc test) if the ANOVA returns a statistically
% significant p-value
if p_anova < 0.05
    
    sprintf('Statistical significance detected by the ANOVA!')
    
    % t-tests
    % standard alpha level (0.05) to test for statistical significance
    % between each level of the independent variable
    runTTests(forAnova)
else
    sprintf('No statistical significance detected by the ANOVA!')
end

%% PLOTS
x = 1:4;
% untrimmed means
figure
hold on
plot(x,means,'o')
errorbar(means,SDs)
plot(x,yReg)
title('Results by Shape')
xlabel('Shape Complexity (1:Triangle, 2:Square, 3:Pentagon, 4:Hexagon)')
ylabel('Mean Response Time (seconds)')

print('Untrimmed Results by Shape','-djpeg') % save untrimmed means plot

% trimmed means
figure
hold on
plot(x,trimmedMeans,'o')
errorbar(trimmedMeans,trimmedSDs)
plot(x,yRegTrim)
title('Trimmed Results by Shape')
xlabel('Shape Complexity (1:Triangle, 2:Square, 3:Pentagon, 4:Hexagon)')
ylabel('Mean Response Time (seconds)')
hold off

print('Trimmed Results by Shape','-djpeg') % save trimmed means plot

%% ACKNOWLEDGEMENTS

% Victoria Floerke (my Experimental Psychology TA) for helping 
% me figure out what statistical analysis to use.

