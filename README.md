# Getting-and-cleaning-data - Course Project

==============================================

 run_analysis.R script 
 
=============================================

Paulina Lopez Gonzalez

Getting and cleaning data

Johns Hopkins Coursera MOOC

Course project

08/18/2015

============================================

The run_analysis.R script processes smartlab's Human Activity Recognition Using Smartphones Dataset according to the Course project established requirements.

1. First of all, the script downloads the data into a local directory.
2. After unzipping the data, the directory with said data is provided.
3. The script reads the x_test, x_train, y_test, y_train, subject_test, subject_train, features and activity label data sets.
4. Next, the features vector is assigned as names for the x_test and x_train datasets to give said data descriptive variable names (step 4 in the Course project requirements)
5. "subject" and "activity" are assigned as names for the variables in subject_test/subject_train and y_test/y_train data sets, respectively.
6. subject, y and x data sets are bound using rbind both for the test and train datasets.
