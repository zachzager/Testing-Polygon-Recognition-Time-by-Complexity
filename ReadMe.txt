*
ReadMe File
ES 2 Final Project
*
Title: Testing Polygon Recognition by Complexity
Author: Zach Zager
*
Note: The experimental portion of this program will not run if Psychtoolbox is not installed.


Abstract
========
The study of human cognitive processes is important for developing more user-friendly
technologies and better accommodate those with visual and learning disabilities (Koller,
2012). This project is designed to study human polygon recognition, specifically to test
for an association between polygon complexity (operationalized by number of vertices) 
and recognition time. The program measures response time to four different polygons and 
then runs statistical analyses and hypothesis testing. This work allows anyone (with 
MATLAB) to run this experiment, collect data and analyze the results.


Overview
========
This project is designed to test the hypothesis that polygon recognition time is
associated with polygon complexity. The function ‘dataCollection’ runs the experiment
and stores user data in the ‘CollectedData.mat’ file. The ‘dataAnalysis’ script loads
the data from ‘CollectedData.mat’ for statistical analysis. It conducts hypothesis
testing on the data to test for statistical significance. It also saves plots of the
experimental data.


How to use the code
===================
To run the experiment: The data collection and data analysis scripts are run separately
from the Command Window. Since data isn’t analyzed until after all participants have
completed the experiment this process works well.

To test: The included main file is designed to make testing the code very simple. It
inputs a false boolean argument to the ‘dataCollection’ function, which then runs a
modified version of the procedure. This test procedure only uses a 12-shape list in 
lieu of the experimental 52-shape list. It also does not store the results in the 
‘CollectedData.mat’ file. [I would recommend running the main file for grading, unless
you want to participate in the experiment and add your results to the data.]


Files Included
==============
CollectedData.mat	Contains the struct array ‘results’. This struct contains all
			of the past participants’ data for each test item: participant
			number, correct shape name, participant shape guess, participant
			response time, user correct (boolean).
			As of submitting this project (May 6, 2015) I have gathered
			data from 22 participants.

dataCollection.m	Function that runs the experimental script. Can run either the
			normal experimental procedure or a an abridged version for
			testing. Presents shapes to users and measures their response
			times as well as if they guessed the correct shape.
			Utilizes Psychtoolbox functionality extensively.
			
			Note: If you decide to cancel the program (control-C) before 
			the experiment has finished type: Screen('CloseAll') and press 
			the 'enter' key. As long as the typing cursor is in the Command 
			Window the screen will close.

dataAnalysis.m		Loads ‘CollectedData.mat’ to run analysis on the data stored
			in ‘results’. Utilizes several key functions to implement
			the numerical methods that allow hypothesis testing to take
			place. These include: groupData, makeRegLine, makeAnovaMatrix,
			anova1, and runTTests.
			Also, plots and saves the data.

groupData.m		Groups all of the important data (response times, correct
			shapes, and if the user was correct on each item) from the
			struct array of participant input data into a cell array,
			which it returns.

makeRegLine.m		Calculates the regression line for the inputted values in an
			inputted vector. Returns a vector of least-squares regression
			line coefficients, the Sum of Squared Residuals to Model (Sr),
			the Standard Error (Sy/x), the Sum of residuals to mean (St),
			the Coefficient of determination (r^2), and the y-values of
			the regression line.

makeAnovaMatrix.m	Fits all the time values stored in a cell array into a matrix
			so they can be used by the 'anova1' function. Evenly distributes
			values so the mean is retained for calculation.
			Arguments: vector of all of the number of fitted, cell array of
			vectors of all of the times, and a vector of trimmed means.
			argument
 			Output: matrix of adjusted time values that for ANOVA testing.

runTTests.m		Runs post-hoc t-tests for statistical significance between all
			levels of the result variables. Returns struct containing all
			of the t-test results.

main.m			Contains calls to ‘dataCollection’ and ‘dataAnalysis’ to allow
			for easy running/testing.	


Previously written code
=======================
• Psychtoolbox functions

• Creating experiments using Matlab and Psychtoolbox by Rachel Cooper
  (http://www.academia.edu/2614964/Creating_experiments_using_Matlab_and_Psychtoolbox)

• PTB - Accurate Timing Demo by Peter Scarfe
  (http://peterscarfe.com/accurateTimingDemo.html)

• MATLAB ‘anova1’ and ‘ttest’ functions

• Regression line calculation (from ES 2 - HW 11) by Zach Zager


Other Acknowledgements
======================
• Professor Heather Urry (my Experimental Psychology professor) in the Tufts
  psychology department for helping me with experimental design.

• Victoria Floerke (my Experimental Psychology TA) for helping me figure out what
  statistical analysis to use.

• Meera Punjiya for being available to help me with this project and ES 2 in general.


************************************************************************************
Questions or concerns relating to this program or the experimental procedure it is
designed to conduct can be direct to me at zachzager@gmail.com or 
zachary.zager@tuft.edu.
************************************************************************************

Enjoy!

