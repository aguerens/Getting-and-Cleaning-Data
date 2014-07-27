# Getting and Cleaning Data
#Course Project
Author: Alec
==================================================================

An script called "run_analysis.R" was developed to convert raw data captured in the "UCI HAR Dataset" into a tidy dataset for processing.

A dataset ("TidySet.txt") resulting from processing the original raw data, conveys information about a set of experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. 

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

30 Subjects participated in the experiment where the six mentioned activities were performed. An average for each of the measured variables was calculated and included in the accompanying dataset ("TidySet.txt").

"TidySet.txt" content - For each combination of Subject and Activity it is provided:
====================================================================================

- An identifier of the subject who carried out the experiment.
- A label with the name of the Activity performed
- The resulting average value for each of the metrics averaged-out.

The deliverables includes the following files:
=========================================

- 'README.txt' (this file)

- "run_analysis.R": the script used to convert experiment's original raw data into the Tidy dataset provided.

- "TidySet.txt": the outcome of the above script, as described in the previous section

- "CodeBook.md": a document with a detailed explanation about processes and variables utilized in the "run_analysis.R" script

