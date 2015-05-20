# reading the training and the test data sets
X_train <- read.table("C:/Users/flo/Dropbox/Documents/Aberystwyth PhD/coursera_HPCWales/getting and cleaning data/UCI HAR Dataset/train/X_train.txt", quote="\"")
X_test <- read.table("C:/Users/flo/Dropbox/Documents/Aberystwyth PhD/coursera_HPCWales/getting and cleaning data/UCI HAR Dataset/test/X_test.txt", quote="\"")

# reading the data set containing the measuraments
features <- read.table("C:/Users/flo/Dropbox/Documents/Aberystwyth PhD/coursera_HPCWales/getting and cleaning data/UCI HAR Dataset/features.txt", quote="\"")

# reading the data sets containing the code identifying the subject who performed the activity respectively for the training and the test data
subject_train <- read.table("C:/Users/flo/Dropbox/Documents/Aberystwyth PhD/coursera_HPCWales/getting and cleaning data/UCI HAR Dataset/train/subject_train.txt", quote="\"")
subject_test <- read.table("C:/Users/flo/Dropbox/Documents/Aberystwyth PhD/coursera_HPCWales/getting and cleaning data/UCI HAR Dataset/test/subject_test.txt", quote="\"")

# reading the data sets containing the code identifying the activity respectively for the training and the test data
y_train <- read.table("C:/Users/flo/Dropbox/Documents/Aberystwyth PhD/coursera_HPCWales/getting and cleaning data/UCI HAR Dataset/train/y_train.txt", quote="\"")
y_test <- read.table("C:/Users/flo/Dropbox/Documents/Aberystwyth PhD/coursera_HPCWales/getting and cleaning data/UCI HAR Dataset/test/y_test.txt", quote="\"")

# reading the data sets containing the activity labels
activity_labels <- read.table("C:/Users/flo/Dropbox/Documents/Aberystwyth PhD/coursera_HPCWales/getting and cleaning data/UCI HAR Dataset/activity_labels.txt", quote="\"")

# merging the training and test data sets in to one 
train_test <- merge(X_train, X_test, all=T)

# converting the second column of the "features" data set into a vector
        ## this data set contains the type of measuraments recorded in the training and test data set
        ## I converted into a vector so I will rename the colomns of the merged data set
features2<-as.vector(features[1:561,2])

# assigning new names (type of measuraments) to the merged data set
colnames(train_test)<-features2

# creating the data sets regarding subjects and activities joining the relative training and test data 
subjects<-rbind(subject_train, subject_test)
activities<- rbind(y_train, y_test)

# extracting only the  measurements on the mean and standard deviation for each measurement
        ## I used the grepl function and I did it in two steps (first I created a data set with the mean and then with the standatd deviations)
        ## finally I joined the two data sets with the function "cbind"
train_test_m<- train_test[,grepl("(.*)mean\\(\\)(.*)", colnames(train_test))]
train_test_sd<- train_test[,grepl("std", colnames(train_test))]
train_test_msd <- cbind(train_test_m, train_test_sd)

# adding the two columns with subject and activity code to the data set including only mean and standard deviation
train_test_final<-cbind(train_test_msd, subjects, activities)

# naming the two columns added: "subject" and "activity code"
colnames(train_test_final)[67:68]<- c("subject", "activity_code")

# transforming in factor the subject column
train_test_final[,67]<-as.factor(train_test_final[,67])

# creating a function to add a new column and substitute the activity code with the activity labels
convert <- function(number){
        if(number == 1 ){return("walking")}
        if(number == 2){return("walking upstairs")}
        if(number == 3){return("walking downstairs")}
        if(number == 4){return("sitting")}
        if(number == 5){return("standing")}
        if(number == 6){return("laying")}
}

train_test_final$activity <- do.call(rbind, lapply(train_test_final$activity_code, convert))

# transforming in factor the activity column
train_test_final[,69]<-as.factor(train_test_final[,69])

# deleting the column with the activity code since there is a more explanatory column with the activity names
train_test_final[,68]<- NULL

# loading the package reshape2 to melt and cast data frames
library(reshape2)

# melting the data set in order order it by subject and by activity
ttf_melt<- melt(train_test_final, id=c("subject", "activity"))

# casting the data to obtain the average of each variable for each activity and each subject
tidy_ds<- dcast(ttf_melt, subject + activity ~ variable, mean)

# writing the tidy data set in a .csv format in order to save it and store it
write.csv(tidy_ds, "tidy_dataset.csv")

