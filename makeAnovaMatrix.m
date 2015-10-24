function forAnova = makeAnovaMatrix(AllLengthVec,allTimes,trimmedMeans)
% function forAnova = makeAnovaMatrix(AllLengthVec,allTimes,trimmedMeans)

% Purpose:
%   Fits all the time values stored in a cell array into a matrix
%   so they can be used by the 'anova1' function. Evenly distributes
%   values so the mean is retained for calculation.
%
% Inputs:
%   AllLengthVec = vector of all of the number of fitted response time values
%   allTimes = cell array of vectors of all of the times
%   trimmedMeans = vector of trimmed means
%
% Outputs:
%   forAnova = matrix of adjusted time values

% initialize ANOVA matrix
forAnova = ones(min(AllLengthVec),4);

% Make all vectors the minimum size by looping through and removing elements
% until they are all the same length as the smallest vector. The remaining
% values are updated to account for the values that are removed so the mean
% value will remain the same.
for i = 1:length(allTimes)
    
    currVec = allTimes{i}; % stores the vector at the current index
    
    % if larger than the smallest vector
    if length(currVec) > min(AllLengthVec)
        
        % determins what the new, smaller vector should equal
        desiredTotal = trimmedMeans(i)*min(AllLengthVec);
        
        % creates the new, smaller vector
        newTimeVec = currVec(1:min(AllLengthVec));
        
        % determines how much to add to / subtract from
        % each remaining vector element
        toDistribute = (desiredTotal - sum(newTimeVec))/min(AllLengthVec);
        
        % updates remaining vector values
        newTimeVec = newTimeVec + toDistribute;
        
        % stores a new vector in the appropriate spot  
        % in the new matrix that will be returned
        forAnova(:,i) = newTimeVec;
    
    else    % if one of the smallest vectors
        
        % stores an unupdated vector in the appropriate 
        % spot in the new matrix that will be returned
        forAnova(:,i) = currVec; 
    
    end

end

