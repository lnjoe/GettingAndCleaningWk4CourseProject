---
title: "CodeBook for Getting and Cleaning Data Course Project"
author: "Joe Barter"
date: "March 19, 2019"
output: html_document
---


## Input Data

The input data is described in the .txt files in the **UCI HAR Dataset** directory.  The **README.txt** file gives a good breakdown of the input data.  The input dataset contains both training and test data.   Once combined, the datasets contain 7,352 records of 1,715 columns.  


## Processing of the Data

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
    * The file **activity_labels.txt** contained the mapping used. 
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each group of activity and subject.


### Please note 

 I interpreted Step 2 above as the mean and standard deviation measurements for the initial measurements as described in features_info.txt  and not the derived measurements.  I did leave commented code in to gather the derived mean and standard of deviation information if that is needed later.  



## Output Data

After processing, the tidy output file **tidyOutput.txt** is generated.  It contains 180 records with one header row.  There are 20 columns associated with each row of data.  


### tidyOutput.txt
The following describes the contents of the output file. 

#### Variables
    
    * Subject - An integer that indicates the subject in the study
    ** Range is 1 to 30
    * Activity - A string indicating the type of activity the subject was participating in.
    ** WALKING
    ** WALKING_UPSTAIRS
    ** WALKING_DOWNSTAIRS
    ** SITTING
    ** STANDING
    ** LAYING

#### Summaries Calculated
The mean is calculated for each subject and activity group for the following. 

    *tBodyAcc_mean_X
    *tBodyAcc_mean_Y
    *tBodyAcc_mean_Z
    *tBodyAcc_std_X
    *tBodyAcc_std_Y
    *tBodyAcc_std_Z
    *tGravityAcc_mean_X
    *tGravityAcc_mean_Y
    *tGravityAcc_mean_Z
    *tGravityAcc_std_X
    *tGravityAcc_std_Y
    *tGravityAcc_std_Z
    *tBodyGyro_mean_X
    *tBodyGyro_mean_Y
    *tBodyGyro_mean_Z
    *tBodyGyro_std_X
    *tBodyGyro_std_Y
    *tBodyGyro_std_Z





