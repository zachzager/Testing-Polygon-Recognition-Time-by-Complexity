function y = dataCollection(storeResults)
% function y = dataCollection(storeResults)

% Input:
%   storeResults = Boolean that tells the function whether or not to store the 
%                  results in the 'CollectedData.mat' file.
%                  If storeResults = 1, the normal 52-shape list is used and 
%                  the participant's results are stored.
%                  If storeResults = 0, an abridged 12-shape list is used for
%                  testing and the participant's results aren't stored.
%
% Output:
%   Saves participant data in the 'CollectedData.mat' file if the normal
%   experimental procedure is selected by the argument.

% Participant count: 22

%% What does it do?
% Runs the experiment script and collects data.
% Users guess which shape is being displayed.
% Response time, validity, participant number,
% and the correct response are recorded.

%% Basic program and experimental outline

% 1. Loads the file 'CollectedData.mat' that contains the struct 'results'
% 2. Fills the cell array 'shapeList' with the names of shapes to test in the
%    procedure.
% 3. Sets participant number as the size of 'results' + 1 so the next spot in
%    the struct array is filled with the current participant's data.
% 4. Informs the participant that they do not have to participate if they do
%    not want to. This is customary/required in psychological studies.
% 5. Runs through the experimental procedure, accepting participant input and
%    recording it as well as their response time and if they got the question
%    correct.
% 6. Tells the participant how many items they answered correctly.
% 7. Debriefs the participant.
% 8. Stores the participant's data in 'results' then saves 'CollectedData.mat'.

%% IMPORTANT NOTE

% If you decide to cancel the program (control-C) before the experiment has
% finished type: Screen('CloseAll') and press the 'enter' key. As long as 
% the typing cursor is in the Command Window the screen will close.

clc % clear command window

%% load data file
load('CollectedData.mat')

%% INFO

% make array of shapes for testing
% If results are being stored for the experiment, a 52-shape list is used.
% If the results are not being stored and the file is merely being tested, a
% 12-shape list is used.
if storeResults == 1
    % random (52-shape) list generated using https://www.random.org/lists/
    shapeList = {'hexagon' 'triangle' 'triangle' 'square' 'square' ...
                'hexagon' 'square' 'hexagon' 'square' 'hexagon' ...
                'square' 'hexagon' 'pentagon' 'triangle' 'triangle' ...
                'square' 'triangle' 'triangle' 'hexagon' 'triangle' ...
                'pentagon' 'square' 'pentagon' 'hexagon' 'pentagon' ...
                'hexagon' 'pentagon' 'triangle' 'square' 'square' ...
                'pentagon' 'square' 'pentagon' 'hexagon' 'hexagon' ...
                'triangle' 'hexagon' 'pentagon' 'pentagon' 'triangle' ...
                'pentagon' 'square' 'pentagon' 'triangle' 'hexagon' ...
                'triangle' 'square' 'hexagon' 'square' 'pentagon' ...
                'triangle' 'pentagon'};
elseif storeResults == 0
    % TEST LIST (12-shapes) [retained for later testing if necessary]
    shapeList = {'triangle' 'square' 'hexagon' 'pentagon' 'square'  ...
                 'hexagon' 'triangle' 'triangle' 'pentagon' 'square' ...
                 'pentagon' 'hexagon'};
end

% participant number (one more than the amount stored in the struct)
data.trialNumber = length(results) + 1;

%   OPEN SCREEN
HideCursor; % hide mouse cursor
CompScreen = get(0,'ScreenSize');

%% FIRST WINDOW(win)
w = Screen('OpenWindow',0,[900 900 1000],CompScreen); % Full sized screen
white=WhiteIndex(w);
Screen('FillRect', w, white); 

% font style and size
Screen('TextSize',w, 125);
Screen('TextFont',w,'Courier New');
Screen('TextStyle', w, 1);

DrawFormattedText(w,' Welcome to \n the experiment!','center', 'center')

Screen(w,'Flip'); % present screen.
WaitSecs(2);

%% SECOND WINDOW
% Shows the participant the shapes and their names.

Screen('TextSize',w, 40);
FlushEvents('keyDown') % clear any problems

text = 'You will be presented with a series of 52 shapes.';
Screen('DrawText',w,text,50,20,[0,0,0]);

text = 'They will each be one of the four following shapes:';
Screen('DrawText',w,text,50,100,[0,0,0]);

% Draw polygons %

% triangle
triPointList = [45 400; 150 200; 260 400];
Screen('FramePoly',w,[0 0 0],triPointList, 10)

% square
squarePointList = [50 500; 250 500; 250 700; 50 700];
Screen('FramePoly',w,[0 0 0],squarePointList, 10)

% pentagon
pentPointList = [700 290; 800 215; 900 290; 860 400; 740 400];
Screen('FramePoly',w,[0 0 0],pentPointList, 10)

% hexagon
hexPointList = [700 600; 750 513; 850 513; 900 600; 850 686; 750 686];
Screen('FramePoly',w,[0 0 0],hexPointList, 10)

% Draw shape names %
Screen('DrawText',w,'Triangle',270,270,[0,0,0]);
Screen('DrawText',w,'Square',270,625-50,[0,0,0]);
Screen('DrawText',w,'Pentagon',930,275,[0,0,0]);
Screen('DrawText',w,'Hexagon',930,625-50,[0,0,0]);
Screen('DrawText',w,'<Press 1, 2, 3, or 4 to continue>',240,750,[0,0,0]);
Screen(w,'Flip'); % present 'win' to screen
WaitSecs(2);% avoids ps pressing too quickly + continuing the experiment
KbWait;

%% THIRD WINDOW
% Shows the participant which key to press in response to each shape.

Screen('TextSize',w, 50);
FlushEvents('keyDown') % clear any problems

Screen('DrawText',w,'Please select the number option',125,20,[0,0,0]);
Screen('DrawText',w,'matching the shape on the screen.',110,80,[0,0,0]);

Screen('DrawText',w,'If you see a triangle, press the <1> key.',30,250,[0,0,0]);
Screen('DrawText',w,'If you see a square, press the <2> key.',30,350,[0,0,0]);
Screen('DrawText',w,'If you see a pentagon, press the <3> key.',30,450,[0,0,0]);
Screen('DrawText',w,'If you see a hexagon, press the <4> key.',30,550,[0,0,0]);

Screen('DrawText',w,'<Press 1, 2, 3, or 4 to continue>',140,730,[0,0,0]);
Screen(w,'Flip'); % present 'win' to screen
WaitSecs(2);% avoids ps  pressing too quickly + moving the experiment on
KbWait;

%% FOURTH WINDOW
% Final briefing before the experiment.
% Asks the user if they have any questions.

Screen('TextSize',w, 60);
FlushEvents('keyDown') % clear any problems

Screen('DrawText',w,'The experiment will begin',150,50,[0,0,0]);
Screen('DrawText',w,'as soon as you are ready.',150,110,[0,0,0]);

Screen('DrawText',w,'If you have any questions',150,240,[0,0,0]);
Screen('DrawText',w,'or concerns please notify',150,300,[0,0,0]);
Screen('DrawText',w,'the experimenter now.',150,360,[0,0,0]);

Screen('DrawText',w,'If you do not wish to',150,470,[0,0,0]);
Screen('DrawText',w,'participate please inform',150,530,[0,0,0]);
Screen('DrawText',w,'the experimenter now.',150,590,[0,0,0]);

Screen('DrawText',w,'<Press 1, 2, 3, or 4 to continue>',45,725,[0,0,0]);
Screen(w,'Flip'); % present 'win' to screen
WaitSecs(4); % avoids ps pressing too quickly + moving the experiment on
KbWait;

%% Loop through test items

% loop through questions
for z = 1:length(shapeList)
    
    Screen('FillRect', w, white); % pause before each new item
    Screen(w,'Flip'); % present 'win' to screen

    % Pause before each item
    pause on
    pause(2)

    % Set font size and style
    Screen('TextSize',w, 70);
    Screen('TextFont',w,'Courier New');
    Screen('TextStyle', w, 1);
    
    % Instructions and selection options
    Screen('DrawText',w,'What shape is this?',50,20,[0,0,0]);
    Screen('DrawText',w,'1.Triangle',110,600,[0,0,0]);
    Screen('DrawText',w,'2.Square',110,700,[0,0,0]);
    Screen('DrawText',w,'3.Pentagon',700,600,[0,0,0]);
    Screen('DrawText',w,'4.Hexagon',700,700,[0,0,0]);

    % Draw shape at index 'z' of the shape list
    if strcmp(shapeList{z},'triangle')
        triPointList = [400 500; 600 153; 800 500];
        Screen('FramePoly',w,[0 0 0],triPointList, 10)
        data.correctNumber(z) = 1;
    elseif strcmp(shapeList{z},'square')
        squarePointList = [400 150; 800 150; 800 550; 400 550];
        Screen('FramePoly',w,[0 0 0],squarePointList, 10)
        data.correctNumber(z) = 2;
    elseif strcmp(shapeList{z},'pentagon')
        pentPointList = [400 300; 600 150; 800 300; 710 500; 490 500];
        Screen('FramePoly',w,[0 0 0],pentPointList, 10)
        data.correctNumber(z) = 3;
    elseif strcmp(shapeList{z},'hexagon')
        hexPointList = [400 325; 500 152; 700 152; 800 325; 700 498; 500 498];
        Screen('FramePoly',w,[0 0 0],hexPointList, 10)
        data.correctNumber(z) = 4;
    end
    
    % show screen and prepare for user response
    Screen(w,'Flip');     % present 'win' to screen
    FlushEvents('keyDown')  % clear any problems
    secs0=GetSecs;          % set time 0 (for reaction time)
    KbWait;                 % Wait for a key press
    
    % Collect keyboard response
    % keyIsDown: 0 if no, 1 if yes
    % keyCode: numeric value of key pressed
    % NUMBER VALUES (1 = 30; 2 = 31; 3 = 32; 4 = 33)
    RestrictKeysForKbCheck([30, 31, 32, 33]); % restrict keys
    [keyIsDown, secs, keyCode] = KbCheck;     % Wait for/check key pressed
    userResponse = find(keyCode) - 29;        % key pressed
    
    % store data in struct
    data.guess(z) = userResponse; % responses
    data.responseTime(z) = secs-secs0; % response times
    data.userCorrect(z) = userResponse == data.correctNumber(z); % correct?
    
end

%% STATS WINDOW
% Tells the participant how many shapes they correctly guess 
% out of 52 (for experimental) or out of 12 (for testing)

Screen('TextSize',w,150);
FlushEvents('keyDown') % clear any problems

% stores number of correct responses as a string for printing
num = num2str(sum(data.userCorrect));

% Displays the number of correct shape guesses out of the number of total items
% in the list based on whether the experimental or test list 
if storeResults == 1
    text = [num '/52'];
elseif storeResults == 0
    text = [num '/12'];
end

Screen('DrawText',w,'You got',350,100,[0,0,0]);
Screen('DrawText',w,text,440,400,[0,0,0]);
Screen('DrawText',w,'shapes correct',10,600,[0,0,0]);

Screen(w,'Flip'); % present window to screen
WaitSecs(4);

%% DEBRIEFING WINDOW
% Debriefs the participant and thanks them for participating

Screen('TextSize',w, 60);
FlushEvents('keyDown') % clear any problems

Screen('DrawText',w,'Thank you for participating!',130,50,[0,0,0]);

Screen('DrawText',w,'The point of this experiment',110,200,[0,0,0]);
Screen('DrawText',w,'is to test for an association',110,260,[0,0,0]);
Screen('DrawText',w,'between a polygon''s complexity',110,320,[0,0,0]);
Screen('DrawText',w,'and the amount of time it',110,380,[0,0,0]);
Screen('DrawText',w,'takes to identify it.',110,440,[0,0,0]);
Screen('DrawText',w,'This will help study human',110,540,[0,0,0]);
Screen('DrawText',w,'visual-cognition and how we',110,600,[0,0,0]);
Screen('DrawText',w,'process shape schemas.',110,660,[0,0,0]);

Screen('DrawText',w,'<Press 1, 2, 3, or 4 to continue>',45,725,[0,0,0]);

Screen(w,'Flip'); % present 'win' to screen
WaitSecs(2); % avoids ps pressing too quickly + moving the experiment on
KbWait;

Screen('CloseAll'); % Close study interface
ShowCursor; % bring back the mouse cursor

%% Save Results if desired

if storeResults == 1
    % save user data in results file
    results(data.trialNumber) = data;

    % save data file
    save('CollectedData.mat','results')
end


%% ACKNOWLEDGEMENTS

% http://www.academia.edu/2614964/
%                   Creating_experiments_using_Matlab_and_Psychtoolbox
% Project: Creating experiments using Matlab and Psychtoolbox
% Author: Rachel Cooper

% Project: PTB - Accurate Timing Demo
% Author: Peter Scarfe

% Professor Heather Urry (my Experimental Psychology professor) in the 
% Tufts psychology department for helping me with experimental design.

