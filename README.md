Coursera getdata-013 Course Project

Intro

This repo contains my solution for the course project of the "Getting and Cleaning Data" part of the Data Science Specialization on Coursera.

Basic description of the data

The features are unlabeled and are supplied in the X_test.txt. The activity labels are supplied in the y_test.txt file. The test subjects can be foun in the subject_test.txt file, and similarly for the training set.

Necessary Modifications to the Script

When the source files are unzipped, it will be necessary to set the path of the working directory to the location of the source files before running run_analysis.R (please modify line 13 of the code).

About the script and the tidy dataset

The script run_analysis.R will merge the test and training sets together, labels will be  added and only mean and standard deviation columns will be retained. The final result a tidy data set containing the means of all the columns per test subject and per activity. A tidyData.txt will be written which can be found in this repo.

Prerequisites are:

1) The UCI HAR Dataset must be unzipped.
2) The working directory must be set appropriately (see above)

Additional information

Additional information about the variables, data, transformations and results can be found in the CodeBook.md file. 
