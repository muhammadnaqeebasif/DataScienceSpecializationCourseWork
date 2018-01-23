#-------------------------------------------------------------------------------
#---------------- Getting and Cleaning Data Course Project----------------------
#
# Brief Explanation:
# This script does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#-------------------------------------------------------------------------------


#------------------------Reading the files--------------------------------------

# 1. Reading the training files


train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_features <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Checking the dimensions of the dataframs read from the datasets
print(dim(train_activity))
print(dim(train_features))
print(dim(train_subject))

# 2. Reading the test files
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_features <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Checking the dimensions of the dataframs read from the datasets
print(dim(test_activity))
print(dim(test_features))
print(dim(test_subject))

#-------------------------------------------------------------------------------

#---------------------------Step 1. Merging the dataset-------------------------

# merge the train and test data sets.
features_data <- rbind(train_features,test_features)
activity_data <- rbind(train_activity,test_activity)
subject_data <- rbind(train_subject,test_subject)
colnames(activity_data) <- c('Activity')
colnames(subject_data) <- c('Subject')

# Checking the overall dimension of the merged data
cat("Is the dimension of merged features data is equal to the sum of individual data?",
    (dim(features_data)[1]==dim(train_features)[1] + dim(test_features)[1]) &&
      dim(features_data)[2]==dim(train_features)[2] , "\n")

cat("Is the dimension of merged activity data is equal to the sum of individual data?",
    (dim(activity_data)[1]==dim(train_activity)[1] + dim(test_activity)[1]) &&
      dim(activity_data)[2]==dim(train_activity)[2], "\n")

cat("Is the dimension of merged subject data is equal tto the sum of individual data?",
    (dim(subject_data)[1]==dim(train_subject)[1] + dim(test_subject)[1]) && 
      dim(subject_data)[2]==dim(train_subject)[2], "\n")

head(features_data)

head(activity_data)

head(subject_data)

#-------------------------------------------------------------------------------

#----------------------------Step2. Extraction----------------------------------

# Reading the feature description file
features_names <- read.table('./UCI HAR Dataset/features.txt')
head(features_names,n=10)

# Extracting the features from the feature names which contain 'mean' or 'std' in the name
extract_feat_names <- subset(features_names,grepl("mean|std",features_names[,2]))
dim(extract_feat_names)

# using the features extracted previously subsets the feature data so that it contains the 
# features which only contain 'std' or mean in the name
extract_features_data <- features_data[,extract_feat_names[,1]]

# checking the dimension of the extracted data
dim(extract_features_data)

#renaming the column names
colnames(extract_features_data) <- extract_feat_names[,2]
head(extract_features_data)

#-------------------------------------------------------------------------------

#-------------------------- Step3. Activity Naming------------------------------

# Reading the activity description file
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")

# naming the activities in activity_data using factor function
activity_data$Activity<-factor(activity_data$Activity,levels = 1:6 , 
                               labels = activity_names[,2])
head(activity_data)

#-------------------------------------------------------------------------------

#------------------------- Step4. Labeling -------------------------------------

# extract column names
col_names <- colnames(extract_features_data)

# removing '()' from the col_names
col_names<- gsub('\\()',"",col_names)

#replaing mean with Mean
col_names<- gsub('-mean',"Mean",col_names)

#replacing std with StandardDeviation
col_names<- gsub('-std',"StandardDeviation",col_names)

#capitalizing x,y,z,axis
col_names<- gsub('[Bb]ody[Bb]ody',"Body",col_names)

#replacing Acc with Acceleration
col_names <- gsub('[Aa]cc','Acceleration',col_names)

#replacing Mag with Magnitude
col_names <- gsub('[Mm]ag','Magnitude',col_names)

# replacing prefix t and f with TimeDomain and FrequencyDomain respectively
col_names <- gsub('^t','TimeDomain',col_names)
col_names <- gsub('^f','FrequencyDomain',col_names)

#replacing Gyro with Gyroscope
col_names <- gsub('[Gg]yro','Gyroscope',col_names)

# setting the colunmn names of the featured data to the modified names
colnames(extract_features_data) <- col_names
head(extract_features_data)

#------------------------------------------------------------------------------

#------------------------------Step5. Independant data set---------------------

#Merging all the data and creating data.tables of overall table

library(data.table)
#merging all the data into a single data frame
overall_data <- cbind(subject_data,activity_data,extract_features_data)

#creating the data table from dataframe
overall_data <- data.table(overall_data)
head(overall_data)

# Average of each variable group by activity and subject
library(dplyr)
tidy_data <- overall_data %>% group_by(Subject,Activity) %>% 
  summarise_all(funs(mean))

head(tidy_data,n=10)

#writing tidy_dat to the tidy_data.csv
write.table(tidy_data,"./tidy_data.csv",sep=",",row.names = FALSE)

#-------------------------------------------------------------------------------

dim(tidy_data)
