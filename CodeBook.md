# Functionality and Features

## run_analysis.R 

## Introduction

run_analysis.R was created to process raw data sourced from the "UCI HAR" experiment (see the README.txt for more information on the experiment).
This document delves into script's different components used to achieve the goal.

Note 1: for the sake of saving space, the acronym "df's" is used to represent "data frames"
Note 2: All measures are expressed in sensors units, normalized after being pre-processed applying noise filters.

## Index
+ Requirements
+ Variables used


## Requirements
The following R packages have been loaded to implement script functionality
"stringr" => Needed for string manipulation
"plyr" => Needed to implement ddply for final aggregation
Directory structure
In addition, the script assumes it is run from the same directory where the original raw data folder structure was built.
In order to verify the above:
Perform a getwd() and check the final branch you are at is called "UCI HAR Dataset", and the following directories are available: "train" and "test"

## Variables Used

+ df_features: Complete list of recorded measures, with a positioning code (index).
+ df_activity: Table of Activities codes and labels   
+ df_x_test: Values measured in the Test set
+ df_subject_test: Subject codes pertaining to measured values in the Test set
+ df_y_test: Activity  codes pertaining to measured values in the Test set
+ df_x_train: Values measured in the Trial set
+ df_subject_train: Subject codes pertaining to measured values in the train set
+ df_y_train: Activity  codes pertaining to measured values in the train set
+ TestSet: the cbind() of Test measures, Subjects and Activity codes.
+ TrainSet: the cbind() of Train measures, Subjects and Activity codes.
+ TestTrainSet: the rbind() df sourced from TestSet and TrainSet
+ df_Titles: list of the columns for features to be captured (those having mean() or std() in their names)
+ MeansStds: list of sorted column numbers to be captured from TestTrainSet
+ MeansStdsSort: sorted MeansStd df
+ TinyTemp: a df resulting from the selection of columns from TestTrainSet, using MeansStdsSort as an index reference
+ TidySet.txt: Name of the space delimited text file built to store the tidy dataset required.




