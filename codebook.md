Coursera getdata-013 Course Project
Matthias Ihl 

Introduction

This file contains some important additional information about data, variables, transformations and results 
performed and obtained through applying the script run_analysis.R

Raw Data

A complete description of the data used in this project can be found at 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The raw data for the course project can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

General Information about the dataset (see uci.edu link above)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 
3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been 
video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in 
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, 
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter 
with 0.3 Hz cutoff frequency was used. 

Step 1) Merge the training and the test sets to create one data set.

The data contained in features.txt, activity_labels.txt, subject_train.txt, X_train.txt, y_train.txt, subject_test.txt, 
X_test.txt and y_test.txt is read into tables, column names are assigned and finally the data is merged into one dataset.

Step 2) Extract only the measurements on the mean and standard deviation for each measurement.

This task is achieved by subsetting the data by an appropriate logical vector with TRUE for the mean, stdev and ID columns, in order to eliminate unnecessary columns.

Step 3) Use descriptive activity names to name the activities in the data set.

To this end the data subset is merged with the activityType table providing descriptive activity names.

Step 4) Label the data set with descriptive variable names.

The readability and descriptiveness of the variable names are improved using the gsub function to replace/enhance the labels.
 
Step 5) From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

The desired output is produced according to the instructions (data set as a txt file created with write.table() using row.name=FALSE)
