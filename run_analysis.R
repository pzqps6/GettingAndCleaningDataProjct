#-------------------------------------------------------------
# run_analysis.R - COURSERA JOHN HOPKINS 
# Getting and cleaning data - Project
#-------------------------------------------------------------

rm( list=ls())
setwd("D:/Big Data/Coursera/Data Science - John Hopkins/3 Getting and Cleaning Data/Project")

################################################################################
#    1.    Merges the training and the test sets to create one data set.
################################################################################

dat_act_lbl = read.table("activity_labels.txt", sep="")
dat_features =  read.table("features.txt", sep="")

#   fetch the TEST data and providing valid column names
dat_test_subj_test = read.table("test/subject_test.txt", sep="")
colnames (dat_test_subj_test)  = c("subject_id") #an ID for every subject/person
dat_test_X_test = read.table("test/X_test.txt", sep="")
colnames (dat_test_X_test) = c( as.character(dat_features[,2]) ) #   Part of answer 4
dat_test_Y_test = read.table("test/Y_test.txt", sep="")
colnames (dat_test_Y_test) = c( "activity_id" )                  #   Part of answer 4

#   merging the fetched TEST data and free the unused datbytes
dat_test = dat_test_subj_test
dat_test[ , 2] = dat_test_Y_test
dat_test[ , 3:(3+561)] = dat_test_X_test
rm ( dat_test_subj_test, dat_test_Y_test, dat_test_X_test)


#   fetch the TRAINING data and providing valid column names
dat_train_subj_train = read.table("train/subject_train.txt", sep="")
colnames (dat_train_subj_train)  = c("subject_id") #an ID for every subject/person
dat_train_X_train = read.table("train/X_train.txt", sep="")
colnames (dat_train_X_train) = c( as.character(dat_features[,2]) )  #   Part of answer 4
dat_train_Y_train = read.table("train/Y_train.txt", sep="")
colnames (dat_train_Y_train) = c( "activity_id" )                   #   Part of answer 4

#   merging the fetched TRAINING data and free the unused datbytes
dat_train = dat_train_subj_train
dat_train[ , 2] = dat_train_Y_train
dat_train[ , 3:(3+561)] = dat_train_X_train
rm ( dat_train_subj_train, dat_train_Y_train, dat_train_X_train)

#   merges the TRAINING & TESTING data
dat_merged = rbind ( dat_test, dat_train )
rm ( dat_test, dat_train) # free unused memory 

################################################################################
#   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
################################################################################

#   Please note that column 1 & 2 means do not convey any meaning
#   Reason: The first is subject ID, second is Activity code
#   They have been maintained assuming that this list may be used for performing some actions on merged data
mean_for_each_easurement = colMeans ( dat_merged )
sd_for_each_easurement = apply(dat_merged, 2, sd)

################################################################################
#   3. Uses descriptive activity names to name the activities in the data set
################################################################################

#change the name of the column so that both the data colum id match by activity_id
colnames ( dat_act_lbl ) = c ( "activity_id", "activity_name" )
dat_merged_with_act_details = join ( dat_merged, dat_act_lbl, "activity_id" ) 

################################################################################
#   4. Appropriately labels the data set with descriptive variable names. 
################################################################################

#   This has already been done in 1. Commented in part 1 as shown below
#   Part of answer 4

################################################################################
#   From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
################################################################################
tidy_data = table ( dat_merged_with_act_details$activity_name, dat_merged_with_act_details$subject_id)

tidy_data_avg_sample_of_each_activity = apply(tidy_data, 1, mean )
tidy_data_avg_sample_of_each_activity = as.numeric (formatC ( tidy_data_avg_sample_of_each_activity, digit = 4))
#   Average values of columns appeneded
tidy_data = cbind ( tidy_data, tidy_data_avg_sample_of_each_activity )

tidy_data_avg_subject_all_activity_samples  = apply(tidy_data, 2, mean )
tidy_data_avg_subject_all_activity_samples = as.numeric (formatC ( tidy_data_avg_subject_all_activity_samples, digit= 4))
#   Average values of rows appeneded
tidy_data = rbind ( tidy_data, tidy_data_avg_subject_all_activity_samples )

#   Write data into a file
write.table(tidy_data, "tidy_data.txt", sep=" ", row.name=FALSE)
