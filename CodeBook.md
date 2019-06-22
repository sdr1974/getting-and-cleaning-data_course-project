# Human Activity Recognition Using Smartphones Data Set

## Experiment Setup

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed the six activities previously mentioned wearing the smartphone on the waist. The experiments have been video-recorded to facilitate the data labeling. The obtained database has been randomly partitioned into two sets, where 70% of the patterns has been used for training purposes and 30% as test data: the training set is then used to train a multiclass SVM classifier which is described in the following section. A Samsung Galaxy S2 smartphone has been exploited for the experiments, as it contains an accelerometer and a gyroscope for measuring 3-axial linear acceleration and angular velocity respectively at a constant rate of 50Hz, which is sufficient for capturing human body motion


## Source
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws

## Features

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## Variables

- **Subject_ID:** Identifies the subject/individual who performed the experiments. There were 30 individuals, thus this variable has 30 levels
- **Activity:** Identifies the differents activities performed. It has the following levels
  - WALKING
  - WALKING_UPSTAIRS
  - WALKING_DOWNSTAIRS
  - SITTING
  - STANDING
  - LAYING

- **Features** (Each variable was measured in the time and frequency domains, identified by the prefix "t" and "f" respectively). 
  - **X,Y,Z:** Are the axes in which the measurements were made
  - **t:** Refers to time
  - **f:** Refers to frequency
  - **BodyAcc:** Body Acceleration, the acceleration signal from body movements
  - **GravityAcc:** Gravitation acceleration, the acceleration signal from gravity
  - **BodyAccJerk:** Body Jerk Acceleration, signal from the acceleration registered during sudden movements of the body
  - **BodyGyro:** The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
  - **BodyGyroJerk:** The angular velocity vector measured by the gyroscope during sudden movements of the body
  - **BodyAccMag:** Magnitude of the Euclidean norm of a three-dimensional signal for body acceleration
  - **GravityAccMag:** Magnitude of the Euclidean norm of a three-dimensional signal for "Gravity acceleration"
  - **BodyAccJerkMag:** Magnitude of the Euclidean norm of a three-dimensional signal for "Jerk acceleration"
  - **BodyGyroMag:** Magnitude of the Euclidean norm of a three-dimensional signal for "Body Gyro"
  - **BodyGyroJerkMag:** Magnitude of the Euclidean norm of a three-dimensional signal for "BodyGyroJerk"

