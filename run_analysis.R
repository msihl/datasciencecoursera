# Coursera getdata-013 Getting and Cleaning Data Course Project, Matthias Ihl
# The following script is designed to perform the steps listed in the codebook.md markdown file on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# 1) Merge the training and the test sets to create one data set.

#set working directory 
setwd('/Users/ernstihl/Desktop/Coursera/DataScience/UCI_HAR_Dataset/');

#read in data
features = read.table('./features.txt',header=FALSE); 
activityType = read.table('./activity_labels.txt',header=FALSE); 
subject_train = read.table('./train/subject_train.txt',header=FALSE); 
x_train = read.table('./train/X_train.txt',header=FALSE); 
y_train = read.table('./train/y_train.txt',header=FALSE); 

#define column names
colnames(activityType)  = c('activityId','activityType');
colnames(subject_train)  = "subjectId";
colnames(x_train)        = features[,2]; 
colnames(y_train)        = "activityId";

#create the final training set by merging y_train, subject_train, and x_train
trainData = cbind(y_train, subject_train, x_train);

#read in test data
subject_test = read.table('./test/subject_test.txt',header=FALSE); 
x_test = read.table('./test/X_test.txt',header=FALSE); 
y_test = read.table('./test/y_test.txt',header=FALSE); 

#assign column names to test data
colnames(subject_test) = "subjectId";
colnames(x_test) = features[,2]; 
colnames(y_test) = "activityId";

#create test set by cbinding the y_test, subject_test and x_test
testData = cbind(y_test, subject_test, x_test);

#merge training and test data 
mergedData = rbind(trainData,testData);

#create vector of column names from the mergedData
colNames  = colnames(mergedData); 

# 2) Extract only the measurements on the mean and standard deviation for each measurement. 

#create a logical vector that contains TRUE values for the ID, mean() & stddev() columns
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

#subset finalData table based on the logicalVector 
mergedData = mergedData[logicalVector==TRUE];

# 3) Use descriptive activity names to name the activities in the data set

#merge the mergedData set with the activityType table to include descriptive activity names
mergedData = merge(mergedData,activityType,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(mergedData); 

# 4) Appropriately label the data set with descriptive activity names. 

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccelMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccelJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

#re-assigning the new descriptive column names 
colnames(mergedData) = colNames;

# 5) Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

#create a new tablewithout the activityType column
mergedDataWOA = mergedData[,names(mergedData) != 'activityType'];

#summarizing the mergedDataWOA table to include just the mean of each variable for each activity and each subject
tidyData = aggregate(mergedDataWOA[,names(mergedDataWOA) != c('activityId','subjectId')],by=list(activityId=mergedDataWOA$activityId,subjectId = mergedDataWOA$subjectId),mean);

#merging the tidyData with activityType (to include descriptive activity names)
tidyData = merge(tidyData,activityType,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');

