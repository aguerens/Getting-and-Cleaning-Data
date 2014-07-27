##################################################
# run_analysis.R                                 #
#                                                #
# Goal: Make available datsets tidy for analysis #
#                                                #
# Author: Alec  // Course: Getting .... Data     #
##################################################

# This script must run from the same directory where data files are sitting (UCI HAR Dataset)
#
# Files to find in this folder:  activity_labels, features, features_info, README
# Directories within the folder: test, train

###############
# General     #
###############

# Packages loaded
library("stringr", lib.loc="~/R/win-library/3.1"); #>>> manipulate strings
library(plyr); #>>> to use ddply for final aggregation


#--- General files ---#
Temp_actLbls <- read.table("activity_labels.txt",header=FALSE,na.strings="NA")
df_activity <- data.frame(Temp_actLbls)
names(df_activity) <- c("Activity_Performed","Activity")

Temp_features <- read.table("features.txt",header=FALSE,na.strings="NA")
df_features <- data.frame(Temp_features)
df_Titles <- df_features[,2]

#--- Prepare Test files ---#
Temp_y_test <- read.table("./test/y_test.txt",header=FALSE,na.strings="NA")
df_y_test <- data.frame(Temp_y_test)
names(df_y_test) <- "Activity_Performed"

Temp_sbjt_test <- read.table("./test/subject_test.txt",header=FALSE,na.strings="NA")
df_subject_test <- data.frame(Temp_sbjt_test)
names(df_subject_test) <- "Subject"

Temp_x_test <- read.table("./test/x_test.txt",header=FALSE,na.strings="NA")
df_x_test <- data.frame(Temp_x_test)
names(df_x_test) <- df_Titles

#--- Prepare Train files ---#

Temp_y_train <- read.table("./train/y_train.txt",header=FALSE,na.strings="NA")
df_y_train <- data.frame(Temp_y_train)
names(df_y_train) <- "Activity_Performed"

Temp_sbjt_train <- read.table("./train/subject_train.txt",header=FALSE,na.strings="NA")
df_subject_train <- data.frame(Temp_sbjt_train)
names(df_subject_train) <- "Subject"

Temp_x_train <- read.table("./train/x_train.txt",header=FALSE,na.strings="NA")
df_x_train <- data.frame(Temp_x_train)
names(df_x_train) <- df_Titles


#-----------------------#
# Step 1
# Merges the training and the test sets to create one data set
#-----------------------#

#  Build TestSet
TestSet <- cbind(df_x_test,df_subject_test)
TestSet <- cbind(TestSet,df_y_test)

#  Build TrainSet
TrainSet <- cbind(df_x_train,df_subject_train)
TrainSet <- cbind(TrainSet,df_y_train)

#  Append TrainSet to TestSet 
TestTrainSet <- rbind(TestSet,TrainSet)


#-----------------------#
# Step 2
#  Extract only measurements on mean and standard deviation for each measurement. 
#-----------------------#

#--- Select variables that match criteria, blend into a single sorted vector
means <- as.vector(grep("mean()",df_Titles,fixed=TRUE))
stds <-  as.vector(grep("std()",df_Titles,fixed=TRUE))
MeansStds <- union(means,stds)
MeansStdsSort <- sort(as.numeric(MeansStds))

#--- Build a data.frame with the selected variables and add Subject and Activity code
#--- to the right side
TidyTemp <- TestTrainSet[,MeansStdsSort]
TidyTemp <- cbind(TidyTemp,TestTrainSet$Subject)
TidyTemp <- cbind(TidyTemp,TestTrainSet$Activity_Performed)

#--- Rename two last columns (Subject and Activity_Performed)
totalCols = ncol(TidyTemp)
names(TidyTemp)[totalCols-1] <- "Subject"
names(TidyTemp)[totalCols] <- "Activity_Performed"

#-----------------------#
# Step 3
# Uses descriptive activity names to name the activities in the data set
#-----------------------#

TidyTemp <- merge(TidyTemp,df_activity,by="Activity_Performed",sort=FALSE)
TidyTemp <- TidyTemp[,-1]

#-----------------------#
# Step 4
# Appropriately labels the data set with descriptive variable names. 
#-----------------------#

j <- 1

for(i in MeansStdsSort) 
  {  
  names(TidyTemp)[j] <- names(TestTrainSet)[i]
  j <- j+1
}


#-----------------------#
# Step 5
# Creates a second, independent tidy data set with the average of each variable for each activity 
# and each subject. 
#-----------------------#

# Based on Subject and Activity, only first 66 columns are valid variables (67 & 68 and dimensions)
TidyFinal <- ddply(TidyTemp, c("Subject","Activity"), function(x) colMeans(x[c(colnames(TidyTemp)[1:66])]))


#-------------------------------#
#    Write Outcome File         #
#-------------------------------#

write.table(TidyFinal,"TidySet.txt",row.names=FALSE)
