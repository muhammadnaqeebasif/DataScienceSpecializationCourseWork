# Code Book for coursera project
This codebook contains the information of the data stored in tidy_data.csv of this project. The structure of the data is explained in the data and variable section. 

## Data
The data is stored in data.csv containing coma separated values. The first row contains the name of the variables and rest of the rows are the observation i.e. there are 180 observations. 

## Variables
There are a total of 81 variables in which first 2 variables are identifier and the rest of them are the average measurements.

### Identifier
* ```Subject``` <br>
Subject has values ranging from 1 to 30 which is identifies the subject in study and total number of subjects are 30 in the dataset.
* ```Activity``` <br>
Activity has 6 values which identifies the activity subject was doing while measurement was taken. Following are the 6 values of this variable: <br>
  - ```WALKING```: The subject was walking while the measurement was taken.
  - ```WALKING_UPSTAIRS```: The subject was walking upstairs while the measurement was taken.
  - ```WALKING_DOWNSTAIRS```: The subject was walking downstairs while the measurement was taken.
  - ```SITTING```: The subject was sitting while the measurement was taken.
  - ```STANDING```: The subject was standing while the measurement was taken.
  - ```LAYING```: The subject was lying while the measurement was taken.
  
### Average measurements
These variables contain the average of measurements which are grouped by subject identity and activity. Following are all the measurements taken in data:
* TimeDomainBodyAccelerationMean-X
* TimeDomainBodyAccelerationMean-Y
* TimeDomainBodyAccelerationMean-Z
* TimeDomainBodyAccelerationStandardDeviation-X
* TimeDomainBodyAccelerationStandardDeviation-Y
* TimeDomainBodyAccelerationStandardDeviation-Z
* TimeDomainGravityAccelerationMean-X
* TimeDomainGravityAccelerationMean-Y
* TimeDomainGravityAccelerationMean-Z
* TimeDomainGravityAccelerationStandardDeviation-X
* TimeDomainGravityAccelerationStandardDeviation-Y
* TimeDomainGravityAccelerationStandardDeviation-Z
* TimeDomainBodyAccelerationJerkMean-X
* TimeDomainBodyAccelerationJerkMean-Y
* TimeDomainBodyAccelerationJerkMean-Z
* TimeDomainBodyAccelerationJerkStandardDeviation-X
* TimeDomainBodyAccelerationJerkStandardDeviation-Y
* TimeDomainBodyAccelerationJerkStandardDeviation-Z
* TimeDomainBodyGyroscopeMean-X
* TimeDomainBodyGyroscopeMean-Y
* TimeDomainBodyGyroscopeMean-Z
* TimeDomainBodyGyroscopeStandardDeviation-X
* TimeDomainBodyGyroscopeStandardDeviation-Y
* TimeDomainBodyGyroscopeStandardDeviation-Z
* TimeDomainBodyGyroscopeJerkMean-X
* TimeDomainBodyGyroscopeJerkMean-Y
* TimeDomainBodyGyroscopeJerkMean-Z
* TimeDomainBodyGyroscopeJerkStandardDeviation-X
* TimeDomainBodyGyroscopeJerkStandardDeviation-Y
* TimeDomainBodyGyroscopeJerkStandardDeviation-Z
* TimeDomainBodyAccelerationMagnitudeMean
* TimeDomainBodyAccelerationMagnitudeStandardDeviation
* TimeDomainGravityAccelerationMagnitudeMean
* TimeDomainGravityAccelerationMagnitudeStandardDeviation
* TimeDomainBodyAccelerationJerkMagnitudeMean
* TimeDomainBodyAccelerationJerkMagnitudeStandardDeviation
* TimeDomainBodyGyroscopeMagnitudeMean
* TimeDomainBodyGyroscopeMagnitudeStandardDeviation
* TimeDomainBodyGyroscopeJerkMagnitudeMean
* TimeDomainBodyGyroscopeJerkMagnitudeStandardDeviation
* FrequencyDomainBodyAccelerationMean-X
* FrequencyDomainBodyAccelerationMean-Y
* FrequencyDomainBodyAccelerationMean-Z
* FrequencyDomainBodyAccelerationStandardDeviation-X
* FrequencyDomainBodyAccelerationStandardDeviation-Y
* FrequencyDomainBodyAccelerationStandardDeviation-Z
* FrequencyDomainBodyAccelerationMeanFreq-X
* FrequencyDomainBodyAccelerationMeanFreq-Y
* FrequencyDomainBodyAccelerationMeanFreq-Z
* FrequencyDomainBodyAccelerationJerkMean-X
* FrequencyDomainBodyAccelerationJerkMean-Y
* FrequencyDomainBodyAccelerationJerkMean-Z
* FrequencyDomainBodyAccelerationJerkStandardDeviation-X
* FrequencyDomainBodyAccelerationJerkStandardDeviation-Y
* FrequencyDomainBodyAccelerationJerkStandardDeviation-Z
* FrequencyDomainBodyAccelerationJerkMeanFreq-X
* FrequencyDomainBodyAccelerationJerkMeanFreq-Y
* FrequencyDomainBodyAccelerationJerkMeanFreq-Z
* FrequencyDomainBodyGyroscopeMean-X
* FrequencyDomainBodyGyroscopeMean-Y
* FrequencyDomainBodyGyroscopeMean-Z
* FrequencyDomainBodyGyroscopeStandardDeviation-X
* FrequencyDomainBodyGyroscopeStandardDeviation-Y
* FrequencyDomainBodyGyroscopeStandardDeviation-Z
* FrequencyDomainBodyGyroscopeMeanFreq-X
* FrequencyDomainBodyGyroscopeMeanFreq-Y
* FrequencyDomainBodyGyroscopeMeanFreq-Z
* FrequencyDomainBodyAccelerationMagnitudeMean
* FrequencyDomainBodyAccelerationMagnitudeStandardDeviation
* FrequencyDomainBodyAccelerationMagnitudeMeanFreq
* FrequencyDomainBodyAccelerationJerkMagnitudeMean
* FrequencyDomainBodyAccelerationJerkMagnitudeStandardDeviation
* FrequencyDomainBodyAccelerationJerkMagnitudeMeanFreq
* FrequencyDomainBodyGyroscopeMagnitudeMean
* FrequencyDomainBodyGyroscopeMagnitudeStandardDeviation
* FrequencyDomainBodyGyroscopeMagnitudeMeanFreq
* FrequencyDomainBodyGyroscopeJerkMagnitudeMean
* FrequencyDomainBodyGyroscopeJerkMagnitudeStandardDeviation
* FrequencyDomainBodyGyroscopeJerkMagnitudeMeanFreq

## Transformations
The source data is taken from the http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .
Following transformations were applied to the dataset:
1. The training and test data were merged together.
2. The measurements on the mean and standard deviation for each measurement were extracted.
3. The activities in the data set wered named appropriately according to the names provided in the 'activity_labels.txt'.
4. Following adjustments were made in the names of the variables:
    - ```()``` was removed
    - ```-mean``` was replaced with 'Mean'.
    - ```-std``` was replaced with 'StandardDeviation'.
    - ```BodyBody``` was replaced with 'Body'.
    - ```Acc``` was replaced with 'Acceleration'.
    - ```Mag``` was replaced with 'Magnitude'.
    - ```Gyro``` was replaced with 'Gyroscope'.
    - ```prefix t``` was replaced with 'TimeDomain' e.g. tBodyAccelerationMean-X was transformed into TimeDomainBodyAccelerationMean-X
    - ```prefix f``` was replaced with 'FrequencyDomain' e.g. fBodyGyroscopeMagnitudeMean was transformed into FrequencyDomainBodyGyroscopeMagnitudeMean
    
5. Independent tidy data set with the average of each variable for each activity and each subject was created and written to 'tidy_data.csv' with comma used as the delimeter.