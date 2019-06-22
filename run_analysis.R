##---------------------------------------------------------Loading Libraries----------------------------------------------------------------------

library(tidyverse)
library(tidyselect)
library(dplyr)

##--------------------------Setting the working directory, creating the dir, downoading the file, unzipping the file------------------------------

setwd("D:/OneDrive/DATA SCIENCE COURSE/GETTING AND CLEANING DATA")
if(!dir.exists("Project Data")) {dir.create("./Project Data")} 
if(!file.exists("Dataset.zip")) {download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        destfile = "./Project Data/Dataset.zip", method = "curl")}
if(!file.exists("./Project Data/Dataset")) {unzip("./Project Data/Dataset.zip", exdir = "Project Data")}


##-----------------------------------------------------Reading the Features Files------------------------------------------------------------------

features <- read.table("./Project Data/UCI HAR Dataset/features.txt", header = FALSE)

##-------------------------------------------------------Read Data for Train-----------------------------------------------------------------------

activity_train <- read_table("./Project Data/UCI HAR Dataset/train/y_train.txt", col_names = "activity", col_types = cols(col_factor(levels=1:6)))
subject_train <- read.delim("./Project Data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "Subject ID")
x_train <- read.table ("./Project Data/UCI HAR Dataset/train/x_train.txt", header = FALSE)


##------------------------------------------------------Renaming the Columns------------------------------------------------------------------------

colnames(x_train) <- features$V2

##------------------------------------------ Combining the files into the Train Data Frame---------------------------------------------------------- 

train <- cbind(subject_train, activity_train, x_train)

##---------------------------------------------------Read Data for Test-----------------------------------------------------------------------------

activity_test <- read_table("./Project Data/UCI HAR Dataset/test/y_test.txt", col_names = "activity", col_types = cols(col_factor(levels=1:6)))
subject_test <- read.delim("./Project Data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "Subject ID")
x_test <-  read.table ("./Project Data/UCI HAR Dataset/test/x_test.txt", header = FALSE)

##-------------------------------------------------Renaming the Columns------------------------------------------------------------------------------

colnames(x_test) <- features$V2

##--------------------------------------Combining the files into the Test Data Frame----------------------------------------------------------------

test <- cbind(subject_test, activity_test, x_test)

##-------------------------------------------Merging the Train and Test DFs--------------------------------------------------------------------------

DF <- bind_rows(train, test)


##----------------------Extracting  the measurements on the mean and standard deviation for each measurement------------------------------------------

DF2 <- DF %>% select(1:3, contains("mean()"), contains("std()"))

##--------------------------Assigning descriptive activity names to name the activities in the data set-----------------------------------------------

activity_labels <- read_delim('./activity_labels.txt', " ", col_names = F) %>% pull(2)
levels(DF2$activity) <- activity_labels

##---------------------------------Creating a New Tidy Data Set with the Averages for each Individual and Activity Type------------------------------
data_means <- DF2 %>% group_by(Subject.ID, activity) %>% summarise_at(-(1:3),mean,na.rm = T)
