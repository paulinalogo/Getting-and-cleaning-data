#Set working directory
setwd("C:\\Users\\J14168\\Documents\\Pau\\Data science coursera\\Getting and cleaning data")

#Create directory for new data
if(!file.exists(".\\Course Project")){dir.create(".\\Course Project")}

#Download files
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile=".\\Course Project\\data.zip")
closeAllConnections()

#Set working directory to the directory where unzipped files are located
setwd("C:\\Users\\J14168\\Documents\\Pau\\Data science coursera\\Getting and cleaning data\\Course Project")
#Read training data set
subject_train <- read.table(".\\data\\UCI HAR Dataset\\train\\subject_train.txt", header=F,sep="")
x_train <- read.table(".\\data\\UCI HAR Dataset\\train\\X_train.txt", header=F,sep="")
y_train <- read.table(".\\data\\UCI HAR Dataset\\train\\Y_train.txt", header=F,sep="")

#Read test data set
subject_test <- read.table(".\\data\\UCI HAR Dataset\\test\\subject_test.txt", header=F,sep="")
x_test <- read.table(".\\data\\UCI HAR Dataset\\test\\X_test.txt", header=F,sep="")
y_test <- read.table(".\\data\\UCI HAR Dataset\\test\\Y_test.txt", header=F,sep="")

#Read features data set
features <- read.table(".\\data\\UCI HAR Dataset\\features.txt", header=F,sep="")
features_vec <- features[,2]

#Assign features names to test and train data sets (STEP 4 OF THE ASSIGNMENT)
names(x_test) <- features_vec
names(x_train) <- features_vec

#Assign name to subject and label datasets (STEP 4 OF THE ASSIGNMENT)
names(subject_test) <- "subject"
names(y_test) <- "activity"
names(subject_train) <- "subject"
names(y_train) <- "activity"

#Read activity labels data set
act_label <- read.table(".\\data\\UCI HAR Dataset\\activity_labels.txt", header=F,sep="")


#Bind x_test,x_test,subject_test and x_train,y_train,subject_train respectively 
#This step allows to have measurments, labels and subjects in the same data set for the test and train group, respectively.
#In turn, this step is needed before merging train and test datasets

test_data <- cbind(subject_test,y_test,x_test)
train_data <- cbind(subject_train,y_train,x_train)


#1: Merge train and test data sets
test_train <- rbind(test_data,train_data)
dim(test_train)

#2: Extract only the measurements on the mean and standard deviation for each measurement. 
test_train_sub <- test_train[,grep('subject|activity|mean()|std()',names(test_train))]

#Remove mean frequency variables
freq <- grep('meanFreq()',names(test_train_sub))
test_train_final <- test_train_sub[,-freq]

#3: Use descriptive activity names to name the activities in the data set 

test_train_final$activity <- factor(test_train_final$activity,
levels = act_label[,1],
labels = act_label[,2] )

#4: Appropriately label the data set with descriptive variable names. 
# This was done previously,when assigning the features vector as the names for the x_test and x_train data sets,
# as well as assingning "subject" and "activity" to the subject and y data sets, respectively.

#5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
test_train_melt <- melt(test_train_final,id=c("subject","activity"))
test_train_tidy <- dcast(test_train_melt, subject + activity ~ variable,mean)
write.table(test_train_tidy, file="test_train_tidy.txt", row.names=FALSE)
