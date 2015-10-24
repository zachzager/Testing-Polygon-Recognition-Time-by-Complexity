% ES 2 Final Project
% main.m
% Zach Zager

% Purpose:
%   Allows for testing of the 'dataCollection' and 'dataAnalysis' scripts.
%

% Runs the data collection script.
% The argument is a boolean that tells the function whether or not
% to store the results:
% 0 = do not store the results
% 1 = store the results
% NOTE: Running dataCollection with an argument of (0) will use an abridged
% 12-shape list as opposed to the experimental 52-shape list. 
% RunningdataCollection with the argument (1) will run the normal 52-shape 
% experimental list.
dataCollection(0)


% runs the data analysis script
dataAnalysis
