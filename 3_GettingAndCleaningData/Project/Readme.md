#  Getting and Cleaning Data Course Project
In the project the dataset taken from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is cleaned. This folder contains the following files:

* ```Readme.md``` gives the brief explanation of the project and steps to create the tidy dataset.
* ```CodeBook.md``` describes different fields of the dataset
* ```tidy_data.csv``` contains the tidy data in csv format
* ```run_analysis.R``` contains the r-script to get the cleaned data from the original dataset.
* ```run_analysis.ipynb``` is the jupyter kernel which does the same thing as r-script but is easier to read.

## Brief explanation
Following are the steps which briefly explain the work done in the project
1. ```Merging.``` The train and test parts of the datasets are merged together.
2. ```Extraction.``` The measurements on the mean and standard deviation for each measurement are extracted.
3. ```Activity Naming.``` The descriptive activity names are used to name the activities in the data set.
4. ```Labeling the dataset``` The dataset is labled with descriptive variable names.
5. ```Independent Dateset```  The independent tidy data set is created from the dataset in step 4. The resultant dataset contains the average of each variable for each activity and each subject. The resultant dataset is written to [tidy_data.csv]()