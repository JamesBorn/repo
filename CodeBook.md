
# CodeBook for this project
   >*Johns Hopkins's Getting and Cleaning Data cours*
   >*Repo for the submission of the course project*
   >*pierre attey*
*==================================================================*

# Data
    *The source of Data use in this project come from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip* 

# Data Set Information

* 1-The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.


*  2- The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details


*  3- Record of Attribute Information
Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope. 
A 561-feature vector with time and frequency domain variables. 
Its activity label. 
An identifier of the subject who carried out the experiment


*1- First step*
**Merges the training and the test sets to create one data set
I use tables located in the source directory for the files like  and assign them new names in my work**

* **features.txt: List of all features; name assign 'Features'**

* **activity_labels.txt; Links the class labels with their activity name: name assign typeactivity**

* **X_train.txt: Training set; name assign X.train**

* **y_train.txt: Training labels; name assign Y.train**

* **X_test.txt: Test set; name assign X.test**

* **y_test.txt: Test labels; name assign Y.test**

* **subject_train.txt: name assign Sub_test**

* **subject_test.txt name assign Sub_test**

* **Class_One_Data is the one table of data Combine training and test data created**




*2- Second step*
**Extracts only the measurements on the mean and standard deviation foreach measurement**

* To select the desired mean() & stddev() columns we have to Create a vector call Class,for the column names from the Class_One_Data, which will be used, and  Create a vector call Logic, that contains TRUE values for the ID, mean() & stddev() columns and FALSE otherwise*

*3- Third step*
**Uses descriptive activity names to name the activities in the data set Merge the Class_One_Data set with the Typeactitivity table to include descriptive activity names**
 
*4- Fourth step*
**Appropriately labels the data set with descriptive variable names
Reassigning the new descriptive column names to the Class_One_Data set
by Using gsub function for pattern replacement to clean up the data labels**


*5- Fifth step*
**From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
table tidy_data.txt of tidy data created: data set with the average of each veriable for each activity and subject**

