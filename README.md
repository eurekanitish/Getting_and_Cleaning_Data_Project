# Getting_and_Cleaning_Data_Project
###Getting and Cleaning Data Course Project###
 
The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 
 
Following files are submitted :-
1) a tidy data set as required in assignment, 
2) a link to a Github repository with our script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that we have
performed to clean up the data called CodeBook.md.I have also included a README.md in the repo with 
my scripts. This repo explains how all of the scripts work and how they are connected.

###PROBLEM STATEMENT###
One of the most exciting areas in all of data science right now is wearable computing - see for 
example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most 
advanced algorithms to attract new users. The data linked to from the course website represent data 
collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is 
available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Questions:-
You should create one R script called run_analysis.R that does the following.
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each 
variable for each activity and each subject.

###Problem_Approach###
There is a single R script called run_analysis.R which does following jobs:- 
1. Download Dataset.zip from prescribed url
2. Create a new folder DATA in the working directory where this Dataset.zip is stored.
3. Changes working directory to the just created  DATA folder where data to be analysed is present 
in zip format.
4. Unzip the Dataset.zip and places 'UCI HAR Dataset' in the DATA folder.
5. Creates a Result subdirectory in the DATA folder where all the results shall be written in csv 
format while the code runs.
5. Read the train and test data and merge them via rbind and cbind and stored in Result folder as 
'Answer_Part1_Merged_Data.csv'.
6. With help of text matching ability of grep function, variables containing mean and standard deviation
 are segregated to 
create a subset of initial data and stored in Result folder as 'Answer_Part2_Only_Mean&Sdev.csv'.
7. Descriptive names of Activity has been used to replace earlier used levels with help of factor function
 and modified subset data 
is stored in the Result folder as 'Answer_Part3_With_Descriptive_Activity_Names.csv'.
8. Then Descriptive name has been appropriately assigned to various variables replacing abbreviations 
with full meaningful names. Modified data
set thus created is stored in the Result folder as 'Answer_Part4_With_Descriptive_Variable_Names.csv'.
9. Finally an independent tidy set has been created for average of each activity for each person with the 
help of ddplyr function coming under
plyr package.This is stored in 'Answer_Part5_independent_tidy_dataset.csv' of the Result folder. 
'Answer_Part5_tidy.txt' file is also created with help of write.table function.
10.Additionaly, this repo contains run_analysis.R (script file), tidy data set, code book explaining briefly 
about code and the Result folder containing all files which we shall get once we run this script .

