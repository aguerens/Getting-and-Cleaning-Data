# Functionality and Featuresrun_script
## run_script.R 

## Introduction
### runscript.R was created to process raw data sourced from the "UCI HAR" experiment (see the README.txt for more information on the experiment).
### This document delves into script's different components used to achieve the goal.

#### Note: for the sake of saving space, the acronym "df's" is used to represent "data frames"

## Index
Requirements
Processing modules and variables


Requirements
The following R packages have been loaded to implement script functionality
"stringr" => Needed for string manipulation
"plyr" => Needed to implement ddply for final aggregation
Directory structure
In addition, the script assumes it is run from the same directory where the original raw data folder structure was built.
In order to verify the above:
Perform a getwd() and check the final branch you are at is called "UCI HAR Dataset", and the following directories are available: "train" and "test"

Processing modules

Package Load
Load libraries needed for script execution (stringr and plyr)

General Files
Prepare df's common to two datasets to be imported later (df_features, df_activity)

Prepare Test and Train Files
Import data files pertaining to the Test set (measurements, subjects, activities)

Step 1 - Merge the training and the test sets to create one data set
Using Test Measurements df, append the corresponding Subject and Activity codes using "cbind()" to build "TestSet" df.
Repeat the above with Train data to build "TrainSet"
Merge both cbind'ed df's into a single one "TestTrainSet" using rbind() (both sets have the same column number and layout).

Step 2 - Extract only measurements on mean and standard deviation for each measurement.
Using grep(), build a vector (df_Titles) with the column numbers for the features (measurements) of interest (see Note below).
Build and sort a single vector (MeansStds) having a single list of the columns that need to be processed
Apply "MeanStds" as the index for the completed "TestTrainSet" and build a df ("TidyTemp") with the selected variables.
Add Subject and Activity code on the right side of "TinyTemp" and rename the columns ("Activity" is renamed to ease using it as an index)

Note: by design decision, only those features (measured variables) having either the string "mean()" or "std()" were selected for the process.

Step 3 - Use descriptive activity names to name the activities in the data set
Using merge(), assign each row in "TidyTemp" an activity name by using "Activity_Performed" as the intersection between "TidyTemp" and "df_activity"
Remove the extra column (left-most) created by merge()'s outcome (the common index is unnecessary, since it was replaced by activity's name) 

Step 4 - Appropriately labels the data set with descriptive variable names.
Using "MeansStdsSort" as the list of columns captured ("means()" and "std()"), 
Capture from "TestTrainSet" the names of the columns, and set them as names on "TidyTemp"

Step 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
Create an outcome file using write.table(), ready to be consumed from Excel as a Text file.
The file delivered, called "TidySet.txt" should be opened in Excel as "Delimited", using "space" as the inter-column separator.



