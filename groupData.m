function shapeData = groupData(responseTimes,correctNumber,userCorrect)
% function shapeData = groupData(responseTimes,correctNumber,userCorrect)

% Purpose:
%   Groups all of the important data from the struct array of
%   participant input data into a cell array
%
% Inputs:
%   responseTimes = matrix of participant response times
%   correctNumber = matrix of correct answers
%   userCorrect = boolean matrix of whether users were correct
%
% Outputs:
%   shapeData = cell array of structs of stored data
%               (status, times, mean, standard deviation)

% intialize cell array
shapeData = cell(1,max(max(correctNumber)));

%% Store Data

% loop through cell array, storing trimmed and untrimmed data
for m = 1:max(max(correctNumber))
    %% untrimmed results
    
    % boolean vector of where the participant guessed correctly,
    % removes false answers from the data
    shapeData{m}.Status = userCorrect(correctNumber == m);
    
    % stores vector of response times for the corresponding shape
    % [triangle = 1; square = 2; pentagon = 3; hexagon = 4]
    shapeData{m}.Times = responseTimes(correctNumber == m);
    
    % stores vector of response times for correct answers
    shapeData{m}.Times = shapeData{m}.Times(shapeData{m}.Status);
    shapeData{m}.Mean = mean(shapeData{m}.Times);
    shapeData{m}.SD = std(shapeData{m}.Times);

    %% trim results
    
    % get interquartile range
    prctile75 = prctile(shapeData{m}.Times,75); % get 75th percentile    
    prctile25 = prctile(shapeData{m}.Times,25); % get 25th percentile    
    
    % Trim times to include only those within the interquartile range
    shapeData{m}.trimmedTimes = shapeData{m}.Times(shapeData{m}.Times > ...
                            prctile25 & shapeData{m}.Times < prctile75);
    
    % store mean of the trimmed times
    shapeData{m}.trimmedMean = mean(shapeData{m}.trimmedTimes);
    
    % store standard deviation of the trimmed times
    shapeData{m}.trimmedSD = std(shapeData{m}.trimmedTimes);
    
end


