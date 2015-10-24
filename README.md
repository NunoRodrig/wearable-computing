## README: Samsung Galaxy Accelerometer Application Data Analysis - Coursera Getting and Cleaning Data  Assigment

The R script (run_analysis.R) in this repository is a script to download, manipulate, summarize, and generate output of tidy data 
file as a requirement of the Coursera Getting and Cleaning Data Course Project.

The data is accelerometer information from a test among 30 subjects using the Samsung Galaxy smartphone app which measures physical
activity. The data for this project is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The run_analysis.R script is completely documented for easy understanding.  

The script sequence
 
   - downloads and decompress the source data file into a working directory
   - converts the raw data into R data frame objects
   - merges the train and test data into a single files for analysis
   - appends the subject ID to the appropriate row of data
   - changes the data column names to descriptive names
   - changes the activity data to descriptive names
   - produces an aggregated tidy data file of activities by subject

Files Required

Necessary data frame variables loaded at the start of our processing:
•activitylabels from "./UCI HAR Dataset/activity_labels.txt" 
•features from "./UCI HAR Dataset/features.txt"
•subjecttrain from "./UCI HAR Dataset/train/subject_train.txt"
•subjecttest from "./UCI HAR Dataset/test/subject_test.txt"
•xtrain from "./UCI HAR Dataset/train/X_train.txt"
•xtest from "./UCI HAR Dataset/test/X_test.txt"
•ytrain from "./UCI HAR Dataset/train/y_train.txt"
•ytest from "./UCI HAR Dataset/test/y_test.txt"

Transformations

Step 4 output:
•X_Train and X_Test files are loaded
•Features files is loaded
•X_Train and X_Test data.frames have their column names set using the data from the Features File
•Y_Train and Y_Test files are loaded
•Activity_labels file is loaded
•A new column, Activity is added to X_Traind and X_Test. It contains the data from Y_Train and Y_Test, but in transformed to be a factor. Data from Activity_labels is used to transform to get the appropiate names for the activities.
•Subject Data is added to X_Train and X_Test by reading the subject_Text and subject_Train files. It's added into a new column, called Subjects.
•xTrain and xTest are then concatenated
•Columns that are not called Activity, Subject or that do not have the words mean nor std in their name are dropped out
•Output is written 

Step5 output:
•Data is melted into a data frame that has 4 columns: Subject, Activity, Variable and the value for that combination.
•Data is grouped by Activity, Variable and Subject using ddply and the mean is taken for the values in the group
•Data is written 

