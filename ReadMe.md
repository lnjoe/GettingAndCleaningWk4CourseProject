---
title: "ReadMe for Getting and Cleaning Data Course Project"
author: "Joe Barter"
date: "March 19, 2019"
output: html_document
---


## Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  There is a single script **run_analysis.R** that is used to process the data.  The prep steps and further information are below.



## Prep Steps
Prior to running the run_analysis.R script do  the following:

 1. Download the data from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.
 2. Extract the data to a local directory and set that directory as your Working Directory in RStudio.
 3. Open and source run_analysis.R in RStudio. 
 

## run_analysis.R
This script does the following:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each group of activity and subject.


## Please note 

 I interpreted Step 2 above as the mean and standard deviation measurements for the initial measurements as described in features_info.txt  and not the derived measurements.  I did leave commented code in to gather the derived mean and standard of deviation information if that is needed later.  
