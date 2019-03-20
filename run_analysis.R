# run_analysis.R "Getting and Cleaning Data" week 4 assignment

# 1. Merges the training and the test sets to create one data set.
    # define the paths
    # this script assumes your working directory is the unzippped data directory "UCI HAR Dataset"  (i.e. c:\DataCleaning\wk4\data\UCI HAR Dataset)
    inputBaseDir <-  "./"
    inputTestDir <-  paste0(inputBaseDir, "test/")
    inputTrainDir <-  paste0(inputBaseDir, "train/")
    inputTestSignalsDir <-  paste0(inputTestDir, "Inertial Signals/")
    inputTrainSignalsDir <-  paste0(inputTrainDir, "Inertial Signals/")

    # pull in the libraries needed
    library(dplyr)

    #
    #load the data into a data frame
    #

    # Note: relying on the files names order being consistent across directories.
    
    # Get the training set
    topDirTrain <- list.files(inputTrainDir, pattern = "*.txt$",  full.names = TRUE) 
    subDirTrain <- list.files(inputTrainSignalsDir, pattern = "*.txt$",  full.names = TRUE) 
    allTrainFiles <-  c(topDirTrain, subDirTrain)
    allTrainDataRaw <- lapply(allTrainFiles, read.table)
    combinedTrainDf <- data.frame (allTrainDataRaw[1], allTrainDataRaw[3], allTrainDataRaw[2], # Top Dir
                                     allTrainDataRaw[4], allTrainDataRaw[5], allTrainDataRaw[6], # body_acc
                                     allTrainDataRaw[7], allTrainDataRaw[8], allTrainDataRaw[9], # body_gyro
                                     allTrainDataRaw[10], allTrainDataRaw[11], allTrainDataRaw[12] #total_acc
                                     )
    
    #get the test set
    topDirTest <- list.files(inputTestDir, pattern = "*.txt$",  full.names = TRUE) 
    subDirTest <- list.files(inputTestSignalsDir, pattern = "*.txt$",  full.names = TRUE) 
    allTestFiles <-  c(topDirTest, subDirTest)
    allTestDataRaw <- lapply(allTestFiles, read.table)
    combinedTestDf <- data.frame (allTestDataRaw[1], allTestDataRaw[3], allTestDataRaw[2], # Top dir
                                     allTestDataRaw[4], allTestDataRaw[5], allTestDataRaw[6], # body_acc
                                     allTestDataRaw[7], allTestDataRaw[8], allTestDataRaw[9], # body_gyro
                                     allTestDataRaw[10], allTestDataRaw[11], allTestDataRaw[12] # total_acc
    )
    
    # combine all data into single data frame
    allRawDataDf <-  rbind(combinedTrainDf, combinedTestDf)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    
    
    # identify the mean and standard deviations columns for the base measurements
    meanStdCols <-  c(1:2, 3:8, 43:48, 123:128) # subject, action, tBodyAcc, tGravityAcc, , tBodyGyro
    # other fields that have mean and standard of deviation information 
    #, 83:88 # tBodyAccJerk
    # all the rest
    #,  163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 
    #                  268:273, 296:298, 347:352, 375:377, 426:431, 454:456, 505:506, 515, 518:519, 528, 531:523541, 544:545, 554 )
    
    # use only the relevant information from the base measurements
    MeanAndStdInfo <- select(allRawDataDf, meanStdCols)
    
# 3. Uses descriptive activity names to name the activities in the data set
    MeanAndStdInfoDescriptive <- mutate(MeanAndStdInfo, V1.1 = plyr::mapvalues(V1.1, from = c(1:6),  to = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")))
    
# 4. Appropriately labels the data set with descriptive variable names.
    MeanAndStdInfoDescriptiveLabeled <- rename(MeanAndStdInfoDescriptive, Subject=V1, Activity=V1.1, "tBodyAcc_mean_X"=V1.2, "tBodyAcc_mean_Y"=V2,
                                               "tBodyAcc_mean_Z"=V3, "tBodyAcc_std_X"=V4, "tBodyAcc_std_Y"=V5, "tBodyAcc_std_Z"=V6, 
                                               "tGravityAcc_mean_X"=V41, "tGravityAcc_mean_Y"=V42, "tGravityAcc_mean_Z"=V43, 
                                               "tGravityAcc_std_X"=V44, "tGravityAcc_std_Y"=V45, "tGravityAcc_std_Z"=V46, 
                                               "tBodyGyro_mean_X"=V121, "tBodyGyro_mean_Y"=V122, "tBodyGyro_mean_Z"=V123, 
                                               "tBodyGyro_std_X"=V124, "tBodyGyro_std_Y"=V125, "tBodyGyro_std_Z"=V126
                                                )

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    ActivitySubjectAverageTidy <- MeanAndStdInfoDescriptiveLabeled %>% 
                                    group_by(Subject, Activity) %>%
                                    summarize(tBodyAcc_mean_X=mean(tBodyAcc_mean_X), tBodyAcc_mean_Y=mean(tBodyAcc_mean_Y), 
                                                tBodyAcc_mean_Z=mean(tBodyAcc_mean_Z), tBodyAcc_std_X=mean(tBodyAcc_std_X), 
                                                tBodyAcc_std_Y=mean(tBodyAcc_std_Y), tBodyAcc_std_Z=mean(tBodyAcc_std_Z), 
                                                tGravityAcc_mean_X=mean(tGravityAcc_mean_X), tGravityAcc_mean_Y=mean(tGravityAcc_mean_Y), 
                                                tGravityAcc_mean_Z=mean(tGravityAcc_mean_Z), tGravityAcc_std_X=mean(tGravityAcc_std_X), 
                                                tGravityAcc_std_Y=mean(tGravityAcc_std_Y), tGravityAcc_std_Z=mean(tGravityAcc_std_Z), 
                                                tBodyGyro_mean_X=mean(tBodyGyro_mean_X), tBodyGyro_mean_Y=mean(tBodyGyro_mean_Y), 
                                                tBodyGyro_mean_Z=mean(tBodyGyro_mean_Z), tBodyGyro_std_X=mean(tBodyGyro_std_X), 
                                                tBodyGyro_std_Y=mean(tBodyGyro_std_Y), tBodyGyro_std_Z=mean(tBodyGyro_std_Z)
                                                )
    
    
    write.table(ActivitySubjectAverageTidy, file = "tidyOutput.txt", row.names = FALSE, quote = FALSE)