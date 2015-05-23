Original Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.



The analisis and the creation of the tidy data set

The first action accomplished by the R script provided (run_analysis.R) is reading the training and the test data sets ("X_train" amd "X_test"), the data set containing the measuraments ("features"), the data sets containing the code identifying the subject who performed the activity respectively for the training and the test data ("subject_train" and "subject_test"), the data sets containing the code identifying the activity respectively for the training and the test data ("y_train" and "y_test"), and finally the data sets containing the activity labels ("activity_labels").

Then, the training and test data sets are merged into one called "train_test"
The second column of the "features" data set is converted into a vector, this column contains the type of measuraments recorded in the training and test data set and I converted into a vector because in this way I will rename the colomns of the merged data set according with this vector ("features2").
In fact, it is very easy, having a vector of names, to assign new names (type of measuraments) to the columns of the merged data set.

Since the final aim is having a data set based on subject and activity types, I created two data sets regarding subjects and activities joining the relative training and test data ("subjects", which is "subject_train" + "subject_test", and "activities", which is "y_train" + "y_test").

At this stage I extracted only the  measurements regarding the mean and standard deviation for each measurement in the merged data sets, to which I assigned column names. I used the grepl function and I did it in three steps. First, I created a data set with all the mean measuraments, and then with the standatd deviations finally I joined the two data sets with the function "cbind", creating a new data set called "train_test_msd".

I added to this data set the two columns with subject and activity code, and I named these "subject" and "activity code"
I tranformed in in factor the subject column and finally I created a function to add a new column and substitute the activity code with the activity labels.
I transformed in factor the new column with the activity labels and I deleted the column with the activity code since there is a more explanatory column with the activity names.

I used the package reshape2 to melt and cast data frames

In order to produce the tidy data set I melted the data set to order it by subject and by activity (the new name is "ttf_melt"), then I casted the data to obtain the average of each variable for each activity and each subject (new name "tidy_ds")

"tidy_ds" is the final tidy data set required for the project.
In order to save it and store it as a text (.txt) file I used the function write.table, and I named the file "tidy_dataset.txt".


List of variables included in the tidy data set:
 [1] subject : the subject performing the activity
 [2] activity: the activity type (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
 [3] "tBodyAcc-mean()-X"      
 [4] "tBodyAcc-mean()-Y"    
 [5] "tBodyAcc-mean()-Z"     
 [6] "tGravityAcc-mean()-X"     
 [7] "tGravityAcc-mean()-Y"       
 [8] "tGravityAcc-mean()-Z"     
 [9] "tBodyAccJerk-mean()-X"      
[10] "tBodyAccJerk-mean()-Y"      
[11] "tBodyAccJerk-mean()-Z"      
[12] "tBodyGyro-mean()-X"         
[13] "tBodyGyro-mean()-Y"         
[14] "tBodyGyro-mean()-Z"         
[15] "tBodyGyroJerk-mean()-X"     
[16] "tBodyGyroJerk-mean()-Y"     
[17] "tBodyGyroJerk-mean()-Z"     
[18] "tBodyAccMag-mean()"         
[19] "tGravityAccMag-mean()"      
[20] "tBodyAccJerkMag-mean()"     
[21] "tBodyGyroMag-mean()"        
[22] "tBodyGyroJerkMag-mean()"    
[23] "fBodyAcc-mean()-X"          
[24] "fBodyAcc-mean()-Y"          
[25] "fBodyAcc-mean()-Z"          
[26] "fBodyAccJerk-mean()-X"      
[27] "fBodyAccJerk-mean()-Y"      
[28] "fBodyAccJerk-mean()-Z"      
[29] "fBodyGyro-mean()-X"         
[30] "fBodyGyro-mean()-Y"         
[31] "fBodyGyro-mean()-Z"         
[32] "fBodyAccMag-mean()"         
[33] "fBodyBodyAccJerkMag-mean()" 
[34] "fBodyBodyGyroMag-mean()"    
[35] "fBodyBodyGyroJerkMag-mean()"
[36] "tBodyAcc-std()-X"           
[37] "tBodyAcc-std()-Y"           
[38] "tBodyAcc-std()-Z"           
[39] "tGravityAcc-std()-X"        
[40] "tGravityAcc-std()-Y"        
[41] "tGravityAcc-std()-Z"        
[42] "tBodyAccJerk-std()-X"       
[43] "tBodyAccJerk-std()-Y"       
[44] "tBodyAccJerk-std()-Z"       
[45] "tBodyGyro-std()-X"          
[46] "tBodyGyro-std()-Y"          
[47] "tBodyGyro-std()-Z"          
[48] "tBodyGyroJerk-std()-X"      
[49] "tBodyGyroJerk-std()-Y"      
[50] "tBodyGyroJerk-std()-Z"      
[51] "tBodyAccMag-std()"          
[52] "tGravityAccMag-std()"       
[53] "tBodyAccJerkMag-std()"      
[54] "tBodyGyroMag-std()"         
[55] "tBodyGyroJerkMag-std()"     
[56] "fBodyAcc-std()-X"           
[57] "fBodyAcc-std()-Y"           
[58] "fBodyAcc-std()-Z"           
[59] "fBodyAccJerk-std()-X"       
[60] "fBodyAccJerk-std()-Y"       
[61] "fBodyAccJerk-std()-Z"       
[62] "fBodyGyro-std()-X"          
[63] "fBodyGyro-std()-Y"          
[64] "fBodyGyro-std()-Z"          
[65] "fBodyAccMag-std()"          
[66] "fBodyBodyAccJerkMag-std()"  
[67] "fBodyBodyGyroMag-std()"     
[68] "fBodyBodyGyroJerkMag-std()" 

Explanation of the variables (features) in the tidy data set

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern:   '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
