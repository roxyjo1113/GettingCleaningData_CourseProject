##Ensure library(dplyr) is loaded
library(dplyr)

##Read in All Test datasets
subjectTest <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
activityXTest <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
activityYTest <- read.table(file = "UCI HAR Dataset/test/y_test.txt")

##Join Test data sets into one dataframe
df_test <- cbind(subjectTest, activityYTest, activityXTest)

##Read in All Train datasets
subjectTrain <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
activityXTrain <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
activityYTrain <- read.table(file = "UCI HAR Dataset/train/y_train.txt")

##Join Train data sets into one dataframe
df_train <- cbind(subjectTrain, activityYTrain, activityXTrain)

##Join Train and Test dataframe into one combined dataframe
combined_df <- rbind(df_test,df_train)

##Read Features text file
Columnhead<-read.table(file = "UCI HAR Dataset/features.txt")

##Set column names using the second column of the features text table.  
##Change the column names to valid names by removing the invalid characters
colnames(combined_df) = c("Subject", "Activity", as.character(Columnhead[,2]))

valid_column_names <- make.names(names=names(combined_df), unique=TRUE, allow_ = TRUE)
names(combined_df) <- valid_column_names

#Change dataframe to dplyr Table dataframe
df<-tbl_df(combined_df)

##Read in the Activity Description text file
activitydesc<-read.table(file = "UCI HAR Dataset/activity_labels.txt")

#Change activity description dataframe to dplyr Table dataframe and set column names
ad_df<-tbl_df(activitydesc)
colnames(ad_df)=c("Activity", "Activity_Desc")

##Join Activity Description with overall data based on the activity number
df_desc<-left_join(df, ad_df, by = c("Activity"))

##Select only the standard deviation columns, mean columns, and two header columns
std_df<-select(df,contains(".std."))
mean_df<-select(df,contains(".mean."))
lead_df<-select(df_desc,one_of(c("Subject","Activity_Desc")))

##Join together header, standard deviation, and mean columns into one semi tidy dataset
semi_tidy<-bind_cols(lead_df,mean_df,std_df)

##Group by Subject and Activity Desc
grp_tidy<-group_by(semi_tidy, Subject,Activity_Desc) 

##Summarise each column by Grouped data
tidy<-summarise_each(grp_tidy, funs(mean))

##Write tidy data to text file
write.table(tidy, "project_tidy.txt", row.name=FALSE)