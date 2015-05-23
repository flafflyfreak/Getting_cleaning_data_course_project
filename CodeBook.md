The first action accomplished by R script provided (run_analysis.R) is reading the training and the test data sets ("X_train" amd "X_test"), the data set containing the measuraments ("features"), the data sets containing the code identifying the subject who performed the activity respectively for the training and the test data ("subject_train" and "subject_test"), the data sets containing the code identifying the activity respectively for the training and the test data ("y_train" and "y_test"), and finally the data sets containing the activity labels ("activity_labels").

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


