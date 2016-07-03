## Download the file, unzips and create folders
library(data.table)
library(httr)
library(plyr)
library (dplyr)


url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("DATA")) {
		dir.create("DATA") 
		}
download.file(url,destfile="./DATA/Dataset.zip",mode="wb")
## Data downloaded
## Working directory changed to folder containing Downloaded Data
currentwd <- getwd()
#######newwd <- setwd(".getwd()/DATA")
newwd <- setwd(".\\DATA")

## Unzips the Downloaded Data
##Data_house <- "UCI HAR Dataset"
if(!file.exists("UCI HAR Dataset"
)) {
		unzip("Dataset.zip", list = FALSE, overwrite = TRUE)
		}
##create Results folder if not present and write answer files in csv format
Results <- "Results"
if(!file.exists(Results)){
	dir.create(Results)
}

savingresults <- function (data,name){
	file <- paste(Results, "/", name,".csv" ,sep="")
	write.csv(data,file)
}

##1 Training and Test Data have been merged into one data set and arranged by Subject. Saved to 
##'Answer_Part1_Merged_Data.csv' file in Results folder

ListofVariables_MeasuredforFeatures <- read.table("UCI HAR Dataset/features.txt")
lvaf <- ListofVariables_MeasuredforFeatures
## getting complete list of variables of each feature vector.
 
ListofActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
lal <- ListofActivityLabels
## getting list of various activity for data measurement

subject_Training_data <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity_Training_data <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
features_Training_data <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

subject_Test_data <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity_Test_data <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
features_Test_data <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
## Reading Training and Test Data for subjects,activity and their measurements(i.e features) in table


subject_data <- rbind(subject_Training_data,subject_Test_data)
activity_data <- rbind(activity_Training_data,activity_Test_data)
features_data <- rbind(features_Training_data,features_Test_data)

colnames(subject_data) <- "Subject"
colnames(activity_data) <- "Activity"
colnames(features_data) <- t(lvaf[2])

Merged_Data <- cbind(subject_data,activity_data,features_data)
############Merged_Data <- arrange(Merged_Data,Subject)
savingresults(Merged_Data,"Answer_Part1_Merged_Data")

##2 Extracting mean and std measurements alone for each features. Saved to 'Answer_Part2_Only_Mean&Sdev.csv' file in 
## Results folder.
##mean <- grep("mean",names(Merged_Data))
##std <- grep("std",names(Merged_Data))
##mean_and_std <- Merged_Data[,c(1,2,mean, std)]

columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(Merged_Data), ignore.case=TRUE)
mean_and_std <- Merged_Data[,c(1,2,columnsWithMeanSTD)]
savingresults(mean_and_std,"Answer_Part2_Only_Mean&Sdev")


##3 Used descriptive activity names to name the activities in the data set. Saved to 'Answer_Part3_With_Descriptive_Activity_Names.csv'
## file in Results folder.

ListofActivityLabels <- data.frame()
ListofActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", sep = "",stringsAsFactors=F)
Modi_Data <- mean_and_std
Modi_Data$Activity <- factor(Modi_Data$Activity, levels=ListofActivityLabels$V1, labels=ListofActivityLabels$V2)
savingresults(Modi_Data,"Answer_Part3_With_Descriptive_Activity_Names")


##4 Descriptive Variable name has been used to label the data appropriately. Saved to 'Answer_Part4_With_Descriptive_Variable_Names.csv'
## in Results Folder.
##Modi_Data <- mean_and_std
names(Modi_Data)<-gsub("angle", "Angle", names(Modi_Data))
names(Modi_Data)<-gsub("gravity", "Gravity", names(Modi_Data))
names(Modi_Data)<-gsub("Mag", "_Magnitude", names(Modi_Data))
names(Modi_Data)<-gsub("^t", "In_time_domain_", names(Modi_Data))
names(Modi_Data)<-gsub("Acc", "_Acceleration_", names(Modi_Data))
names(Modi_Data)<-gsub("Gyro", "_Gyroscope_", names(Modi_Data))
names(Modi_Data)<-gsub("Jerk", "_Jerk_", names(Modi_Data))
names(Modi_Data)<-gsub("^f", "In_frequency_domain_", names(Modi_Data))
names(Modi_Data)<-gsub("BodyBody", "Body", names(Modi_Data))
names(Modi_Data)<-gsub("BodyBody", "Body", names(Modi_Data))
names(Modi_Data)<-gsub("-mean", "_Mean", names(Modi_Data), ignore.case = TRUE)
names(Modi_Data)<-gsub("-std", "_Sdev", names(Modi_Data))
names(Modi_Data)<-gsub("Freq", "_Frequency", names(Modi_Data))
names(Modi_Data)<-gsub("Mean", "_Mean", names(Modi_Data), ignore.case = TRUE)
names(Modi_Data)<-gsub("tBody", "Time_Body", names(Modi_Data))

savingresults(Modi_Data,"Answer_Part4_With_Descriptive_Variable_Names")

##5 A separate tidy dataset is created with the average of each variable for each activity and each subject. Saved to
## 'Answer_Part5_independent_tidy_dataset.csv' in Results Folder.

##Modi_Data$Subject <- as.factor(Modi_Data$Subject)
##Modi_Data <- data.table(Modi_Data)

##savingresults(Modi_Data,"Mod_Data_with_mean")


##savingresults(Modi_Data,"Tidy_Data_with_mean")
tidy_dataset <- ddply(Modi_Data, .(Subject, Activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
colnames(tidy_dataset)[-c(1:2)] <- paste(colnames(tidy_dataset)[-c(1:2)], "_mean", sep="")
savingresultstxt(tidy_dataset,"Answer_Part5_independent_tidy_dataset.csv")

savingresultstxt <- function(data,name) {
file <- paste(Results, "/", name,".txt" ,sep="")
write.table(data, file, row.names = FALSE, quote = FALSE)
}

savingresultstxt(tidy_dataset,"Answer_Part5_tidy.txt")


