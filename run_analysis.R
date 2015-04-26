#----------------------------------------------------------------------------------------------------------------------

# Coursera Getting and Cleaning Data Course Project
# Adrián Álvarez del Castillo
# 2015-04-26

# runAnalysis.r

# This script will perform the following steps on the UCI HAR Dataset downloaded from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#----------------------------------------------------------------------------------------------------------------------

# Set up
rm(list=ls())
setwd('./data/UCI HAR Dataset/')

# 1. Merge the training and the test sets to create one data set.

# Read in the data from files
activities   = read.table('./activity_labels.txt')
features     = read.table('./features.txt')
subjectTrain = read.table('./train/subject_train.txt')
yTrain       = read.table('./train/y_train.txt')
xTrain       = read.table('./train/x_train.txt')
subjectTest  = read.table('./test/subject_test.txt')
yTest        = read.table('./test/y_test.txt')
xTest        = read.table('./test/x_test.txt')

# Create complete sets by merging train and test data
subjectData = rbind(subjectTrain,subjectTest)
yData       = rbind(yTrain,yTest)
xData       = rbind(xTrain,xTest)

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Get only columns with mean or std in their names
reqFeatures <- grep("-(mean|std)\\(\\)", features[, 2])

# Subset the x set with the required columns
xData <- xData[, reqFeatures]

# 3. Use descriptive activity names to name the activities in the data set

# Update id values with activity names
yData[, 1] <- activities[yData[, 1], 2]

# 4. Appropriately label the data set with descriptive activity names.

# Assign variable names
colnames(subjectData) = "subject"
colnames(yData)       = "activity"
colnames(xData)       = features[reqFeatures, 2]

# Create the complete sets by merging y, x and subject
allData = cbind(yData,subjectData,xData);

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Summarizing the allData table to calculate the mean of each variable by activity and subject
tidyData = aggregate(allData[,names(allData) != c('activity','subject')],by=list(activity=allData$activity,subject = allData$subject),mean)

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t')
