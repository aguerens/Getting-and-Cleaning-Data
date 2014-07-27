# Getting and Cleaning Data
## Course Project

### Author: Alec
==================================================================

An script called "run_analysis.R" was developed to convert raw data captured in the "UCI HAR Dataset" into a tidy dataset for processing.

A dataset ("TidySet.txt") resulting from processing the original raw data, conveys information about a set of experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. 

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

30 Subjects participated in the experiment where the six mentioned activities were performed. An average for each of the measured variables was calculated and included in the accompanying dataset ("TidySet.txt").

### "TidySet.txt" content - For each combination of Subject and Activity it is provided:

+ An identifier of the subject who carried out the experiment.
+ A label with the name of the Activity performed
+ The resulting average value for each of the metrics averaged-out.

### The deliverables includes the following files:

+ 'README.txt' (this file)
+ "run_analysis.R": the script used to convert experiment's original raw data into the Tidy dataset provided.
+ "TidySet.txt": the outcome of the above script, as described in the previous section
+ "CodeBook.md": a document with an explanation about  variables utilized in the "run_analysis.R" script
 
## Functional Modules

General Files
------------------------------
+ Prepare df's common to two datasets to be imported later (df_features, df_activity)
+ Prepare Test and Train Files
+ Import data files pertaining to the Test set (measurements, subjects, activities)

Step 1 - Merge the training and the test sets to create one data set
+ Using Test Measurements df, append the corresponding Subject and Activity codes using "cbind()" to build "TestSet" df.
+ Repeat the above with Train data to build "TrainSet"
+ Merge both cbind'ed df's into a single one "TestTrainSet" using rbind() (both sets have the same column number and layout).

Step 2 - Extract only measurements on mean and standard deviation for each measurement.
+ Using grep(), build a vector (df_Titles) with the column numbers for the features (measurements) of interest (see Note below).
+ Build and sort a single vector (MeansStds) having a single list of the columns that need to be processed
+ Apply "MeanStds" as the index for the completed "TestTrainSet" and build a df ("TidyTemp") with the selected variables.
+ Add Subject and Activity code on the right side of "TinyTemp" and rename the columns ("Activity" is renamed to ease using it as an index)
+ Note: by design decision, only those features (measured variables) having either the string "mean()" or "std()" were selected for the process.

Step 3 - Use descriptive activity names to name the activities in the data set
+ Using merge(), assign each row in "TidyTemp" an activity name by using "Activity_Performed" as the intersection between "TidyTemp" and "df_activity"
+ Remove the extra column (left-most) created by merge()'s outcome (the common index is unnecessary, since it was replaced by activity's name) 

Step 4 - Appropriately labels the data set with descriptive variable names.
+ Using "MeansStdsSort" as the list of columns captured ("means()" and "std()"), 
+ Capture from "TestTrainSet" the names of the columns, and set them as names on "TidyTemp"

Step 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. + Create an outcome file using write.table(), ready to be consumed from Excel as a Text file.
+ The file delivered, called "TidySet.txt" should be opened in Excel as "Delimited", using "space" as the inter-column separator.
