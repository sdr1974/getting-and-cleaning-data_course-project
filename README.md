# Getting and Cleaning Data Course Project
This respository was created for the course project "Tidy Data" (Getting &amp; Cleaning Data - Course Project Assignment)

## Content
1. An R script file named run_analysis.R 
2. A Readme.md file explaining how the analysis was perfromed
3. A Codebook showing all the variables and summaries calculated, along with units, and any other relevant information.

## Data Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

This dataset must be aknowledge to: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

# Working through the Script

**Setting the Working Directory:**

```
setwd("D:/OneDrive/DATA SCIENCE COURSE/GETTING AND CLEANING DATA")
```

**Loading libraries:**
```
library(tidyverse)
library(tidyselect)
library(dplyr)
```
**Creating Directory, Downloading File and Unzipping the Files**

```
if(!dir.exists("Project Data")) {dir.create("./Project Data")} 
if(!file.exists("Dataset.zip")) {download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        destfile = "./Project Data/Dataset.zip", method = "curl")}
if(!file.exists("./Project Data/Dataset")) {unzip("./Project Data/Dataset.zip", exdir = "Project Data")}
```

**Using the Features File to Extract the Variable Names**

The *features* TXT file contains the names of the variables (as indicated in the downloaded README.txt file). We will use the features later to rename the columns of our datasets. You can read this information in the Codebook and also in the TXT file named *features.info.txt* 

```
features <- read.table("./Project Data/UCI HAR Dataset/features.txt", header = FALSE)
```

**Reading the Train Files**
These files are under the train directory and provides the following information: 
- train/X_train.txt: Training set (the variables).
- train/y_train.txt: Training labels.
- train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

```
activity_train <- read_table("./Project Data/UCI HAR Dataset/train/y_train.txt", col_names = "activity", col_types =      cols(col_factor(levels=1:6)))
subject_train <- read.delim("./Project Data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "Subject ID")
x_train <- read.table ("./Project Data/UCI HAR Dataset/train/x_train.txt", header = FALSE)
```

**Asigning the Names to Columns**

Now we will used the information provided by *features* to rename the columns

```
colnames(x_train) <- features$V2
```

**Creating the Train DataFrame**

Now that we've read the files containing all the information about the train trial, we can put it together

```
train <- cbind(subject_train, activity_train, x_train)
```

**Reading the Test Files**

This is basically the same procedure used for the *train files*. These files are the test directory and provides the following info:
- test/X_test.txt: Testing set (the variables).
- test/y_test.txt: test labels.
- test/subject_test.txt: Each row identifies the subject who performed the activity for each window sample.

```
activity_test <- read_table("./Project Data/UCI HAR Dataset/test/y_test.txt", col_names = "activity", col_types = cols(col_factor(levels=1:6)))
subject_test <- read.delim("./Project Data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = "Subject ID")
x_test <-  read.table ("./Project Data/UCI HAR Dataset/test/x_test.txt", header = FALSE)
```

**Asigning the Names to Columns**

Now we will used the information provided by *features* to rename the columns

```
colnames(x_test) <- features$V2
```

**Creating the Test DataFrame**

Now that we've read the files containing all the information about the test trial, we can put it together

```
test <- cbind(subject_test, activity_test, x_test)
```

**Merging the Train and Test DataFrames**

I will call the merged data frame as DF (just for simplicity)

```
DF <- bind_rows(train, test)
```

**Extracting only the measurements on the mean and standard deviation for each measurement**

```
DF2 <- DF %>% select(1:3, contains("mean()"), contains("std()"))
```
 **Assigning descriptive activity names to name the activities in the data set**

```
activity_labels <- read_delim('./activity_labels.txt', " ", col_names = F) %>% pull(2)
levels(DF2$activity) <- activity_labels
```

**Creating a Second Tidy Data with Averages**

In this step we need to calculate the average for the variables in the DF2 for each subject and each activity

```
data_means <- DF2 %>% group_by(Subject.ID, activity) %>% summarise_at(-(1:3),mean,na.rm = T)
```
