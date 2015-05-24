# GettingCleaningData_CourseProject
Course project for Coursera Getting and Cleaning data course

The purpose of this project was to create a tidy data set from the Samsung Galaxy S smartphone accelerometers data.

The data is located at the below location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Project Requirments
1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Steps to recreate dataset
1. Unzip data from the above location into your working directory.
2. Ensure that the run_analysisR script is also in your working directory.
3. Run the script by using source("run_analysis.R") command in RStudio.
4. A file name tidy_data.txt will be created in your working directory
5. Use  data <- read.table(filepath, header = TRUE), View(data) to read the data and view back into R
