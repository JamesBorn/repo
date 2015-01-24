#The goal for tis project is to prepare tidy data that can be used for later analysis.
#You will be graded by your peers on a series of yes/no questions 
#related to the project. You will be required to submit: 
#1) a tidy data set as described below,
#2) a link to a Github repository with your script for performing the analysis, and
#3) a code book that describes the variables, the data, and any transformations 
#or work that you performed to clean up the data called CodeBook.md.
#You should also include a README.md in the repo with your scripts.
#This repo explains how all of the scripts work and how they are connected
#DATA
#Here are the data for the project:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy 
#data set with the average of each variable for each activity and each subject.
# 1.Merges the training and the test sets to create one data set 

#set working directory to the location where the UCI HAR Dataset was unzipped
#clean up workespace
rm(list=ls())
setwd("C:/Users/ryUser/geting_cleaning2/UCI HAR Dataset")
#We begin to read to Read  data like features because it contain the complete list 
#of variables of each feature vector and shows information about it and the Type 
#of activity as Typeactivity because they have activity labels for each record.
#import features.txt that list of all features
Features = read.table('features.txt',header=FALSE)
#import activity_labels.txt Links the class labels with their activity name
Typeactivity = read.table('activity_labels.txt',header=FALSE)
# Assigin column names to the Typeactivity
colnames(Typeactivity) = c('activity_Id',' Typeactivity ')

# Read in the test data
#import subject_test.txt
Sub_Test = read.table('subject_test.txt',header=FALSE)
#Assigin column names to the data Sub_Test
colnames(Sub_Test) = "subject_Id"
#import x_test.txt:  that is the Test set
X.Test = read.table('x_test.txt',header=FALSE) 
# Assigin column names to the data X.Test
colnames(X.Test) = Features[,2]
#import y_test.txt: that is the test labels
Y.Test = read.table('y_test.txt',header=FALSE) 
#Assigin column names to the data Y.Test
colnames(Y.Test) = "activity_Id"
# Create the final test set by merging the Y.Test, Sub_Test,  X.Test data
Class_Test = cbind(Y.Test, Sub_Test,  X.Test)


#import subject_train.txt with is each row identifies
#the subject who performed the activity for each window sample
Sub_Train = read.table('subject_train.txt',header=FALSE)
#Assigin column names to the Sub_Train
colnames(Sub_Train) = "subject_Id"
# import x_train.txt: that is the Training set
X.Train = read.table('x_train.txt',header=FALSE)  
#Assigin column names to the data X.Train
colnames(X.Train) = Features[,2]
#import y_train.txt: that is Training labels
Y.Train = read.table('y_train.txt',header=FALSE)
# Assigin column names to the data Y.Train
colnames(Y.Train) = "activity_Id"
# Create the final training set by merging Y.Train, Sub_Train, and X.Train
Class_training = cbind(Y.Train, Sub_Train, X.Train)
# Combine training and test data to create one data set call: Class_One_Data
Class_One_Data = rbind(Class_training,Class_Test)







# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# To select the desired mean() & stddev() columns we have to Create a  vector call Class, 
#for the column names from the Class_One_Data, which will be used,
# and  Create a  vector call Logic, that contains TRUE values for the ID, mean() & stddev() columns and FALSE otherwise
Class= colnames(Class_One_Data)
Logic= (grepl("activity..",Class) | grepl("subject..",Class) | grepl("-mean..",Class) & !grepl("-meanFreq..",Class) & !grepl("mean..-",Class) | grepl("-std..",Class) & !grepl("-std()..-",Class))
# create the data corresponding for the Logic vector
Class_One_Data = Class_One_Data[Logic==TRUE]




# 3. Uses descriptive activity names to name the activities in the data set
# Merge the Class_One_Data set with the Typeactitivity table to include descriptive activity names
Class_One_Data= merge(Class_One_Data,Typeactivity,by='activity_Id',all.x=TRUE)
# Updating the Class vector to include the new column names after merge
Class = colnames(Class_One_Data)

# 4.Appropriately labels the data set with descriptive variable names.
# We have to Clean up the variable names
for (i in 1:length(Class))
{
Class[i] = gsub("\\()","",Class[i])
Class[i] = gsub("-std$","StdDev",Class[i])
Class[i] = gsub("-mean","Mean",Class[i])
Class[i] = gsub("^(t)","time",Class[i])
Class[i] = gsub("^(f)","freq",Class[i])
Class[i] = gsub("([Gg]ravity)","Gravity",Class[i])
Class[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",Class[i])
Class[i] = gsub("[Gg]yro","Gyro",Class[i])
Class[i] = gsub("AccMag","AccMagnitude",Class[i])
Class[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",Class[i])
Class[i] = gsub("JerkMag","JerkMagnitude",Class[i])
Class[i] = gsub("GyroMag","GyroMagnitude",Class[i])
}
# Reassigning the new descriptive column names to the Class_One_Data set
colnames(Class_One_Data) = Class


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# We have to remove Typeactivity column  to create a new table, Class_remove_Typeactivity
#knowing that in my data table Class_One_Data,Typeactivity is on column is 103 

Class_remove_Typeactivity = Class_One_Data[,-103]

# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
tidy_Data = aggregate(Class_remove_Typeactivity[,names(Class_remove_Typeactivity) != c('activity_Id','subject_Id')],by=list(activity_Id=Class_remove_Typeactivity$activity_Id,subject_Id = Class_remove_Typeactivity$subject_Id),mean)


# Merging the tidyData with Typeactivity to include descriptive acitvity names
tidy_Data = merge(tidy_Data, Typeactivity,by='activity_Id',all.x=TRUE)
# Export the tidyData set
write.table(tidy_Data, 'tidy_Data.txt',row.names=TRUE,sep='\t')


